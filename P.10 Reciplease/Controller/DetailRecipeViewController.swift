//
//  SearchRecipesDetailViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 18/11/2021.
//

import UIKit
import CoreData

class DetailRecipeViewController: UIViewController {
    
    // MARK: - OUTLETS

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeMinutes: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    @IBOutlet weak var contentTimeView: UIView!
    @IBOutlet weak var contentTitleView: UIView!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var getDirectionButton: UIButton!
    
    
    //MARK: - PROPERTIES
    
    var recipeData: RecipeData!
    
    var coreDataManager: CoreDataManager?
    
    var imageWithColor: UIImage {
        return UIImage(systemName: "star.fill")!.withTintColor(UIColor(red: 64/255, green: 150/255, blue: 91/255, alpha: 1), renderingMode: .alwaysOriginal)
    }
    
    var initialImage: UIImage {
        return UIImage(systemName: "star")!
    }
    
    
    // MARK: - VIEWS LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
        
        updateRecipeDetails()
        customContentTimeView(view: contentTimeView)
        customContentTitleView(view: contentTitleView)
        customButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if coreDataManager?.recipeAlreadySavedInFavorite(using: recipeData?.title ?? "") == true {
            favoriteButton.image = imageWithColor
        } else {
            favoriteButton.image = initialImage
        }
    }
    
    
    // MARK: - ACTION BUTTONS
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        
        if coreDataManager?.recipeAlreadySavedInFavorite(using: recipeData?.title ?? "") == true {
            deleteFromFavorites()
            favoriteButton.image = initialImage
            if tabBarController?.selectedIndex == 1 {
                navigationController?.popViewController(animated: true)
            }
        } else {
            addToFavorites()
            favoriteButton.image = imageWithColor
            presentAlert(title: "Ajout aux favoris", message: "La recette viens d'être ajouté à vos favoris")
        }
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: recipeData?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }

}


// MARK: - PRIVATE METHODS

extension DetailRecipeViewController {
    
    private func updateRecipeDetails() {
        guard let image = recipeData?.imageData else { return }
        recipeImage.image = UIImage(data: image)
        recipeTitle.text = recipeData?.title
        recipeYield.text = recipeData?.yield
        recipeMinutes.text = recipeData?.totalTime
        recipeTextView.text = recipeData?.ingredients.joined(separator: ", \n - ")
        let stringIndex = recipeTextView.text.startIndex
        recipeTextView.text.insert(" ", at: stringIndex)
        recipeTextView.text.insert("-", at: stringIndex)
        recipeTextView.text.insert(" ", at: stringIndex)
    }
    
    private func customContentTimeView(view: UIView) {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.8
        view.layer.cornerRadius = 5
    }
    
    private func customContentTitleView(view: UIView) {
        view.applyGradient(isVertical: true, colorArray: [UIColor(red: 56/255, green: 51/255, blue: 50/255, alpha: 0), UIColor(red: 56/255, green: 51/255, blue: 50/255, alpha: 1)])
    }
    
    private func customButton() {
        getDirectionButton.layer.cornerRadius = 5
    }
    
    private func addToFavorites() {
        guard let recipeData = recipeData else { return }
        coreDataManager?.addRecipesToFavorite(title: recipeData.title, image: recipeData.imageData, ingredients: recipeData.ingredients, totalTime: recipeData.totalTime, yield: recipeData.yield, recipesURL: recipeData.url)
    }
    
    private func deleteFromFavorites() {
        coreDataManager?.deleteRecipeFromFavorites(using: recipeTitle.text ?? "")
    }
    
}


// MARK: - UIALERT

extension DetailRecipeViewController {
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
