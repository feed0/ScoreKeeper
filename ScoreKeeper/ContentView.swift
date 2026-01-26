//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 26/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var players: [String] = ["Andre", "Bruna", "Carla"]
    @State private var scores: [Int] = [0, 0, 0]
    
    var body: some View {
        VStack {
            playersList
            Spacer()
            addPlayerButton
        }
        .padding()
    }
    
    // MARK: - ViewBuilder
    
    private var playersList: some View {
        ForEach(0..<players.count, id: \.description) { index in
            
            TextField("Name", text: $players[index])
            Stepper("\(scores[index])", value: $scores[index])
        }
    }
    
    private var addPlayerButton: some View {
        Button("Add player", systemImage: "plus") {
            players.append("")
            scores.append(0)
        }
    }
}

#Preview {
    ContentView()
}
