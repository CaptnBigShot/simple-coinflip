import SwiftUI

struct ContentView: View {
    @State private var coin = Coin()
    @StateObject private var sessionStats = CoinflipStats()
    @State private var isShowingText = true
    
    func flipCoin () -> Void {
        coin.flip()
        sessionStats.addCoinflip(coin: coin)
    }
    
    func getCoinColor() -> Color {
        if (!isShowingText) {
            return Color.white
        }
        
        if (coin.result == CoinflipResult.Heads) {
            return Color.yellow
        }
        
        if (coin.result == CoinflipResult.Tails) {
            return Color.orange
        }
        
        return Color.cyan
    }
    
    func getCoinImage() -> String {
        if (!isShowingText) {
            return ""
        }
        
        if (coin.result == CoinflipResult.Heads) {
            return "brain.head.profile"
        }
        
        if (coin.result == CoinflipResult.Tails) {
            return "cat"
        }
        
        return "centsign.circle"
    }
    
    var flipAnimation: Animation {
        Animation.easeInOut(duration: 1)
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .fill(getCoinColor())
                .stroke(Color.white, lineWidth:2)
                .scaleEffect(isShowingText ? 1 : 2.5)
                .animation(
                    flipAnimation,
                    value: coin.wasFlipped()
                )
                .blur(radius: (1) * 20)
                .frame(width: .infinity, height: .infinity)
                .padding(.top, -20)
            
            if (isShowingText) {
                Text(Image(systemName: getCoinImage()))
                    .font(.title)
                    .opacity(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .accessibilityIdentifier("CoinflipResultIcon")
            }
            
            VStack() {
                HStack(
                    alignment: .top,
                    spacing: 15
                ) {
                    if (isShowingText) {
                        VStack {
                            if (sessionStats.totalCount > 1) {
                                Image(systemName: "brain.head.profile")
                                    .accessibilityIdentifier("TotalHeadsCountIcon")
                                Text(sessionStats.headsCount.description)
                                    .accessibilityIdentifier("TotalHeadsCount")
                            }
                        }
                        
                        Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                            .accessibilityIdentifier("CoinflipResult")
                        
                        VStack {
                            if (sessionStats.totalCount > 1) {
                                Image(systemName: "cat")
                                    .accessibilityIdentifier("TotalTailsCountIcon")
                                Text(sessionStats.tailsCount.description)
                                    .accessibilityIdentifier("TotalTailsCount")
                            }
                        }
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                                
                Spacer(minLength: 20)
            }
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
    ContentView()
}
