//
//  SpellbookCell.swift
//  DNDSpellbook
//
//  Created by Ryan Gutierrez on 5/4/23.
//

import UIKit

class SpellbookCell: UITableViewCell {

    @IBOutlet weak var spellbookName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with spellbook: Spellbooks) {
        spellbookName.text = spellbook.name
    }

}
