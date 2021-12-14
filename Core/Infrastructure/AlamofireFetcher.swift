//
//  AlamofireFetcher.swift
//  Core
//
//  Created by Diffa Desyawan on 14/12/21.
//

import Foundation
import Alamofire
import RxSwift

public class AlamofireFetcher: FetchCapable {
    let session: Session
    
    public init(session: Session = AF) {
        self.session = session
    }
    
    public func fetch<ResponseType>(request: URLRequest,
                             decodeTo: ResponseType.Type) -> Observable<ResponseType> where ResponseType : Decodable {
        
        let afRequest = session.request(request).debugLog().validate()
        
        return Observable<ResponseType>.create { observer in
            
            afRequest.responseDecodable(of: ResponseType.self) { response in
                switch response.result {
                    case .success(let value):
                        print("Success: \(value)")
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                        case 403:
                            observer.onError(ApiError.forbidden)
                        case 404:
                            observer.onError(ApiError.notFound)
                        case 500:
                            observer.onError(ApiError.internalServerError)
                        default:
                            observer.onError(error)
                        }
                }
            }
            
            return Disposables.create {
                afRequest.cancel()
            }
        }
    }
}

extension Request {
    public func debugLog() -> Self {
#if DEBUG
        cURLDescription(calling: { (curl) in
            debugPrint("=======================================")
            print(curl)
            debugPrint("=======================================")
        })
#endif
        return self
    }
}
