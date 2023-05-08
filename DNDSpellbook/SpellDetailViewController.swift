//
//  SpellDetailViewController.swift
//  DNDSpellbook
//
//  Created by Denize Ignacio on 5/7/23.
//

import UIKit

class SpellDetailViewController: UIViewController {
    
    @IBOutlet weak var spellLabel: UILabel!
    @IBOutlet weak var spellDesc: UILabel!
    
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

                let response = try decoder.decode(SpellDetailResponse.self, from: data)

                let spellDetailed = response.result

                DispatchQueue.main.async {

                    self?.spellDetailed = spellDetailed
                }


            } catch {
                debugPrint(error)
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
        // Do any additional setup after loading the view.
        
        
        spellLabel.text = spellDetailed?.name
        spellDesc.text = spellDetailed?.desc[0]
    }
}
