import XCTest

final class coinflip_Watch_AppUITests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlipCoin() throws {
        let app = XCUIApplication()
        app.launch()

        let flipCoinBtn = app.buttons["FlipCoinButton"]
        XCTAssertTrue(flipCoinBtn.exists)
        flipCoinBtn.tap()
        
        let coinflipResultIcon = app.staticTexts["CoinflipResultIcon"]
        XCTAssertTrue(coinflipResultIcon.waitForExistence(timeout: 3))
        
        let coinflipResultText = app.staticTexts["CoinflipResult"]
        XCTAssertTrue(coinflipResultText.exists)
        XCTAssert(coinflipResultText.label == "It's Heads!" || coinflipResultText.label == "It's Tails!")
    }
    
    func testCoinFlipSessionStats() throws {
        let app = XCUIApplication()
        app.launch()

        let flipCoinBtn = app.buttons["FlipCoinButton"]
        
        flipCoinBtn.tap()
        
        let headsCountIcon = app.images["TotalHeadsCountIcon"]
        XCTAssertFalse(headsCountIcon.exists)
        let headsCountText = app.staticTexts["TotalHeadsCount"]
        XCTAssertFalse(headsCountText.exists)
        
        let tailsCountIcon = app.images["TotalTailsCountIcon"]
        XCTAssertFalse(tailsCountIcon.exists)
        let tailsCountText = app.staticTexts["TotalTailsCount"]
        XCTAssertFalse(tailsCountText.exists)
        
        flipCoinBtn.tap()
        
        XCTAssertTrue(headsCountIcon.waitForExistence(timeout: 5))
        XCTAssertTrue(headsCountText.exists)
        XCTAssertTrue(tailsCountIcon.exists)
        XCTAssertTrue(tailsCountText.exists)
        
        let headsCount = Int(headsCountText.label) ?? Int.min
        let tailsCount = Int(tailsCountText.label) ?? Int.max
        let totalCount = headsCount + tailsCount
        XCTAssertEqual(totalCount, 2)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
