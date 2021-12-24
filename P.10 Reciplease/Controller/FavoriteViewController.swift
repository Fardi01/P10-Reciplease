//
//  FavoriteViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 16/11/2021.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var recipeData: RecipeData!
    var coreDataManager: CoreDataManager?
    
    private var footerText: String {
        "Nothing in your Favorites. \n You need to add some recipes in your Favorite list !"
    }
    
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "RecipeTableViewCell", bundle: nil)
        favoriteTableView.register(nibName, forCellReuseIdentifier: "RecipeCell")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipeVC = segue.destination as? DetailRecipeViewController else { return }
        recipeVC.recipeData = recipeData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
    }

}


// MARK: - UITABLEVIEW DATA SOURCE

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager?.favoriteRecipes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let favoriteCell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
                as? RecipeTableViewCell else { return UITableViewCell() }
        
        favoriteCell.favoriteRecipe = coreDataManager?.favoriteRecipes[indexPath.row]
        
        return favoriteCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = coreDataManager?.favoriteRecipes[indexPath.row]
        
        recipeData = RecipeData(title: detail?.title ?? "", imageData: detail?.image, ingredients: detail?.ingredients ?? [], url: detail?.recipesURL ?? "", yield: detail?.yield ?? "", totalTime: detail?.totalTime ?? "")
        
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromFavoriteCells(at: indexPath)
        }
    }
    
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
        return coreDataManager?.favoriteRecipes.count == 0 ? footerView : nil
        
    }
}



// MARK: - PRIVATE METHODS
extension FavoriteViewController {
    
    private func deleteFromFavoriteCells(at indexPath: IndexPath) {
        guard let title = coreDataManager?.favoriteRecipes[indexPath.row].title else { return }
        coreDataManager?.deleteRecipeFromFavorites(using: title)
        //coreDataManager?.favoriteRecipes.remove(at: indexPath.row)
        
        presentAlert(title: "Delete From Favorite", message: "The recipe: \(title) has been removed from your favorites")
        favoriteTableView.reloadData()
        
    }
    
    
}
