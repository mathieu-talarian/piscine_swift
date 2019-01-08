
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
