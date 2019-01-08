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