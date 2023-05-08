//
//  SpellbookSpellsViewController.swift
//  DNDSpellbook
//
//  Created by Ryan Gutierrez on 5/7/23.
//

import UIKit
import ParseSwift

class SpellbookSpellsViewController: UIViewController, UITableViewDataSource {
    
    var spells = [Spell]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var spellbook: Spellbooks?
    
    @IBAction func didTapDeleteSpellbookItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete spellbook", message: "Are you sure you want to delete \(spellbook?.name ?? "undefined")?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Delete", style: .default) { _ in
//            do {
//                try self.spellbook?.delete()
//            } catch (let error) {
//                print("❌ Error: \(error.localizedDescription)")
//            }
            
            self.spellbook?.delete { result in
                switch result {
                case .success(_):
                    print("✅ Spellbook successfully deleted")
                case .failure(let error):
                    print("❌ Error: \(error.localizedDescription)")
                }
            }
            
            if var currentUser = User.current {
                currentUser.currentSpellbookName = ""
                currentUser.save() { result in
                    switch result {
                    case .success(let user):
                        print("✅ current spellbook for \(user.username ?? "undefined") is now \(user.currentSpellbookName ?? "undefined")")
                    case .failure(let error):
                        print("❌ Error: \(error.localizedDescription)")
                    }
                }
                
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellCell
        
        let spell = spells[indexPath.row]
        
        cell.configure(with: spell)
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,

            let indexPath = tableView.indexPath(for: cell),

            let spellDetailViewController = segue.destination as? SpellDetailViewController {

            let spell = spells[indexPath.row]
            spellDetailViewController.spell = spell

        }
    }
}
