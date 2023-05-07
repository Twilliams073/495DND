//
//  SpellDetailViewController.swift
//  DNDSpellbook
//
//  Created by Denize Ignacio on 5/7/23.
//

import UIKit

class SpellDetailViewController: UIViewController {
    
    var spell: Spell!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Gets index to use for spell url from ClassSpellViewController
        // ex) "https://www.dnd5eapi.co/api/spells/(index)"
        print(spell.index)

        // Do any additional setup after loading the view.
    }


}
