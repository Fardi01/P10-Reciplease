//
//  FavoriteRecipes.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 25/11/2021.
//

import Foundation
import CoreData

class FavoriteRecipes: NSManagedObject {
    
    static var all: [FavoriteRecipes] {
        
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        
        return favorites
    }
}

