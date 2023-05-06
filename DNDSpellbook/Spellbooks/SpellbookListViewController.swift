//
//  SpellbookListViewController.swift
//  DNDSpellbook
//
//  Created by Ryan Gutierrez on 4/26/23.
//

import UIKit
import ParseSwift

class SpellbookListViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellbooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpellbookCell", for: indexPath) as! SpellbookCell
        
        let spellbook = spellbooks[indexPath.row]
        
        cell.configure(with: spellbook)
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func didTapCreateSpellbookButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Create a spellbook", message: "Please enter a name for your new spellbook", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let input = alertController.textFields![0].text
            print(input ?? "undefined")
            if(!input!.isEmpty) {
                var newSpellbook = Spellbooks()
                newSpellbook.username = User.current?.username
                newSpellbook.spells = ""
                newSpellbook.name = input
                
                newSpellbook.save { [weak self] result in
                    switch result {
                    case .success(let spellbook):
                        print("✅ Spellbook Saved \(spellbook)")
                        
                        DispatchQueue.main.async {
                            self?.querySpellbooks()
                        }
                        
                    case .failure(let error):
                        self?.showAlert(description: error.localizedDescription)
                    }
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
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
    
    private var spellbooks = [Spellbooks]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        querySpellbooks()
        print("Spellbooks count: \(spellbooks.count)")
        spellbooks.forEach {spellbook in
            print(spellbook)
        }
    }
    
    // Fetch all spellbooks belonging to the current User
    private func querySpellbooks() {
        let query = Spellbooks.query()
            .includeAll()
            .order([.descending("createdAt")])
            .where("username" == User.current?.username)
        
        query.find { [weak self] result in
            switch result {
            case .success(let spellbooks):
                self?.spellbooks = spellbooks
            case .failure(let error):
                print("Error querying database: "+error.localizedDescription)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
