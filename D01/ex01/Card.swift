class Card : NSObject {
    var Color : Color
    var Value : Value
    
     init(color: Color, value: Value) {
        super.init()
        self.Color = color
        self.Value = value
    }
    
    override var description : String {
        return "this card is \(self.value) of \(self.color)"
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