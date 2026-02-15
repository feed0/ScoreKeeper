//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 12/02/26.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @Binding var startingPoints: Int
    @Binding var doesHighestScoreWin: Bool
    @Binding var maxRounds: Int
    @Binding var winningScore: Int
    
    // MARK: Computed properties
    
    private var winningScoreRange: ClosedRange<Int> {
        if doesHighestScoreWin {
            (startingPoints+1)...99
        } else {
            0...(startingPoints > 1 ? startingPoints-1 : 0)
        }
    }
    
    private var isUnplayableConfiguration: Bool {
        startingPoints == 0
        && !doesHighestScoreWin
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            
            headerText
            
            Divider()
            
            Grid {
                GridRow {
                    Text("Starting points:")
                    startingPointsPicker
                }
                GridRow {
                    Text("Win condition:")
                    winConditionPicker
                }
                GridRow {
                    Text("Max rounds:")
                    maxRoundsStepper
                        .padding(.leading, 80)
                }
                GridRow {
                    Text("Winning score:")
                    winningScoreStepper
                        .padding(.leading, 80)
                }
                .gridColumnAlignment(.trailing)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
    
    // MARK: - ViewBuilder
    
    private var headerText: some View {
        Text("Game Rules")
            .font(.headline)
    }
    
    // MARK: Atoms
    
    private var startingPointsPicker: some View {
        Picker("Starting points", selection: $startingPoints) {
            Text("0 points")
                .tag(0)
            Text("10 points")
                .tag(10)
            Text("20 points")
                .tag(20)
        }
        .border(isUnplayableConfiguration ? .red : .clear)
    }
    
    private var winConditionPicker: some View {
        Picker("Win condition", selection: $doesHighestScoreWin) {
            Text("Highest Score")
                .tag(true)
            Text("Lowest Score")
                .tag(false)
        }
        .border(isUnplayableConfiguration ? .red : .clear)
    }
        
    private var maxRoundsStepper: some View {
        Stepper("\(maxRounds)", value: $maxRounds, in: 1...99)
            .foregroundStyle(.blue)
    }
    
    private var winningScoreStepper: some View {
        Stepper(
            "\(winningScore)",
            value: $winningScore,
            in: winningScoreRange)
        .foregroundStyle(.blue)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var startingPoints = 10
    @Previewable @State var doesHighestScoreWin = true
    @Previewable @State var maxRounds = 99
    @Previewable @State var winningScore = 10
    
    SettingsView(
        startingPoints: $startingPoints,
        doesHighestScoreWin: $doesHighestScoreWin,
        maxRounds: $maxRounds,
        winningScore: $winningScore)
}
