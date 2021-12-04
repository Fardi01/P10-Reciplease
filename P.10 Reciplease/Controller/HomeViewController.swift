//
//  SearchViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 16/11/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var IngredientTextView: UITextView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    
    // MARK: - PROPERTIES
    
    var ingredients = [String]()
    var recipeResponse: RecipeResponse?
    
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageKeyBoard()
        ingredients.append(ingredientTextField.text!)
        customButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let recipesList = segue.destination as? ListViewController else { return }
        recipesList.recipeResponse = recipeResponse
    }
    
    
    // MARK: - BUTTONS ACTION
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addIngredientsToTextView()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        deleteIngredientsFromTextView()
    }
    
    @IBAction func searchRecipesButtonTapped(_ sender: UIButton) {
        makeAPICall()
    }
    
}


// MARK: - PRIVATE METHODS

extension HomeViewController {
    
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
    
    
    private func addIngredientsToTextView() {
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
    
    
    private func deleteIngredientsFromTextView() {
        IngredientTextView.text = ""
    }
    
    
    private func customButtons() {
        searchButton.layer.cornerRadius = 5
        addButton.layer.cornerRadius = 5
        clearButton.layer.cornerRadius = 5
    }
    
}


// MARK: - UITEXTFIELD DELEGATE

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func manageKeyBoard() {
        ingredientTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: - PRESENT ALERT

extension HomeViewController {
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
