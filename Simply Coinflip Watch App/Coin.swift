import Foundation

struct Coin {
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
}
