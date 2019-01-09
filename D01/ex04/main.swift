let c = Deck(false)
print(c)

let cardz = Deck(true)
print(cardz)
if let c: Card = cardz.draw() {
    print(cardz.outs)
    cardz.fold(card: c)
    print(cardz.discard)
    
    print("refold")
      cardz.fold(card: c)
}

print(cardz.length, cardz.olength, cardz.dlength)

var out = [Card]()

while cardz.length > 0 {
    if let cc: Card = cardz.draw() {
        out.append(cc)
    }
}

print(cardz.length, cardz.olength, cardz.dlength)
print(out.count)

if let _: Card = cardz.draw() {
    print("issue here")
} else {
    print("all good")
}

while out.count > 0 {
    cardz.fold(card: out.removeFirst())
}

print(cardz.length, cardz.olength, cardz.dlength)
print(out.count)