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
            playersNavigationView
            
            Spacer()
            
            addPlayerButton
        }
        .padding()
    }
    
    // MARK: - ViewBuilder
        
    private var playersNavigationView: some View {
        NavigationView {
            List {
                ForEach($players) { $player in

                    /// Player
                    HStack {
                        
                        /// Player name
                        TextField("Name", text: $player.name)
                        
                        /// Player score
                        Text("\(player.score)")
                        Stepper("", value: $player.score)
                            .labelsHidden()
                    }
                    .foregroundStyle(player.randomCoulour)
                }
                /// Toolbar options: `onDelete` and `onMove` when `EditButton`
                .onDelete { players.remove(atOffsets: $0) }
                .onMove { players.move(fromOffsets: $0, toOffset: $1) }
            }
            .navigationTitle("Score Keeper")
            .toolbar {
                EditButton()
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
