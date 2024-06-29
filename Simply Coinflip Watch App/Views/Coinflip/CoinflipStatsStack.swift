import SwiftUI

struct CoinflipStatsStack: View {
    var coin: Coin
    var sessionStats: CoinflipStats
    var isShowingText: Bool
    
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 0
        ) {
            if (isShowingText) {
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "brain.head.profile")
                                .accessibilityIdentifier("TotalHeadsCountIcon")
                            Text(sessionStats.headsCount.description)
                                .accessibilityIdentifier("TotalHeadsCount")
                        }
                    }
                }.frame(alignment: .topLeading)
                
                VStack {
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .accessibilityIdentifier("CoinflipResult")
                }.frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "cat")
                                .accessibilityIdentifier("TotalTailsCountIcon")
                            Text(sessionStats.tailsCount.description)
                                .accessibilityIdentifier("TotalTailsCount")
                        }
                    }
                }.frame(alignment: .topTrailing)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
