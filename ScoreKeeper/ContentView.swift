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
    
    @State private var maxRounds = 1
    @State private var currentRound = 1
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                headerTitle

                playersList
                
                Spacer()
                
                if scoreboard.state == .setup {
                    settingsView
                }
                
                HStack() {
                    Spacer()
                    gameStateButtonsView
                    
                    if scoreboard.state != .setup {
                        roundStepper
                    }
                    
                    Spacer()
                }
            }
            .padding()
        }
    }
    
    // MARK: - ViewBuilder
        
    private var headerTitle: some View {
        Text("Score Keeper")
            .font(.largeTitle)
            .bold()
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
            
            if scoreboard.state == .setup {
                addPlayerButton
            }
        }
        .toolbar {
            EditButton()
        }
    }
    
    private var settingsView: some View {
        SettingsView(
            startingPoints: $startingPoints,
            doesHighestScoreWin: $scoreboard.doesHighestScoreWin,
            maxRounds: $maxRounds)
        .disabled(scoreboard.state != .setup)
    }

    private var roundStepper: some View {
        Stepper("Round: \(currentRound)/\(maxRounds)",
                value: $currentRound, in: 1...99)
            .foregroundStyle(.blue)
            .disabled(currentRound > maxRounds)
            .onChange(of: currentRound) { oldValue, newValue in
                if newValue > maxRounds {
                    scoreboard.state = .gameOver
                }
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
        currentRound = 1
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
