import Foundation
import SwiftUI

public struct Coin {
    var result: CoinflipResult
    
    init() {
        self.result = CoinflipResult.Unflipped
    }
    
    mutating func flip() -> Void {
        self.result = Bool.random() ? CoinflipResult.Heads : CoinflipResult.Tails
    }
    
    func wasFlipped() -> Bool {
        return self.result != CoinflipResult.Unflipped
    }
    
    func getCoinColor(isShowingText: Bool) -> any ShapeStyle {
        let defaultColor = LinearGradient(
            colors: [.teal, .indigo],
            startPoint: .top,
            endPoint: .bottom
        )
        
        let headsColor = LinearGradient(
            colors: [.yellow, .orange],
            startPoint: .top,
            endPoint: .bottom
        )
        
        let tailsColor = LinearGradient(
            colors: [.mint, .green],
            startPoint: .top,
            endPoint: .bottom
        )
        
        if (!isShowingText) {
            return defaultColor
        }
        
        if (self.result == CoinflipResult.Heads) {
            return headsColor
        }
        
        if (self.result == CoinflipResult.Tails) {
            return tailsColor
        }
        
        return defaultColor
    }
    
    func getCoinImage(isShowingText: Bool) -> String {
        if (!isShowingText) {
            return ""
        }
        
        if (self.result == CoinflipResult.Heads) {
            return "brain.head.profile"
        }
        
        if (self.result == CoinflipResult.Tails) {
            return "cat"
        }
        
        return "centsign.circle"
    }
}
