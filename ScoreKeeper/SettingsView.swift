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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Game Rules")
                .font(.headline)
            
            Divider()
            
            Picker("Win condition", selection: $doesHighestScoreWin) {
                Text("Highest Score")
                    .tag(true)
                Text("Lowest Score")
                    .tag(false)
            }
            
            Picker("Starting points", selection: $startingPoints) {
                Text("0 points")
                    .tag(0)
                Text("10 points")
                    .tag(10)
                Text("20 points")
                    .tag(20)
            }
        }
        .padding()
        .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
    }
}

#Preview {
    @Previewable @State var startingPoints = 10
    @Previewable @State var doesHighestScoreWin = true
    
    SettingsView(
        startingPoints: $startingPoints,
        doesHighestScoreWin: $doesHighestScoreWin)
}
