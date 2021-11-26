//
//  FavoriteViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 16/11/2021.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var recipeData: RecipeData?
    var coreDataManager: CoreDataManager?
    var favoriteRecipe: FavoriteRecipes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailRecipeViewController else { return }
        recipeVC.recipeData = recipeData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }

}


// MARK: - Manage Data source & Delegate

// Je sauvegarde mes objets dans cette tableView

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FavoriteRecipes.all.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        favoriteCell.favoriteRecipe = FavoriteRecipes.all[indexPath.row]
        
        return favoriteCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = FavoriteRecipes.all[indexPath.row]
        
        recipeData = RecipeData(title: detail.title ?? "", imageData: detail.image, ingredients: detail.ingredients ?? [], url: detail.recipesURL ?? "", yield: detail.yield ?? "", totalTime: detail.totalTime ?? "")
        
        performSegue(withIdentifier: "segueToRecipeDetailVC", sender: self)
    }
    
    // Ajouter la suppression de la cellule avec le geste glissé à droite
    
    // Ajouter le placeholder au cas ou y'a rien dans favorite 
}

