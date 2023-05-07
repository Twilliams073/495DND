//
//  ClassSpellViewController.swift
//  DNDSpellbook
//
//  Created by Dylan Ignacio on 5/6/23.
//

import UIKit

class ClassSpellViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var className: String = ""
    var spells: [Spell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.dnd5eapi.co/api/classes/"+className+"/spells")!
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

                let response = try decoder.decode(SpellResponse.self, from: data)

                let spells = response.results

                DispatchQueue.main.async {

                    self?.spells = spells

                    self?.tableView.reloadData()
                }


            } catch {
                print("❌ Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if spells.count == 0{
                let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
                emptyLabel.text = "No available spells"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.tableView.backgroundView = emptyLabel
                self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
                return 0
            } else {
                return spells.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpellCell", for: indexPath) as! SpellCell
        let spell = spells[indexPath.row]
        cell.configure(with: spell)
        return cell
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
