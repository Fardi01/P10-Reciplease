//
//  FavoriteViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 16/11/2021.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var recipeData: RecipeData?
    var coreDataManager: CoreDataManager?
    var favoriteRecipe = FavoriteRecipes.all
    private var footerText: String {
        "Nothing in your Favorites. \n You need to add some recipes in your Favorite list !"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailRecipeViewController else { return }
        recipeVC.recipeData = recipeData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteRecipe = FavoriteRecipes.all
        favoriteTableView.reloadData()
        
        print("Voila ✅")
        print(favoriteRecipe.count)
    }

}


// MARK: - Manage Data source & Delegate

// Je sauvegarde mes objets dans cette tableView

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipe.count
    }
    
    // Je récupère les elements enregistrer dans Favorite pour les affiché dans les celulles Favorites
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        favoriteCell.favoriteRecipe = favoriteRecipe[indexPath.row]
        
        return favoriteCell
    }
    
    // Quand je clique sur la recette je vais vers les details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = FavoriteRecipes.all[indexPath.row]
        
        recipeData = RecipeData(title: detail.title ?? "", imageData: detail.image, ingredients: detail.ingredients ?? [], url: detail.recipesURL ?? "", yield: detail.yield ?? "", totalTime: detail.totalTime ?? "")
        
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
    
    
    
    
    
    
    
    // Ajouter la suppression de la cellule avec le geste glissé à droite
    
    
    // Ajouter le placeholder au cas ou y'a rien dans favorite
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: tableView.center.x, y: tableView.center.y, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        let title = UILabel(frame: footerView.bounds)
        title.text = footerText
        title.textAlignment = .center
        title.textColor = .lightGray
        title.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        title.lineBreakMode = .byWordWrapping
        title.numberOfLines = 0
        footerView.addSubview(title)
        return footerView
        
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        footerText
    }
}

