import SwiftUI

struct CoinflipStatsStack: View {
    var coin: Coin
    var sessionStats: CoinflipStats
    var isShowingText: Bool
    
    var body: some View {
        VStack() {
            HStack(
                alignment: .top,
                spacing: 30
            ) {
                if (isShowingText) {
                    VStack {
                        if (sessionStats.totalCount > 1) {
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 30))
                                .accessibilityIdentifier("TotalHeadsCountIcon")
                            Text(sessionStats.headsCount.description)
                                .font(.system(size: 30))
                                .accessibilityIdentifier("TotalHeadsCount")
                        }
                    }
                    
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .font(.system(size: 30))
                        .accessibilityIdentifier("CoinflipResult")
                    
                    VStack {
                        if (sessionStats.totalCount > 1) {
                            Image(systemName: "cat")
                                .font(.system(size: 30))
                                .accessibilityIdentifier("TotalTailsCountIcon")
                            Text(sessionStats.tailsCount.description)
                                .font(.system(size: 30))
                                .accessibilityIdentifier("TotalTailsCount")
                        }
                    }
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                            
            Spacer(minLength: 20)
        }
    }
}

#Preview {
    var coin = Coin()
    coin.result = CoinflipResult.Heads
    
    var sessionStats = CoinflipStats()
    sessionStats.headsCount = 1
    sessionStats.tailsCount = 1
    
    let isShowingText = true
    
    return CoinflipStatsStack(coin: coin, sessionStats: sessionStats, isShowingText: isShowingText)
}
