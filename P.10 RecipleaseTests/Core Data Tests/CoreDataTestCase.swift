//
//  CoreDataTestCase.swift
//  P.10 RecipleaseTests
//
//  Created by fardi Issihaka on 03/12/2021.
//

import XCTest
@testable import P_10_Reciplease

class CoreDataTestCase: XCTestCase {

    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Test Add Recip Method
    
    func test_Method_AddRecipeToFavorite() {
        coreDataManager.addRecipesToFavorite(title: "Chocolate Sauce", image: Data(), ingredients: [""], totalTime: "0", yield: "10", recipesURL: "http://www.saveur.com/article/Recipes/Chocolate-Sauce")
        XCTAssertFalse(coreDataManager.favoriteRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoriteRecipes.count != 0)
        XCTAssertTrue(coreDataManager.favoriteRecipes[0].title == "Chocolate Sauce")
        XCTAssertTrue(coreDataManager.favoriteRecipes[0].image == Data())
    }
    
    
    // MARK: - Test Already save Method
    
    func test_Method_RecipeIsAlreadySavedInFavorite() {
        coreDataManager.addRecipesToFavorite(title: "Chocolate Sauce", image: Data(), ingredients: [""], totalTime: "0", yield: "10", recipesURL: "http://www.saveur.com/article/Recipes/Chocolate-Sauce")
        XCTAssertTrue(coreDataManager.recipeAlreadySavedInFavorite(using: "Chocolate Sauce"))
        XCTAssertFalse(coreDataManager.favoriteRecipes.isEmpty)
        
        coreDataManager.deleteRecipeFromFavorites(using: "Chocolate Sauce")
        XCTAssertFalse(coreDataManager.recipeAlreadySavedInFavorite(using: "Chocolate Sauce"))
        XCTAssertTrue(coreDataManager.favoriteRecipes.isEmpty)
    }
    
    
    // MARK: - Test Delete Method
    
    func test_Method_DeleteRecipeFromFavorite() {
        coreDataManager.addRecipesToFavorite(title: "Chocolate Sauce", image: Data(), ingredients: [""], totalTime: "0", yield: "10", recipesURL: "http://www.saveur.com/article/Recipes/Chocolate-Sauce")
        coreDataManager.deleteRecipeFromFavorites(using: "Chocolate Sauce")
        XCTAssertTrue(coreDataManager.favoriteRecipes.isEmpty)
        XCTAssertTrue(coreDataManager.favoriteRecipes.count != 1)
    }

}
