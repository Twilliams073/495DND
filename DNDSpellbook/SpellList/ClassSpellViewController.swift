//
//  ClassSpellViewController.swift
//  DNDSpellbook
//
//  Created by Dylan Ignacio on 5/6/23.
//

import UIKit

class ClassSpellViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    /* STUCK */
    // var
    var spells: [Spell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // tableView.dataSource = self
        
//        let url = URL(string: )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellCell
        let spell = spells[indexPath.row]
        cell.configure(with: spell)
        return cell
    }
    
    
}
