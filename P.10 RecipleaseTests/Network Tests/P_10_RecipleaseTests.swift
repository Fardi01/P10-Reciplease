//
//  P_10_RecipleaseTests.swift
//  P.10 RecipleaseTests
//
//  Created by fardi Issihaka on 07/11/2021.
//

import XCTest
@testable import P_10_Reciplease

class P_10_RecipleaseTests: XCTestCase {

    // MARK: - ❌ Failed: Test if callback No Data and No Response
    
    func testRecipeService_ShouldPostFailedCallBack_IfNoData_And_NoResponse() {
        // Given
        let session = MockSession(fakeResponse: FakeResponse(response: nil, data: nil, error: nil))
        let recipeService = RecipesService(session: session)
        
        // When
        let expectation = expectation(description: "Wait for queue changing.")
        recipeService.getRecipe(ingredientList: "Chocolate") { (result) in
            // Then
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ❌ Failed: Incorrect Responses
    
    func testRecipeService_ShouldPostFailedCallBack_IfIncorrectResponse() {
        // Given
        let session = MockSession(fakeResponse: FakeResponse(response: MockResponseData.responseKO, data: MockResponseData.recipeCorrectData))
        let recipeService = RecipesService(session: session)
        
        // When
        let expectation = expectation(description: "Wait for queue changing.")
        recipeService.getRecipe(ingredientList: "Chocolate") { (result) in
            //then
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
  
    // MARK: - ❌ Failed: Incorrect Datas
    func testRecipeService_ShouldPostFailedCallBack_IfIncorrectDatas() {
        // Given
        let session = MockSession(fakeResponse: FakeResponse(response: MockResponseData.responseOK, data: MockResponseData.recipeIncorrectData))
        let recipeService = RecipesService(session: session)
        
        // When
        let expectation = expectation(description: "Wait for queue changing.")
        recipeService.getRecipe(ingredientList: "Chocolate") { (result) in
            //then
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - ✅ Success : Correct datas and correct responses

    func testRecipeService_ShouldPostSuccessCallBack_IfCorrectData_And_ResponseOK() {
        // Given
        let session = MockSession(fakeResponse: FakeResponse(response: MockResponseData.responseOK, data: MockResponseData.recipeCorrectData))
        let recipeService = RecipesService(session: session)
        
        // When
        let expectation = expectation(description: "Wait for queue changing.")
        recipeService.getRecipe(ingredientList: "Chicken") { (result) in
            //then
            guard case .success(let data) = result else {
                XCTFail("Test getRecipes method with correct data failed.")
                return
            }
            
            XCTAssertNotNil(result)
            self.testJsonDataCorrespondToExpectedResult(data: data)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - Private method
    
    private func testJsonDataCorrespondToExpectedResult(data: RecipeResponse) {
        let title = "Chicken Vesuvio"
        let imageUrl = "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg"
        let url = "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html"
        let yield = 4
        let ingredientLines = ["1/2 cup olive oil", "5 cloves garlic, peeled", "2 large russet potatoes, peeled and cut into chunks", "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)", "3/4 cup white wine", "3/4 cup chicken stock", "3 tablespoons chopped parsley", "1 tablespoon dried oregano", "Salt and pepper", "1 cup frozen peas, thawed"]
        let totalTime = 60
        
        XCTAssertEqual(data.hits[0].recipe.label, title)
        XCTAssertEqual(data.hits[0].recipe.image, imageUrl)
        XCTAssertEqual(data.hits[0].recipe.url, url)
        XCTAssertEqual(data.hits[0].recipe.yield, yield)
        XCTAssertEqual(data.hits[0].recipe.ingredientLines, ingredientLines)
        XCTAssertEqual(data.hits[0].recipe.totalTime, totalTime)
    }
}
