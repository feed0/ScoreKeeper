//
//  SettingsView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 12/02/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var startingPoints: Int
    @Binding var doesHighestScoreWin: Bool
    @Binding var maxRounds: Int
    
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
    
    private var winConditionPicker: some View {
        Picker("Win condition", selection: $doesHighestScoreWin) {
            Text("Highest Score")
                .tag(true)
            Text("Lowest Score")
                .tag(false)
        }
    }
    
    private var startingPointsPicker: some View {
        Picker("Starting points", selection: $startingPoints) {
            Text("0 points")
                .tag(0)
            Text("10 points")
                .tag(10)
            Text("20 points")
                .tag(20)
        }
    }
    
    private var maxRoundsStepper: some View {
        Stepper("\(maxRounds)", value: $maxRounds, in: 1...99)
            .foregroundStyle(.blue)
    }
}

// MARK: - Preview

#Preview {
    @Previewable @State var startingPoints = 10
    @Previewable @State var doesHighestScoreWin = true
    @Previewable @State var maxRounds = 99
    
    SettingsView(
        startingPoints: $startingPoints,
        doesHighestScoreWin: $doesHighestScoreWin,
        maxRounds: $maxRounds)
}
