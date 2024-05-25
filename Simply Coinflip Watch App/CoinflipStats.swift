import Foundation

class CoinflipStats: ObservableObject {
    @Published var headsCount: Int
    @Published var tailsCount: Int
    
    init() {
        self.headsCount = 0
        self.tailsCount = 0
    }
    
    func addCoinflip(coin: Coin) -> Void {
        if (coin.result == CoinflipResult.Heads) {
            self.headsCount += 1
        } else if (coin.result == CoinflipResult.Tails) {
            self.tailsCount += 1
        }
    }
    
    var totalCount: Int {
        return headsCount + tailsCount
    }
    
    func resetStats() -> Void {
        headsCount = 0
        tailsCount = 0
    }
}
