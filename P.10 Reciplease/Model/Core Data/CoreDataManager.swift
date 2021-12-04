//
//  CoreManager.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 25/11/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    var favoriteRecipes: [FavoriteRecipes] {
        
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        
        guard let favorites = try? managedObjectContext.fetch(request) else { return [] }
        
        return favorites
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.context
    }
    
    
    
    
    // MARK: - Add Recipe in Favorite
    
    func addRecipesToFavorite(title: String, image: Data?, ingredients: [String], totalTime: String, yield: String, recipesURL: String) {
        
        let favorite = FavoriteRecipes(context: managedObjectContext)
        
        favorite.title = title
        favorite.image = image
        favorite.ingredients = ingredients
        favorite.totalTime = totalTime
        favorite.yield = yield
        favorite.recipesURL = recipesURL
        
        coreDataStack.saveContext()
    }
    
    
    // MARK: - Delete Recipes From Favorites
    
    func deleteRecipeFromFavorites(using title: String) {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        
        request.predicate = NSPredicate(format: "title == %@", title)
        
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else { return }
        
        favoritesRecipe.forEach { managedObjectContext.delete($0) }
        
        coreDataStack.saveContext()
    }
    
    
    // MARK: - Recipe Already Exist in Favorite
    
    func recipeAlreadySavedInFavorite(using title: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        
        request.predicate = NSPredicate(format: "title == %@", title)
        
        guard let favoritesRecipe = try? managedObjectContext.fetch(request) else { return false }
        
        if favoritesRecipe.isEmpty {
            return false
        }
        return true
    }
}
