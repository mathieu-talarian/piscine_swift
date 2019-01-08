import UIKit


enum Color : String {
    case pique = "♠"
    case trefle = "♣"
    case coeur = "♥"
    case carreau = "♦"
    static let allColors : [Color] =  [pique, trefle, carreau, coeur]
}

enum Value : Int {
    case ace = 1
    case deux, trois, quatre, cinq, six, sept, huit, neuf, dix, valet, dame, roi
    static let allValues : [Value] = [
      ace,
     deux, trois, quatre, cinq, six, sept, huit, neuf, dix, valet, dame, roi
    ]
}

var vals : [Value] = Value.allValues
for elem in vals {
    print("\(elem) = \(elem.rawValue)")
}

var cols : [Color] = Color.allColors
for elem in cols {
    print("\(elem) = \(elem.rawValue)")
}

let roi : Value = .roi
print(roi.hashValue)
print(roi.rawValue)

let Pique : Color = .pique
print(Pique.rawValue)

class Card : NSObject {
    var Color : Color?
    var Value : Value?
    
     init(color: Color, value: Value) {
        self.Color = color
        self.Value = value
    }
    
    override var description : String {
        return "this card is \(self.Value!) of \(self.Color!.rawValue)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card {
            return (obj.Color == self.Color) && (obj.Value == self.Value)
        }
        return false
    }
}


func ==(left: Card, right: Card) ->Bool {
    return left.isEqual(right)
}

let card1 : Card = Card(color: .carreau, value: .ace)
let card2 : Card = Card(color: .coeur, value: .ace)
let obj = NSObject()
print(card1.description)
print(card2.description)
print(card1.isEqual(card1))
print(card1.isEqual(obj))
print(card2.isEqual(card1))
print(card1 == card1)
print(card2 == card1)

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



print(Deck.allDiamonds)
print(Deck.allHeart.count)
print(Deck.allCards.count)

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

var cards = Deck.allCards
cards.shuffle()


let cardz = Deck(true)

if let c: Card = cardz.draw() {
    print(cardz.outs)
    cardz.fold(card: c)
    print(cardz.discard)
}

