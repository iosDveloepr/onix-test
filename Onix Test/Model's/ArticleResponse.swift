//
//  ArticleResponse.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/3/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable{
    var articles: [Article]
}
