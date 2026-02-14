//
//  Player.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 27/01/26.
//

import Foundation
import SwiftUI

struct Player: Identifiable {
    let id = UUID()
    
    var name: String
    var score: Int
    
    let randomColor: Color = [.red, .blue, .yellow, .orange, .purple].randomElement()!
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.name == rhs.name
        && lhs.score == rhs.score
    }
}
