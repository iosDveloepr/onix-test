//
//  Article.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/3/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation

class Article: Decodable{
    
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var urlToImage : String?
    var liked: Bool?
    
}
