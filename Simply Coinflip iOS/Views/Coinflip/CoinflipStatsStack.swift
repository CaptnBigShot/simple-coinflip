import SwiftUI

struct CoinflipStatsStack: View {
    var coin: Coin
    var sessionStats: CoinflipStats
    var isShowingText: Bool
    var deviceType = currentDeviceType()
    var isSideways = isPhoneSideways()

    var body: some View {
        let font = (deviceType == "Apple Watch" ? Font.body : Font.largeTitle)
        
        HStack(
            alignment: .top,
            spacing: 0
        ) {
            if (isShowingText) {
                Spacer()
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "brain.head.profile")
                                .imageScale(.small)
                                .accessibilityIdentifier("TotalHeadsCountIcon")
                            Text(sessionStats.headsCount.description)
                                .accessibilityIdentifier("TotalHeadsCount")
                        }
                    }
                }.frame(alignment: .topLeading).padding(isSideways ? 20 : 0)
                
                VStack {
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .accessibilityIdentifier("CoinflipResult")
                }.frame(maxWidth: .infinity, alignment: .center).padding(isSideways ? 20 : 0)
                
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "cat")
                                .imageScale(.small)
                                .accessibilityIdentifier("TotalTailsCountIcon")
                            Text(sessionStats.tailsCount.description)
                                .accessibilityIdentifier("TotalTailsCount")
                        }
                    }
                }.frame(alignment: .topTrailing).padding(isSideways ? 20 : 0)
                Spacer()
            }
        }.font(font)
            .scaledToFit()
            .minimumScaleFactor(0.01)
            .lineLimit(1)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    var coin = Coin()
    coin.result = CoinflipResult.Heads
    
    var sessionStats = CoinflipStats()
    sessionStats.headsCount = 1
    sessionStats.tailsCount = 2
    
    let isShowingText = true
    
    return CoinflipStatsStack(coin: coin, sessionStats: sessionStats, isShowingText: isShowingText)
}
