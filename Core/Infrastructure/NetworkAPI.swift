import Alamofire
////
////  NetworkAPI.swift
////  Core
////
////  Created by Diffa Desyawan on 13/12/21.
////
//
import Foundation
import Alamofire
import RxSwift
import UIKit

public class NetworkAPI<Request: APIRequest> {
    
    private var fetcher: FetchCapable
    
    public init(fetcher: FetchCapable = AlamofireFetcher()) {
        self.fetcher = fetcher
    }
    
    public func fetch(_ request: Request) -> Observable<Request.Response> {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.method = request.method
        urlRequest.headers.add(.contentType(request.contentType))
        
        return self.fetcher.fetch(request: urlRequest,
                                  decodeTo: Request.Response.self)
    }
}
