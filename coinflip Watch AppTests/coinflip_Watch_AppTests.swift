import XCTest
@testable import coinflip_Watch_App

final class coinflip_Watch_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlipCoin() throws {
        var coin = Coin()
        XCTAssert(coin.wasFlipped() == false)
        
        coin.flip()
        XCTAssert(coin.wasFlipped() == true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
