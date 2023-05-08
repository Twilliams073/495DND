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
    
    override func viewDidAppear(_ animated: Bool) {
        print("View appeared...")
        let query = Spellbooks.query()
            .where("username" == User.current?.username, "name" == spellbook?.name)
        
        query.find { result in
            switch result {
            case .success(let spellbooks):
                print("✅ Query successful: \(spellbooks[0].spells)")
                let spellIndexes = spellbooks[0].spells?.components(separatedBy: ",")
                print("spellIndexes = \(spellIndexes)")
                for (i, spell) in self.spells.enumerated() {
                    if(!(spellIndexes?.contains(spell.index) ?? false)) {
                        print("Found spell mismatch at i = \(i) -> \(spell)")
                        self.spells.remove(at: i)                    }
                }
            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func syncSpells() {
        let query = Spellbooks.query()
            .where("username" == User.current?.username, "name" == spellbook?.name)
        
        query.find { result in
            switch result {
            case .success(let spellbooks):
                let spellIndexes: [String] = self.spellbook?.spells?.components(separatedBy: ",") ?? ["undefined"]
                for (i, spell) in self.spells.enumerated() {
                    if(!spellIndexes.contains(spell.index)) {
                        self.spells.remove(at: i)
                        print("Removing spell: \(spell)")
                    }
                }
               print("✅ Query successful: \(spellbooks)")
            case .failure(let error):
                print("❌ Error: \(error.localizedDescription)")
            }
        }
        
//        let url = URL(string: "https://www.dnd5eapi.co/api/spells/")!
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            if let error = error {
//                print("❌ Network error: \(error.localizedDescription)")
//            }
//
//            guard let data = data else {
//                print("❌ Data is nil")
//                return
//            }
//
//            do {
//
//            } catch {
//                print("❌ Error: \(error.localizedDescription)")
//            }
//        }
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
