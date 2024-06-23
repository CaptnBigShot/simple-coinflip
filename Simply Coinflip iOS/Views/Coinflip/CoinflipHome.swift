import SwiftUI

struct CoinflipHome: View {
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
                .fill(AnyShapeStyle(coin.getCoinColor(isShowingText: isShowingText)))
                .stroke(Color.white, lineWidth:2)
                .scaleEffect(isShowingText ? 1 : 2.7)
                .animation(
                    flipAnimation,
                    value: coin.wasFlipped()
                )
                .blur(radius: (1) * 20)
                .frame(width: .infinity, height: .infinity)
                .padding(.top, -20)
                .padding(.horizontal, 20)
            
            if (isShowingText) {
                Text(Image(systemName: coin.getCoinImage(isShowingText: isShowingText)))
                    .font(.system(size: 70))
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
