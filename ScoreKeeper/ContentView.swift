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
        VStack(alignment: .leading) {
            appTitle
                .padding(.bottom)
            
            playersGrid
                .padding(.vertical)

            Spacer()
            addPlayerButton
        }
        .padding()
    }
    
    // MARK: - ViewBuilder
    
    private var appTitle: some View {
        Text("Score Keeper")
            .font(.title)
            .bold()
    }
    
    private var playersGrid: some View {
        Grid {
            
            GridRow {
                Text("Player")
                    .gridColumnAlignment(.leading)
                Text("Score")
            }
            .font(.headline)

            ForEach($players) { $player in
                GridRow {
                    TextField("Name", text: $player.name)
                    
                    Text("\(player.score)")
                    Stepper("", value: $player.score)
                        .labelsHidden()
                }
            }
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
