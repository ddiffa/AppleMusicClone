//
//  SongRequest.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import Alamofire

public struct SongRequest: APIRequest {
    public typealias Response = [SongResponse]
    
    public var pathName: String {"/songs"}
    public var method: HTTPMethod { .get }
    
    public init() {}
}


