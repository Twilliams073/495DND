//
//  SpellCell.swift
//  DNDSpellbook
//
//  Created by Ryan Gutierrez on 4/26/23.
//

import UIKit

class SpellCell: UITableViewCell {
    
    @IBOutlet weak var spellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with spell:Spell) {
        spellLabel.text = spell.name
    }

}
