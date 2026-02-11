//
//  Scoreboard.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 10/02/26.
//

import Foundation

struct Scoreboard {
    internal var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    
    internal var state = GameState.setup
    
    internal mutating func resetScores(to newValue: Int) {
        
    }
}
