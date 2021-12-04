//
//  Recipes.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 18/11/2021.
//

import Foundation

struct RecipeResponse: Codable {
    let q: String
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let image: String?
    let url: String?
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int
}



