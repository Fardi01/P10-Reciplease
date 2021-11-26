//
//  RecipeTableViewCell.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 20/11/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var contentTextView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSubtitle: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeMinutes: UILabel!
    @IBOutlet weak var contentTimeView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentTimeView.layer.borderWidth = 0.8
        contentTimeView.layer.cornerRadius = 5
        contentTimeView.layer.borderColor = UIColor.white.cgColor
        
        contentTextView.applyGradient(isVertical: true, colorArray: [UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0), UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    var setRecipe: Hit? {
        didSet {
            guard let imageUrl = URL(string: setRecipe?.recipe.image ?? "recipe image") else { return }
            recipeImage.getImage(with: imageUrl)
            recipeTitle.text = setRecipe?.recipe.label
            recipeYield.text = "\(Int(setRecipe!.recipe.yield))"
            recipeMinutes.text = setRecipe?.recipe.totalTime.convertTime
            recipeSubtitle.text = setRecipe?.recipe.ingredientLines[0]
        }
    }
    
    var favoriteRecipe: FavoriteRecipes? {
        didSet {
            guard let image = favoriteRecipe?.image else {return}
            recipeImage.image = UIImage(data: image)
            recipeTitle.text = favoriteRecipe?.title
            recipeSubtitle.text = favoriteRecipe?.ingredients?[0]
            recipeMinutes.text = favoriteRecipe?.totalTime
            recipeYield.text = favoriteRecipe?.yield
        }
    }

}
