//
//  MockSession.swift
//  P.10 RecipleaseTests
//
//  Created by fardi Issihaka on 02/12/2021.
//

import Foundation
import Alamofire
@testable import P_10_Reciplease

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
    var error: Error?
}

final class MockSession: AlamoSession {
    
    private let fakeResponse: FakeResponse

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: URL, completion completionHandler: @escaping (AFDataResponse<Any>) -> Void) {
        
        let dataResponse = AFDataResponse<Any>(
            request: nil,
            response: fakeResponse.response,
            data: fakeResponse.data,
            metrics: nil,
            serializationDuration: 0,
            result: .success("Done"))
        
        completionHandler(dataResponse)
    }
}
