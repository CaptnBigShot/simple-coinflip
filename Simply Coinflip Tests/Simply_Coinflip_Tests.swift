import XCTest
@testable import Simply_Coinflip

final class Simply_Coinflip_Tests: XCTestCase {
    func testFlipCoin() throws {
        var coin = Coin()
        XCTAssertEqual(coin.result, CoinflipResult.Unflipped)
        XCTAssertFalse(coin.wasFlipped())
        
        coin.flip()
        XCTAssert(coin.result == CoinflipResult.Heads || coin.result == CoinflipResult.Tails)
        XCTAssertTrue(coin.wasFlipped())
    }
    
    func testCoinflipStats() throws {
        let coinflipStats = CoinflipStats()
        XCTAssertEqual(coinflipStats.headsCount, 0)
        XCTAssertEqual(coinflipStats.tailsCount, 0)
        XCTAssertEqual(coinflipStats.totalCount, 0)
        
        // Add an Unflipped coinflip result
        let coinUnflipped = Coin()
        coinflipStats.addCoinflip(coin: coinUnflipped)
        XCTAssertEqual(coinflipStats.headsCount, 0)
        XCTAssertEqual(coinflipStats.tailsCount, 0)
        XCTAssertEqual(coinflipStats.totalCount, 0)
        
        // Add a Heads coinflip result
        var coinHeads = Coin()
        coinHeads.result = CoinflipResult.Heads
        coinflipStats.addCoinflip(coin: coinHeads)
        XCTAssertEqual(coinflipStats.headsCount, 1)
        XCTAssertEqual(coinflipStats.tailsCount, 0)
        XCTAssertEqual(coinflipStats.totalCount, 1)
        
        // Add a Tails coinflip result
        var coinTails = Coin()
        coinTails.result = CoinflipResult.Tails
        coinflipStats.addCoinflip(coin: coinTails)
        XCTAssertEqual(coinflipStats.headsCount, 1)
        XCTAssertEqual(coinflipStats.tailsCount, 1)
        XCTAssertEqual(coinflipStats.totalCount, 2)
    }
}
