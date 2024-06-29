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
        let font = (deviceType == "Apple Watch" ? Font.largeTitle : Font.system(size: 70))
        
        ZStack() {
            Circle()
                .fill(AnyShapeStyle(coin.getCoinColor(isShowingText: isShowingText)))
                .stroke(Color.white, lineWidth: 2)
                .scaleEffect(isShowingText ? 1 : 2.8)
                .animation(
                    flipAnimation,
                    value: coin.wasFlipped()
                )
                .blur(radius: (1) * 20)
                .padding(.top, isSideways ? 20 : -20)
                .padding(.horizontal, 20)
            
            if (isShowingText) {
                Text(Image(systemName: coin.getCoinImage(isShowingText: isShowingText)))
                    .opacity(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.top, isSideways ? 20 : -20)
                    .accessibilityIdentifier("CoinflipResultIcon")
            }
        }.font(font)
            .frame(maxWidth: 500)
    }
}



#Preview {
    var coin = Coin()
    let isShowingText = true
    
    return CoinflipCoin(coin: coin, isShowingText: isShowingText)
}
