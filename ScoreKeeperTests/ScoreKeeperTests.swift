//
//  ScoreKeeperTests.swift
//  ScoreKeeperTests
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 11/02/26.
//

import Testing
@testable import ScoreKeeper

struct ScoreKeeperTests {
    
    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetScores(to newValue: Int) throws {
    
        /// Arrange
        var scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 5), ])
        
        /// Act
        scoreboard.resetScores(to: newValue)
        
        /// Assert
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }
}
