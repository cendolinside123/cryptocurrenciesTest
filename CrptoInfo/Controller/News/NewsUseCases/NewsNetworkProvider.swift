//
//  NewsNetworkProvider.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
protocol NewsNetworkProvider {
    func fetchNews(category: String, completion: @escaping (NetworkResult<[News]>) -> Void)
}
