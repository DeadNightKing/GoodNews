//
//  URLRequest+Extensions.swift
//  GoodNews
//
//  Created by Flow_RyanChou on 2022/7/28.
//

import Foundation
import RxSwift
import RxCocoa

struct Resourse<T: Decodable> {
    let url: URL
}

extension URLRequest {
    
    static func load<T>(resourse: Resourse<T>) -> Observable<T> {
        
        return Observable.just(resourse.url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
        
        
    }
    
    
    
}
