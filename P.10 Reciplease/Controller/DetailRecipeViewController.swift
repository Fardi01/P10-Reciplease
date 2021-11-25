//
//  SearchRecipesDetailViewController.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 18/11/2021.
//

import UIKit

class DetailRecipeViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeMinutes: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    @IBOutlet weak var contentTimeView: UIView!
    @IBOutlet weak var contentTitleView: UIView!
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var getDirectionButton: UIButton!
    
    var recipeData: RecipeData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateRecipeDetails()
        customContentTimeView(view: contentTimeView)
        customContentTitleView(view: contentTitleView)
        customButton()
    }
    
    
    // MARK: - Action Buttons
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: recipeData?.url ?? "") else {return}
        UIApplication.shared.open(url)
    }

}


// MARK: - Update Views with Datas from API

extension DetailRecipeViewController {
    
    private func updateRecipeDetails() {
        guard let image = recipeData?.imageData else { return }
        recipeImage.image = UIImage(data: image)
        recipeTitle.text = recipeData?.title
        recipeYield.text = "\(Int(recipeData?.yield ?? 0))"
        recipeMinutes.text = recipeData?.totalTime.convertTime
        recipeTextView.text = recipeData?.ingredients.joined(separator: ", \n - ")
        let stringIndex = recipeTextView.text.startIndex
        recipeTextView.text.insert(" ", at: stringIndex)
        recipeTextView.text.insert("-", at: stringIndex)
        recipeTextView.text.insert(" ", at: stringIndex)
    }
}


// MARK: - Custom some Views

extension DetailRecipeViewController {
    private func customContentTimeView(view: UIView) {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.8
    }
    
    private func customContentTitleView(view: UIView) {
        view.applyGradient(isVertical: true, colorArray: [UIColor(red: 56/255, green: 51/255, blue: 50/255, alpha: 0), UIColor(red: 56/255, green: 51/255, blue: 50/255, alpha: 1)])
    }
    
    private func customButton() {
        getDirectionButton.layer.cornerRadius = 5
    }
}
