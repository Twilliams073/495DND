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
    let url: String
}

struct SpellResponse : Decodable {
    let results: [Spell]
}

struct SpellDetail: Decodable {
    let index: String
    let name: String
    let desc: [String]
    let range: String
    let components: [String]
    let duration: String
    let concentration: Bool
    let casting_time: String
    let level: Int
}

struct SpellDetailResponse: Decodable {
    let result: [SpellDetail]
}
