import SwiftUI

struct CustomHStack: Layout {
  let widthWeights: [CGFloat]
  let spacing: CGFloat

  init(widthWeights: [CGFloat], spacing: CGFloat? = nil) {
    self.widthWeights = widthWeights
    self.spacing = spacing ?? .zero
  }

  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
    let maxHeight = subviews
      .map { proxy in
        return proxy.sizeThatFits(.unspecified).height
      }
      .max() ?? .zero

    return CGSize(width: proposal.width ?? .zero, height: maxHeight)
  }

  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
    let subviewSizes = subviews.map { proxy in
      return proxy.sizeThatFits(.infinity)
    }

    var x = bounds.minX
    let y = bounds.minY
    let parentTotalWith = (proposal.width ?? .zero) - (CGFloat((widthWeights.count - 1)) * spacing)

    for index in subviews.indices {
      let widthWeight = widthWeights[index]
      let proposedWidth = widthWeight * parentTotalWith

      let sizeProposal = ProposedViewSize(width: proposedWidth, height: subviewSizes[index].height)

      subviews[index]
        .place(
          at: CGPoint(x: x, y: y),
          anchor: .topLeading,
          proposal: sizeProposal
        )

      x += (proposedWidth + spacing)
    }
  }
}

struct Sample: View {
    var coin: Coin
    var sessionStats: CoinflipStats
    var isShowingText: Bool
    
    var body: some View {
        /*
        CustomHStack(widthWeights: [0.25, 0.50, 0.25]) {
            if (isShowingText) {
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Image(systemName: "brain.head.profile")
                            .accessibilityIdentifier("TotalHeadsCountIcon")
                        Text(sessionStats.headsCount.description)
                            .accessibilityIdentifier("TotalHeadsCount")
                    }
                }
                
                
                VStack {
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .font(.largeTitle)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .accessibilityIdentifier("CoinflipResult")
                }
                
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Image(systemName: "cat")
                            .font(.title3)
                            .accessibilityIdentifier("TotalTailsCountIcon")
                        Text(sessionStats.tailsCount.description)
                            .font(.title3)
                            .accessibilityIdentifier("TotalTailsCount")
                    }
                }
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
         */
        Grid(horizontalSpacing: 10, verticalSpacing: 0) {
            GridRow {
                VStack {
                    if (sessionStats.totalCount > 1) {
//                        Text("\(Image(systemName: "brain.head.profile"))\n\(sessionStats.headsCount.description)")
//                            .accessibilityIdentifier("TotalHeadsCount")
                        Group {
                            Image(systemName: "brain.head.profile")
                                .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                .accessibilityIdentifier("TotalHeadsCountIcon")
                            Text(sessionStats.headsCount.description)
                                .accessibilityIdentifier("TotalHeadsCount")
                        }
                    }
                }
                .gridCellColumns(3).frame(maxWidth: .infinity, alignment: .topLeading)
                VStack {
                    Text(coin.wasFlipped() ? "It's " + coin.result.description + "!" : " ")
                        .font(.largeTitle)
                        .scaledToFit()
                        .minimumScaleFactor(0.01)
                        .lineLimit(1)
                        .accessibilityIdentifier("CoinflipResult")
                }
                    .gridCellColumns(4)
                VStack {
                    if (sessionStats.totalCount > 1) {
                        Image(systemName: "cat")
                            .font(.title3)
                            .accessibilityIdentifier("TotalTailsCountIcon")
                        Text(sessionStats.tailsCount.description)
                            .font(.title3)
                            .accessibilityIdentifier("TotalTailsCount")
                    }
                }
                    .gridCellColumns(3)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    var coin = Coin()
    coin.result = CoinflipResult.Heads
    
    var sessionStats = CoinflipStats()
    sessionStats.headsCount = 1
    sessionStats.tailsCount = 1
    
    let isShowingText = true
    
    return Sample(coin: coin, sessionStats: sessionStats, isShowingText: isShowingText)
}
