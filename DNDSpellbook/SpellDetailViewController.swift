//
//  SpellDetailViewController.swift
//  DNDSpellbook
//
//  Created by Denize Ignacio on 5/7/23.
//

import UIKit
import ParseSwift

class SpellDetailViewController: UIViewController {
    
    @IBOutlet weak var spellLabel: UILabel!
    @IBOutlet weak var spellDesc: UITextView!
    @IBOutlet weak var spellRange: UILabel!
    @IBOutlet weak var spellDuration: UILabel!
    @IBOutlet weak var spellLevel: UILabel!
    @IBOutlet weak var spellCT: UILabel!
    
    var spell: Spell!
    var spellDetailed: SpellDetail?
    var spellBook: Spellbooks?
    
    @IBAction func addToSpellbook(_ sender: Any) {
        
        let spls = self.spellBook?.spells
        let addr = "," + (self.spellDetailed?.index)!
        spellBook?.spells = (String(spls!) + String(addr))
        spellBook?.save { [weak self] result in
            switch result {
            case .success(let spellbook):
                print("✅ Spellbook Saved \(spellbook)")

            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    @IBAction func removeFromSpellbook(_ sender: Any) {

        let spls = self.spellBook?.spells
        let addr = "," + (self.spellDetailed?.index)!
        let upd = (spls!).replacingOccurrences(of: addr , with: "")
        spellBook?.spells = String(upd)
        spellBook?.save { [weak self] result in
            switch result {
            case .success(let spellbook):
                print("✅ Spellbook Saved \(spellbook)")

            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gets index to use for spell url from ClassSpellViewController
        
        let url = URL(string: "https://www.dnd5eapi.co/api/spells/" + spell.index)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let response = try decoder.decode(SpellDetail.self, from: data)
                
                let spellDetailed = response
                print(spellDetailed)
                
                DispatchQueue.main.async {
                    
                    self?.spellDetailed = spellDetailed
                    self?.spellLabel.text = spellDetailed.name
                    self?.spellDesc.text = spellDetailed.desc[0]
                    self?.spellRange.text = spellDetailed.range
                    self?.spellDuration.text = spellDetailed.duration
                    self?.spellLevel.text = String(spellDetailed.level)
                    self?.spellCT.text = spellDetailed.casting_time
                    
                    self?.querySpellbook()
                }
                
                
            } catch {
                debugPrint(error)
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
        // Do any additional setup after loading the view.
        
        
    }
    
    // Fetch specified spellbook
    private func querySpellbook() {
        let query = Spellbooks.query()
            .where("username" == User.current?.username , "name" == User.current?.currentSpellbookName)

        query.find { [weak self] result in
            switch result {
            case .success(let spellbook):
                self?.spellBook = spellbook[0]
            case .failure(let error):
                print("Error querying database: "+error.localizedDescription)
            }
        }
    }
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
