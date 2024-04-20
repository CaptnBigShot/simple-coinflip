import SwiftUI

struct ContentView: View {
    @State private var coin = Coin()
    @StateObject private var sessionStats = CoinflipStats()
    
    func flipCoin () -> Void {
        coin.flip()
        sessionStats.addCoinflip(coin: coin)
    }
    
    var body: some View {
        if (coin.wasFlipped()) {
            Text("It's " + coin.result.description + "!")
        }
        
        if (sessionStats.totalCount > 1) {
            HStack(
                alignment: .top,
                spacing: 15
            ){
                HStack {
                    Image(systemName: "brain.head.profile")
                    Text(sessionStats.headsCount.description)
                }
                HStack {
                    Image(systemName: "cat")
                    Text(sessionStats.tailsCount.description)
                }
            }.frame(maxHeight: .infinity, alignment: .bottom)

        }
        
        Button(action: flipCoin, label: {
            Text("Flip a coin")
        }).frame(maxHeight: .infinity, alignment: .bottom)
    }
}

#Preview {
    ContentView()
}
