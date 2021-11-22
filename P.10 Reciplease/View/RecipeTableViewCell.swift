//
//  RecipeTableViewCell.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 20/11/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSubtitle: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeMinutes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Customise les cellules
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var setRecipe: Hit? {
        didSet {
            guard let imageUrl = URL(string: setRecipe?.recipe.image ?? "No Image") else { return }
            recipeImage.getImage(with: imageUrl)
            recipeTitle.text = setRecipe?.recipe.label
            recipeYield.text = "\(Double(setRecipe!.recipe.yield))"
            recipeMinutes.text = "\(Int((setRecipe?.recipe.totalTime)!))min"
        }
    }

}
