//
//  RecipesService.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 18/11/2021.
//

import Foundation

enum RequestError: Error {
    case noData, incorrectResponse, undecodableData
}

final class RecipesService {
    
    static var shared = RecipesService()
    
    private let session: AlamoSession
    
    init(session: AlamoSession = NetworkSession()){
        self.session = session
    }
    
    func getRecipe(ingredientList: String, completion: @escaping (Result<RecipeResponse, RequestError>) -> Void) {
        
        guard let baseUrl = URL(string: EdamamAPI.urlString) else { return }
        
        let parameters: [(String, String)] = [("app_id", EdamamAPI.app_id),
                                              ("app_key", EdamamAPI.app_key), ("q", ingredientList)]
        
        let url = encode(baseUrl: baseUrl, parameters: parameters)
        
        session.request(with: url) { responseData in
            
            DispatchQueue.main.async {
                
                guard let data = responseData.data else {
                    completion(.failure(RequestError.noData))
                    return
                }
                
                guard responseData.response?.statusCode == 200 else {
                    completion(.failure(RequestError.incorrectResponse))
                    return
                }
                
                guard let responseJson = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
                    completion(.failure(RequestError.undecodableData))
                    return
                }
                completion(.success(responseJson))
                //print(responseJson)
            }
        }
    }
    
    
    
    // MARK: - Create URL from BaseURL
    
    func encode(baseUrl: URL, parameters: [(String, String)]) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
