//
//  MockingData.swift
//  CrptoInfoTests
//
//  Created by Mac on 07/01/22.
//

import Foundation
@testable import CrptoInfo


enum MockError: Error {
    case SampleError
}
extension MockError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .SampleError:
            return NSLocalizedString("Ini adalah test error", comment: "Mockin error")
        }
    }
}


struct MockData {
    static func generateNewsList() -> [News] {
        var listNews: [News]
        listNews = [
            News(id: "27418242", guid: "https://ambcrypto.com/?p=211399", title: "Pocket Network announces closing of its strategic private sale led by blockchain industry leaders", source: "ambcrypto", body: "Pocket Network – an infrastructure middleware protocol that provides decentralized cloud computing and abundant bandwidth on full nodes to other applications across 20 blockchains, including Ethereum, Polygon, Solana, and Harmony has closed a strategic round of $10 Million led by Republic Capital, RockTree Capital, Arrington Capital, and C2 Ventures, as well as other notable participants [&#8230;]", tags: "HideCryptopanic|No Index|Press Release", categories: "Blockchain|ETH|Sponsored", source_info: SourceInfo(name: "AMB Crypto", lang: "EN", img: "https://images.cryptocompare.com/news/default/ambcrypto.png"))
        ]
        return listNews
    }
    
    static func generateEmptyNewsList() -> [News] {
        let listNews: [News] = []
        
        return listNews
    }
}

struct SuccessNewsUseCase {
    
}
extension SuccessNewsUseCase: NewsNetworkProvider {
    func fetchNews(category: String, completion: @escaping (NetworkResult<[News]>) -> Void) {
        let data = MockData.generateNewsList()
        completion(.success(data))
    }
}

struct FailedNewsUseCase {
    
}
extension FailedNewsUseCase: NewsNetworkProvider {
    func fetchNews(category: String, completion: @escaping (NetworkResult<[News]>) -> Void) {
        completion(.failed(MockError.SampleError))
    }
    
    
}

