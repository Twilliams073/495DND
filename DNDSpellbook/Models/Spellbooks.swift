//
//  Spellbook.swift
//  DNDSpellbook
//
//  Created by Loaf on 4/25/23.
//

import Foundation
import ParseSwift

struct Spellbooks: ParseObject {
    // These are required by `ParseObject`.
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    // Custom User properties
    var username: String? // username of the User who created the spellbook
    var spells: String? // comma separated index strings (i.e. "acid_slash,healing_word,..." )
    var name: String? // name of the spellbook
}
