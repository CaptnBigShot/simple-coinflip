import SwiftUI

struct CoinflipCoin: View {
    var coin: Coin
    var isShowingText = true
    var deviceType = currentDeviceType()
    var isSideways = isPhoneSideways()
    
    var flipAnimation: Animation {
        Animation.easeInOut(duration: 1)
    }
    
    var body: some View {
        ZStack() {
            Circle()
                .fill(AnyShapeStyle(coin.getCoinColor(isShowingText: isShowingText)))
                .stroke(Color.white, lineWidth: 2)
                .scaleEffect(isShowingText ? 1 : 2.7)
                .animation(
                    flipAnimation,
                    value: coin.wasFlipped()
                )
                .blur(radius: (1) * 20)
                .padding(.top, isSideways ? 20 : -20)
                .padding(.horizontal, 20)
            
            if (isShowingText) {
                Text(Image(systemName: coin.getCoinImage(isShowingText: isShowingText)))
                    .font(deviceType == "Apple Watch" ? .largeTitle : .system(size: 70))
                    .opacity(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.top, isSideways ? 20 : -20)
                    .accessibilityIdentifier("CoinflipResultIcon")
            }
        }.frame(maxWidth: 500)
    }
}



#Preview {
    var coin = Coin()
    let isShowingText = true
    
    return CoinflipCoin(coin: coin, isShowingText: isShowingText)
}
