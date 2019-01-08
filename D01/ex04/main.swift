let cardz = Deck(true)

if let c: Card = cardz.draw() {
    print(cardz.outs)
    cardz.fold(card: c)
    print(cardz.discard)
}

