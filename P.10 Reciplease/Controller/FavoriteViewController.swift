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

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
}
