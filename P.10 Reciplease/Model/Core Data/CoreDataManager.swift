//
//  CoreManager.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 25/11/2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    
    // MARK: - Add Recipe in Favorite
    
    func addRecipesToFavorite(using title: String, image: Data?, ingredients: [String], totalTime: String, yield: String, recipeURL: String) {
        
        let favorite = FavoriteRecipes(context: AppDelegate.viewContext)
        
        favorite.title = title
        favorite.image = image
        favorite.ingredients = ingredients
        favorite.totalTime = totalTime
        favorite.yield = yield
        favorite.recipesURL = recipeURL
        
        try? AppDelegate.viewContext.save()
    }
    
    
    // MARK: - Delete Recipes From Favorites
    
    func deleteRecipeFromFavorites(using title: String) {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", title)
        
        guard let favoritesRecipe = try? AppDelegate.viewContext.fetch(request) else { return }
        
        favoritesRecipe.forEach { AppDelegate.viewContext.delete($0) }
        
        try? AppDelegate.viewContext.save()
    }
    
    
    // MARK: - Recipe Already Exist in Favorite
    
    func recipeAlreadySavedInFavorite(using title: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", title)
        
        guard let favoritesRecipe = try? AppDelegate.viewContext.fetch(request) else { return false }
        
        if favoritesRecipe.isEmpty {
            return false
        }
        return true
    }
}
