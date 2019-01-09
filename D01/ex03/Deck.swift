import Foundation

class Deck : NSObject {
    static let allSpades :[Card] = Value.allValues.map {
        (number) -> Card in
        return Card(color: .pique, value: number)
    }
    
    static let allDiamonds : [Card] = Value.allValues.map({Card(color: .carreau, value: $0)})
    
    static let allHeart : [Card] = Value.allValues.map({Card(color: .coeur,value: $0)})
    
    static let allClubs : [Card] = Value.allValues.map({Card(color:.trefle, value:$0)})
    
    static let allCards : [Card] = Deck.allSpades + Deck.allHeart + Deck.allDiamonds + Deck.allClubs
}

extension Array where Element:Card {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }
}

extension Array {
        mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            self.swapAt(i, j)
        }
    }
}