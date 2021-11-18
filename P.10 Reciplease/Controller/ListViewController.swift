//
//  ListViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 17/11/2021.
//

import UIKit
import Alamofire

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}

// MARK: - DataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return nombre de reponse renvoyé par l'API
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipCell", for: indexPath)
        
        return cell
    }
    
    
}
