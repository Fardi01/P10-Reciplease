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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var ingredients = [String]()
    var recipeResponse: RecipeResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ingredients.append(ingredientTextField.text!)
        customButtons()
    }
    
    // MARK: - Manage Segue from Menu to -> List View Controller
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesList = segue.destination as? ListViewController else { return }
        recipesList.recipeResponse = recipeResponse
    }
    
    
    // MARK: - Actions Buttons
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addIngredients()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        deleteIngredientsInTextView()
    }
    
    @IBAction func searchRecipesButtonTapped(_ sender: UIButton) {
        makeAPICall()
    }
    
}


// MARK: - Privates function (TextField & TextView)

extension SearchViewController {
    
    private func addIngredients() {
        guard let newIngredient = ingredientTextField.text, var ingredients = IngredientTextView.text else {
            return
        }
        
        if newIngredient.isEmpty {
            presentAlert(title: "Oups 🙁", message: "Please add some ingredients !")
        } else {
            ingredients += "- \(newIngredient)" + "\n"
            IngredientTextView.text = ingredients
            ingredientTextField.text = ""
        }
    }
    
    private func deleteIngredientsInTextView() {
        IngredientTextView.text = ""
    }
    
}

// MARK: - Make API CALL

extension SearchViewController {
    
    private func makeAPICall() {
        if IngredientTextView.text.isEmpty {
            presentAlert(title: "Oups 🙁", message: "Please add some ingredients before continue !")
        } else {
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
}


// MARK: - Present Alert VC

extension SearchViewController {
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


// MARK: - Custom some Buttons

extension SearchViewController {
    
    private func customButtons() {
        searchButton.layer.cornerRadius = 5
        addButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
    }
}
