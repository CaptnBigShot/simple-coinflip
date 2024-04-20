import Foundation

enum CoinflipResult: String {
    case Unflipped = "Unflipped"
    case Heads = "Heads"
    case Tails = "Tails"
    
    var description : String {
        return rawValue
    }
}
