//
//  GameStateButtonsView.swift
//  ScoreKeeper
//
//  Created by Felipe Eduardo Campelo Ferreira Osorio on 13/02/26.
//

import SwiftUI

struct GameStateButtonsView: View {
    
    // MARK: - Properties
    
    let state: GameState
    let onStart: () -> Void
    let onEnd: () -> Void
    let onReset: () -> Void
    
    var title: String
    var systemImage: String
    var action: () -> Void
    
    // MARK: - Init
    
    init(state: GameState,
         onStart: @escaping () -> Void,
         onEnd: @escaping () -> Void,
         onReset: @escaping () -> Void) {
            
            self.state = state
            self.onStart = onStart
            self.onEnd = onEnd
            self.onReset = onReset
            
            switch state {
            case .setup:
                title = "Start game"
                systemImage = "play.fill"
                action = { onStart() }
            case .playing:
                title = "End Game"
                systemImage = "stop.fill"
                action = { onEnd() }
            case .gameOver:
                title = "Reset Game"
                systemImage = "arrow.counterclockwise"
                action = { onReset() }
            }
    }

    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: systemImage)
        }
        .buttonStyle(GlassButtonStyle())
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .tint(.blue)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: 20) {
        GameStateButtonsView(state: .setup, onStart: {}, onEnd: {}, onReset: {})
        GameStateButtonsView(state: .playing, onStart: {}, onEnd: {}, onReset: {})
        GameStateButtonsView(state: .gameOver, onStart: {}, onEnd: {}, onReset: {})
    }
}
