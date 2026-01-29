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
    
    let randomCoulour: Color = [.red, .blue, .yellow, .orange, .purple].randomElement()!
}
