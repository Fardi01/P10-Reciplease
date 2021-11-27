//
//  ListViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 17/11/2021.
//

import UIKit
import Foundation

class ListViewController: UIViewController {
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeResponse: RecipeResponse?
    var recipeData: RecipeData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // J'utilise UINib pour la reusable cell
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        recipeTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
    }
    
    // Je lie de reference les données de ma liste view Controler à la vue detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailRecipeViewController else { return }
        recipeVC.recipeData = recipeData
    }
    
    
}

// MARK: - DataSource

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResponse?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let recipeCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        recipeCell.setRecipe = recipeResponse?.hits[indexPath.row]

        return recipeCell
    }
    
    // J'utilise une didSelectedRow pour envoyer les éléments selectionner à la detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = recipeResponse?.hits[indexPath.row].recipe
        
        recipeData = RecipeData(title: detail?.label ?? "", imageData: detail?.image?.data, ingredients: detail?.ingredientLines ?? [], url: detail?.url ?? "", yield: String(detail?.yield ?? 0) , totalTime: String(detail?.totalTime ?? 0))
        
        performSegue(withIdentifier: "segueToRecipeDetailVC", sender: self)
    }
    
    
}
