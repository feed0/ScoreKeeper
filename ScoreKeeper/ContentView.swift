//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 26/01/26.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var scoreboard = Scoreboard()
    
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
                
                /// Header
                HStack {
                    Text("Name")
                    Spacer()
                    Text("Score")
                    Spacer()
                }
                
                /// Players
                ForEach($scoreboard.players) { $player in

                    /// Player
                    HStack {
                        
                        /// Player name
                        TextField("Name", text: $player.name)
                        
                        /// Player score
                        let scoreBoundaries = 0...20
                        Text("\(player.score)")
                        Stepper("",
                                value: $player.score,
                                in: scoreBoundaries)
                            .labelsHidden()
                    }
                    .foregroundStyle(player.randomCoulour)
                }
                /// Toolbar options: `onDelete` and `onMove` when `EditButton`
                .onDelete { scoreboard.players.remove(atOffsets: $0) }
                .onMove { scoreboard.players.move(
                    fromOffsets: $0,
                    toOffset: $1) }
            }
            .navigationTitle("Score Keeper")
            .toolbar {
                EditButton()
            }
            
        }
        
    }
    
    private var addPlayerButton: some View {
        Button("Add player", systemImage: "plus") {
            scoreboard.players.append(Player(name: "", score: 0))
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
