//
//  ListViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 17/11/2021.
//

import UIKit
import Foundation

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipeResponse: RecipeResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
    }
    
    
}

// MARK: - DataSource

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { fatalError() }
        
        cell.setRecipe = recipeResponse?.hits[indexPath.row]
        
        return cell
    }
    
    
}
