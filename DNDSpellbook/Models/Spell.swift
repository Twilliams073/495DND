//
//  Spell.swift
//  DNDSpellbook
//
//  Created by Loaf on 4/25/23.
//

import Foundation
import ParseSwift

struct Spell: Decodable {
    let index: String
    let name: String
    let desc: [String]
    let range: String
}

struct SpellResponse : Decodable {
    let results: [Spell]
}
