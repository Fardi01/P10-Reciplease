//
//  ListViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 17/11/2021.
//

import UIKit
import Foundation

class ListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeResponse: RecipeResponse?
    var recipeData: RecipeData?

    
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipeTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailRecipeViewController else { return }
        recipeVC.recipeData = recipeData
    }
}


// MARK: - UITABLEVIEW DATA SOURCE

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        recipeCell.setRecipe = recipeResponse?.hits[indexPath.row]

        return recipeCell
    }
    
}


// MARK: - UITABLEVIEW DELEGATE

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = recipeResponse?.hits[indexPath.row].recipe
        
        recipeData = RecipeData(title: detail?.label ?? "", imageData: detail?.image?.data, ingredients: detail?.ingredientLines ?? [], url: detail?.url ?? "", yield: String(detail?.yield ?? 0) , totalTime: String(detail?.totalTime ?? 0))
        
        performSegue(withIdentifier: "segueToRecipeDetailVC", sender: self)
    }
    
}
