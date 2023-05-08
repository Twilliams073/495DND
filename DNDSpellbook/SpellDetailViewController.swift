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
                }
                

            } catch {
                debugPrint(error)
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
        // Do any additional setup after loading the view.
        
        //spellLabel.text = spellDetailed?.name
        //spellDesc.text = spellDetailed?.desc[0]
        
    }
        
}
