import SwiftUI

struct ContentView: View {
    @State private var coin = Coin()
    @StateObject private var sessionStats = CoinflipStats()
    @State private var isShowingText = true
    
    func flipCoin () -> Void {
        coin.flip()
        sessionStats.addCoinflip(coin: coin)
    }
    
    var flipAnimation: Animation {
        Animation.easeInOut(duration: 1)
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .fill(!isShowingText ? Color.white : coin.result == CoinflipResult.Heads ? Color.yellow : Color.orange)
                .stroke(Color.white, lineWidth:2)
                .scaleEffect(isShowingText ? 1 : 2.5)
                .animation(
                    flipAnimation,
                    value: coin.wasFlipped()
                )
                .blur(radius: (1) * 20)
                .frame(width: .infinity, height: .infinity)
                .padding(.top, -20)
            
            
            VStack() {
                HStack(
                    alignment: .top,
                    spacing: 15
                ) {
                    if (isShowingText) {
                        if (sessionStats.totalCount > 1) {
                            VStack {
                                Image(systemName: "brain.head.profile")
                                    .accessibilityIdentifier("TotalHeadsCountIcon")
                                Text(sessionStats.headsCount.description)
                                    .accessibilityIdentifier("TotalHeadsCount")
                            }
                        }
                        
                        if (coin.wasFlipped()) {
                            Text("It's " + coin.result.description + "!")
                                .accessibilityIdentifier("CoinflipResult")
                        }
                        
                        if (sessionStats.totalCount > 1) {
                            VStack {
                                Image(systemName: "cat")
                                    .accessibilityIdentifier("TotalTailsCountIcon")
                                Text(sessionStats.tailsCount.description)
                                    .accessibilityIdentifier("TotalTailsCount")
                            }
                        }
                        
                    }
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                Spacer(minLength: 20)
                
                if (isShowingText) {
                    Text(coin.result == CoinflipResult.Heads ? Image(systemName: "brain.head.profile") : Image(systemName: "cat"))
                        .font(.title)
                        .opacity(1)
                        .frame(alignment: .center)
                        .accessibilityIdentifier("CoinflipResultIcon")
                }
                
                Spacer(minLength: 20)
                
                if (isShowingText) {
                    Button(action: {
                        withAnimation {
                            isShowingText.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation {
                                isShowingText.toggle()
                            }
                        }
                        flipCoin()
                    }, label: {
                        Text("Flip a coin")
                            .accessibilityIdentifier("FlipCoinButton")
                    }).frame(maxHeight: .infinity, alignment: .bottom)
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
