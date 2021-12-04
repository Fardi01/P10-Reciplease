//
//  MockResponse.swift
//  P.10 RecipleaseTests
//
//  Created by fardi Issihaka on 02/12/2021.
//

import Foundation

class MockResponseData {
    
    // MARK: - DATAS
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: MockResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let recipeIncorrectData = "error".data(using: .utf8)!
    
    
    // MARK: - RESPONSES
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    // MARK: - ERROR
    class NetworkError: Error{}
    let error = NetworkError()
}

