//
//  Recipes.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 18/11/2021.
//

import Foundation

struct RecipeResponse: Decodable {
    let q: String
    let hits: [Hit]
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String?
    let url: String?
    let yield: Double
    let ingredientLines: [String]
    let totalTime: Int
}



