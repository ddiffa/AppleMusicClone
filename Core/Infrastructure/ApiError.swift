//
//  ApiError.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation


enum ApiError: Error {
    case forbidden
    case notFound
    case unAuthorized
    case internalServerError
}
