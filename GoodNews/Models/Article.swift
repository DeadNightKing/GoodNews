//
//  Article.swift
//  GoodNews
//
//  Created by Flow_RyanChou on 2022/7/28.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
