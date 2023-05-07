//
//  SpellListViewController.swift
//  DNDSpellbook
//
//  Created by Ryan Gutierrez on 4/26/23.
//

import UIKit

class SpellListViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var classTableView: UITableView!
    
    struct Class {
        let index: String
        let title: String
        let imageName: String
    }
    
//    var classes = ["barbarian", "bard", "cleric", "druid", "fighter", "monk", "paladin", "ranger", "rogue", "sorcerer", "warlock", "wizard"]
    
    let data: [Class] = [
        Class(index: "barbarian", title: "Barbarian", imageName: "Barbarian"),
        Class(index: "bard", title: "Bard", imageName: "Bard"),
        Class(index: "cleric", title: "Cleric", imageName: "Cleric"),
        Class(index: "druid", title: "Druid", imageName: "Druid"),
        Class(index: "fighter", title: "Fighter", imageName: "Fighter"),
        Class(index: "monk", title: "Monk", imageName: "Monk"),
        Class(index: "paladin", title: "Paladin", imageName: "Paladin"),
        Class(index: "ranger", title: "Ranger", imageName: "Ranger"),
        Class(index: "rogue", title: "Rogue", imageName: "Rogue"),
        Class(index: "sorcerer", title: "Sorcerer", imageName: "Sorcerer"),
        Class(index: "warlock", title: "Warlock", imageName: "Warlock"),
        Class(index: "wizard", title: "Wizard", imageName: "Wizard"),
        
    ]
    
    @IBAction func didTapLogout(_ sender: Any) {
        User.logout() { [weak self] result in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
                
            }
        }
    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SpellListViewController did load...")

        classTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let className = data[indexPath.row]
        let cell = classTableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! ClassCell
        cell.label.text = className.title
        cell.iconImageView.image = UIImage(named: className.imageName)
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UITableViewCell,
//
//           let indexPath = classTableView.indexPath(for: cell),
//
//           let classSpellViewController = segue.destination as? ClassSpellViewController {
//
//            /* TRYING TO THINK OF WHAT TO PUT HERE FOR CLASSSPELLViEWCONTROLLER
//            let  = data[indexPath.row]
//
//            */
//        }
//    }

}

