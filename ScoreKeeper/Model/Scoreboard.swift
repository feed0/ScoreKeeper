//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 10/02/26.
//

import Foundation

struct Scoreboard {
    
    // MARK: - Porperties
    
    internal var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    
    internal var state = GameState.setup
    
    internal var doesHighestScoreWin = true
    
    internal var winners: [Player] {
        guard state == .gameOver else { return [] }
        
        var winningScore = 0
        if doesHighestScoreWin {
            /// max score
            winningScore = Int.min
            for player in players {
                winningScore = max(player.score, winningScore)
            }
        } else {
            /// min score
            winningScore = Int.max
            for player in players {
                winningScore = min(player.score, winningScore)
            }
        }
        
        /// filter for winners
        return players.filter { player in
            player.score == winningScore
        }
    }
    
    // MARK: - Methods
    
    internal mutating func resetScores(to newValue: Int) {
        for index in 0..<players.count {
            players[index].score = newValue
        }
    }
}
