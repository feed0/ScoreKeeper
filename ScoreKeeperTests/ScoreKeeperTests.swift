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
    
    @Test("Highest score wins")
    func highestScoreWins() {
        
        /// Arrange
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4), ],
            state: .gameOver,
            doesHighestScoreWin: true)
        
        /// Act
        let winners = scoreboard.winners

        /// Assert
        #expect(winners == [Player(name: "Andre", score: 4)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {
        
        /// Arrange
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4), ],
            state: .gameOver,
            doesHighestScoreWin: false)
        
        /// Act
        let winners = scoreboard.winners
        
        /// Assert
        #expect(winners == [Player(name: "Elisha", score: 0)])
    }
    
    @Test("There could be multiple winners", arguments: [true, false])
    func multipleWinners(when doesHighestScoreWin: Bool) {
        
        /// Arrange
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
                Player(name: "Felipe", score: 4),
                Player(name: "Bruna", score: 0), ],
            state: .gameOver,
            doesHighestScoreWin: doesHighestScoreWin)
        
        /// Act
        let winners = scoreboard.winners
        
        /// Assert
        if doesHighestScoreWin {
            #expect(scoreboard.winners.contains(
                [Player(name: "Andre", score: 4),
                 Player(name: "Felipe", score: 4),]))
        } else {
            #expect(scoreboard.winners.contains(
                [Player(name: "Elisha", score: 0),
                 Player(name: "Bruna", score: 0),]))
        }
    }
}
