//
//  NetworkSession.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 19/11/2021.
//

import Foundation

import Alamofire

protocol AlamoSession {
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void)
}

class NetworkSession: AlamoSession {
    func request(with url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { responseData in
            completion(responseData)
        }
    }
}
