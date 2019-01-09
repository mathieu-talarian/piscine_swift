import Foundation

class Card : NSObject {
    var color : Color
    var value : Value
    
     init(color: Color, value: Value) {
        self.color = color
        self.value = value
        super.init()
    }
    
    override var description : String {
        return "this card is \(self.value) of \(self.color)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let obj = object as? Card {
            return (obj.color == self.color) && (obj.value == self.value)
        }
        return false
    }
}

func ==(left: Card, right: Card) ->Bool {
    return left.isEqual(right)
}