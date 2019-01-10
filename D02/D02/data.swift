//
//  data.swift
//  D02
//
//  Created by Mathieu MOULLEC on 1/10/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

class Person {
    var name: String
    var desc: String
    var date: Date
    
    init(_ name : String, _ desc: String, _ date: Date) {
        self.name = name
        self.desc = desc
        self.date = date
    }
}

class Data {
    
    static let Persons:[Person] = [
        Person("Jeam Nichel", "Noye dans l'ocean", Date.init()),
        Person("Kevin Dupont", "Ecrase par un parpaing, pourtant on lui avait de pas passer par le chantier", Date.init()),
        Person("Jacques Durand", "Tete coupee", Date.init())
    ]
    
    var persons: [Person]
    
    init() {
        self.persons = Data.Persons
    }
    
    func newPerson(_ person: Person) {
        self.persons.append(person)
    }
}
