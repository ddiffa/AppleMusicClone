//
//  ApiRequest.swift
//  Core
//
//  Created by Diffa Desyawan on 15/12/21.
//

import Foundation
import Alamofire
import RxSwift

public struct EmptyResponse: Codable {}

public protocol APIRequest {
    associatedtype Response: Codable
    
    var baseUrl: String { get }
    var pathName: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var url: URL { get }
}

extension APIRequest {
    public typealias Response = EmptyResponse
    
    public var baseUrl: String { Constants.baseUrl }
    public var url: URL { URL(string: baseUrl + pathName)! }
    public var method: HTTPMethod { .get }
    public var contentType: String { "application/json" }
}

public protocol FetchCapable {
    func fetch<ResponseType: Decodable>(request: URLRequest,
                                        decodeTo: ResponseType.Type) -> Observable<ResponseType>
}

