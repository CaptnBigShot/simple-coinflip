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
        if (!isShowingText) {
            return Color.white
        }
        
        if (self.result == CoinflipResult.Heads) {
            return LinearGradient(
                colors: [.yellow, .orange],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        
        if (self.result == CoinflipResult.Tails) {
            return LinearGradient(
                colors: [.pink, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        
        return LinearGradient(
            colors: [.teal, .indigo],
            startPoint: .top,
            endPoint: .bottom
        )
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
