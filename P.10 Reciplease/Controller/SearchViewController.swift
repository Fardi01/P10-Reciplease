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
    
    var recipResponse: RecipeResponse?
    
    var ingredients = [String]()
    var recipeResponse: RecipeResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredients.append(ingredientTextField.text!)
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addIngredients()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        deleteIngredientsInTextView()
    }
    
    @IBAction func searchRecipesButtonTapped(_ sender: UIButton) {
        makeAPICall()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesList = segue.destination as? ListViewController else { return }
        recipesList.recipeResponse = recipeResponse
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

// MARK: - Make API CALL

extension SearchViewController {
    
    private func makeAPICall() {
            RecipesService.shared.getRecipe(ingredientList: IngredientTextView.text) { result in
                switch result {
                case .success(let response) :
                    self.recipeResponse = response
                    self.performSegue(withIdentifier: "segueToListViewController", sender: nil)
                    print(response)
                case .failure(let error) :
                    self.presentAlert(title: "Bad request ⚠️", message: "network error !")
                    print(error)
            }
        }
    }
}


// MARK: - Present Alert VC

extension SearchViewController {
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
