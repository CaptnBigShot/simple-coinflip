import SwiftUI

struct CoinflipHome: View {
    @State private var coin = Coin()
    @StateObject private var sessionStats = CoinflipStats()
    @State private var isShowingText = true
    
    func flipCoin () -> Void {
        coin.flip()
        sessionStats.addCoinflip(coin: coin)
    }
    
    var body: some View {
        ZStack() {
            CoinflipCoin(coin: coin, isShowingText: isShowingText)
            CoinflipStatsStack(coin: coin, sessionStats: sessionStats, isShowingText: isShowingText)
        }.onTapGesture {
            withAnimation {
                isShowingText.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    isShowingText.toggle()
                }
            }
            flipCoin()
        }
        .background(Color.black)
        .foregroundStyle(
            Color.white
        )
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):  print("left swipe")
                    case (0..., -30...30):  print("right swipe")
                    case (-100...100, ...0):  print("up swipe")
                    case (-100...100, 0...):  print("down swipe")
                    default:  print("no clue")
                }
                coin = Coin()
                sessionStats.resetStats()
            }
        )
    }
}

#Preview {
    return CoinflipHome()
}
