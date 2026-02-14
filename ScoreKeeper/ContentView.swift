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
    @State private var startingPoints = 0
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                settingsView
                playersList
                Spacer()
                
                HStack() {
                    Spacer()
                    gameStateButtonsView
                    Spacer()
                }
            }
            .padding()
        }
    }
    
    // MARK: - ViewBuilder
    
    private var settingsView: some View {
        SettingsView(
            startingPoints: $startingPoints,
            doesHighestScoreWin: $scoreboard.doesHighestScoreWin)
        .disabled(scoreboard.state != .setup)
    }
    
    private var playersList: some View {
        List {
            HStack {
                playerNameHeaderText
                Spacer()
                scoreCountText
                Spacer()
            }
            
            ForEach($scoreboard.players) { $player in
                
                HStack {
                    
                    if isWinner(for: player) {
                        winnerCrownIcon
                    }
                    
                    playerNameTextField(
                        playerName: $player.name)
                    
                    playerScoreText(
                        playerScore: player.score)
                    
                    playerScoreStepper(
                        playerScore: $player.score)
                }
                .foregroundStyle(player.randomColor)
            }
            .onDelete { removePlayer(atOffsets: $0) }
            .onMove { movePlayer(
                fromOffsets: $0,
                toOffset: $1) }
            
            addPlayerButton
        }
        .navigationTitle("Score Keeper")
        .toolbar {
            EditButton()
        }
    }
    
    private var gameStateButtonsView: some View {
        GameStateButtonsView(
            state: scoreboard.state,
            onStart: { handleStartGame() },
            onEnd: { handleEndGame() },
            onReset: { handleResetGame() } )
    }
    
    // MARK: - Atoms
        
    // MARK: Players list
    
    private var playerNameHeaderText: some View {
        Text("name")
    }
    
    private var scoreCountText: some View {
        Text("score")
            .opacity(scoreboard.state == .setup ? 0 : 1.0)
    }
        
    private var winnerCrownIcon: some View {
        Image(systemName: "crown.fill")
            .foregroundStyle(Color.yellow)
    }
    
    private func playerNameTextField(playerName: Binding<String>) -> some View {
        TextField("Name", text: playerName)
            .disabled(scoreboard.state != .setup)
    }
    
    private func playerScoreText(playerScore: Int) -> some View {
        Text("\(playerScore)")
            .opacity(scoreboard.state == .setup ? 0 : 1.0)
    }
    
    private func playerScoreStepper(playerScore: Binding<Int>) -> some View {
        let scoreBoundaries = 0...20
        
        return Stepper("",
            value: playerScore,
            in: scoreBoundaries)
        .labelsHidden()
        .disabled(scoreboard.state != .playing)
        .opacity(scoreboard.state == .setup ? 0 : 1.0)
    }
    
    private var addPlayerButton: some View {
        Button("add player", systemImage: "plus") {
            scoreboard.players.append(Player(name: "", score: 0))
        }
        .buttonStyle(GlassButtonStyle())
        .opacity(scoreboard.state == .setup ? 1.0 : 0)
    }
    
    // MARK: - Private funcs
    
    // MARK: Player
    
    private func isWinner(for player: Player) -> Bool {
        scoreboard.winners.contains(player)
    }
    
    // MARK: Toolbar edit list
    
    private func removePlayer(atOffsets offsets: IndexSet) {
        scoreboard.players.remove(atOffsets: offsets)
    }
    
    private func movePlayer(
        fromOffsets source: IndexSet,
        toOffset destination: Int) {
            
        scoreboard.players.move(
            fromOffsets: source,
            toOffset: destination)
    }
    
    // MARK: Game state buttons
    
    private func handleStartGame() {
        scoreboard.state = .playing
        scoreboard.resetScores(to: startingPoints)
    }
    
    private func handleEndGame() {
        scoreboard.state = .gameOver
    }
    
    private func handleResetGame() {
        scoreboard.state = .setup
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
