import Foundation

infix operator -->
infix operator <--

class Deck : NSObject {
    static let allSpades :[Card] = Value.allValues.map {
        (number) -> Card in
        return Card(color: .pique, value: number)
    }

    static let allDiamonds : [Card] = Value.allValues.map({Card(color: .carreau, value: $0)})

    static let allHeart : [Card] = Value.allValues.map({Card(color: .coeur,value: $0)})

    static let allClubs : [Card] = Value.allValues.map({Card(color:.trefle, value:$0)})

    static var allCards : [Card] = Deck.allSpades + Deck.allHeart + Deck.allDiamonds + Deck.allClubs

    var cards : [Card] = Deck.allCards

    var discard : [Card] = []

    var outs : [Card] = []

    init(_ sort: Bool) {
        sort ? self.cards.shuffle() : ();
        super.init()
    }

    override var description: String{return "\(self.cards)"}

    var length: Int{return self.cards.count}
    var dlength: Int{return self.discard.count}
    var olength: Int{return self.outs.count}

    func draw () -> Card? {
        if self.cards.count > 0 {
            let card: Card? = self.cards.removeFirst()
            self.outs.append(card!)
            return card
        }
        return nil
    }

    static func --> (_ left: Deck , _ right: Card) {
        left.discard.append(right)
    }
    static func <-- (_ left: Deck , _ right: Card) {
        left.outs.removeAll(where: { element in (right == element) })
    }

    func fold (card: Card) {
        self.outs.contains(card) ? {
            self --> card
            self <-- card
            }() : {print("cant fold, card `\(card)` : not in outs")}()
    }
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
