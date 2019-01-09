//
//  APIManagerInterface.swift
//  Onix Test
//
//  Created by Yermakov Anton on 1/3/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation

protocol APIManagerInterface{
    func genericFetch<T: Decodable>(urlString: String, completion: @escaping (T?, APIError?) -> ()) 
}
