//
//  SearchViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 16/11/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var IngredientTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRecipes()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addIngredients()
    }
    
  
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        deleteIngredientsInTextView()
    }
    
    
    @IBAction func searchRecipesButtonTapped(_ sender: UIButton) {
        // Get Call API
    }
    
    
}




// MARK: - Privates func

extension SearchViewController {
    
    private func addIngredients() {
        guard let newIngredient = ingredientTextField.text, var ingredients = IngredientTextView.text else {
            return
        }
        ingredients += "- \(newIngredient)" + "\n"
        IngredientTextView.text = ingredients
        ingredientTextField.text = ""
    }
    
    private func deleteIngredientsInTextView() {
        IngredientTextView.text = ""
    }
}


extension SearchViewController {
    func fetchRecipes() {
        let request = AF.request("https://swapi.dev/api/films")
        request.responseJSON { (data) in
            print(data)
        }
    }
}

