//
//  NewsNetworkProvider.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
protocol NewsNetworkProvider {
    func fetchNews(category: String, success: @escaping ([News]) -> Void, failed: @escaping (Error) -> Void)
}
