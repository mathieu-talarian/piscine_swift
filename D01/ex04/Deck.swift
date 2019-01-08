class Deck : NSObject {
    static let allSpades :[Card] = Value.allValues.map {
        (number) -> Card in
        return Card(color: .pique, value: number)
    }

    static let allDiamonds : [Card] = Value.allValues.map({Card(color: .carreau, value: $0)})

    static let allHeart : [Card] = Value.allValues.map({Card(color: .coeur,value: $0)})

    static let allClubs : [Card] = Value.allValues.map({Card(color:.trefle, value:$0)})

    static var allCards : [Card] = Deck.allSpades + Deck.allHeart + Deck.allDiamonds + Deck.allClubs

    var cards = Deck.allCards

    var discard : [Card] = []

    var outs : [Card] = []

    init(_ sort: Bool) {
        sort ? self.cards.shuffle() : ();
        super.init()
    }

    override var description: String{return "\(self.cards)"}

    func draw () -> Card? {
        if self.cards.count > 0 {
            let card: Card? = self.cards.removeFirst()
            self.outs.append(card!)
            return card
        }
        return nil
    }

    func fold (card: Card) {
        self.outs.contains(card) ? {
            self.outs.removeAll(where: { element in (card == element) })
            self.discard.append(card)
            }() : {}()
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
