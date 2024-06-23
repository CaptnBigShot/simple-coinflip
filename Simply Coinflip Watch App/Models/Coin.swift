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
    
    func getCoinColor(isShowingText: Bool) -> Color {
        if (!isShowingText) {
            return Color.white
        }
        
        if (self.result == CoinflipResult.Heads) {
            return Color.yellow
        }
        
        if (self.result == CoinflipResult.Tails) {
            return Color.orange
        }
        
        return Color.cyan
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
