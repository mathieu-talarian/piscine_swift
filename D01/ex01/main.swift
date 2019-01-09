import Foundation

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
