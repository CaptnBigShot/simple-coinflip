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
                Spacer()
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "brain.head.profile")
                                .imageScale(.small)
                                .accessibilityIdentifier("TotalHeadsCountIcon")
                            Text(sessionStats.headsCount.description)
                                .accessibilityIdentifier("TotalHeadsCount")
                        }.font(.largeTitle)
                    }
                }.frame(alignment: .topLeading)
                
                VStack {
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .font(.largeTitle)
                        .accessibilityIdentifier("CoinflipResult")
                }.frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Group {
                            Image(systemName: "cat")
                                .imageScale(.small)
                                .accessibilityIdentifier("TotalTailsCountIcon")
                            Text(sessionStats.tailsCount.description)
                                .accessibilityIdentifier("TotalTailsCount")
                        }.font(.largeTitle)
                    }
                }.frame(alignment: .topTrailing)
                Spacer()
            }
        }.scaledToFit()
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