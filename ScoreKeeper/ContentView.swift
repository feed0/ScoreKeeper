//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 26/01/26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var players: [Player] = [
        .init(name: "Andre", score: 0),
        .init(name: "Bruna", score: 0),
        .init(name: "Carla", score: 0)]
    
    // MARK: - Body
    
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
        ForEach($players) { $player in
            
            TextField("Name", text: $player.name)
            Stepper("\(player.score)", value: $player.score)
        }
    }
    
    private var addPlayerButton: some View {
        Button("Add player", systemImage: "plus") {
            players.append(.init(name: "", score: 0))
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
