//
//  NewsGuideline.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import Foundation

protocol NewsGuideline {
    func loadNews(category: String, reloadTime: Int)
    var newsResult: (([News]) -> Void)? { get set }
    var fetchError: ((String) -> Void)? { get set }
}
