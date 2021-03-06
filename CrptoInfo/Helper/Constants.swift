//
//  Constants.swift
//  CrptoInfo
//
//  Created by Jan Sebastian on 10/05/22.
//

import Foundation

struct Constants {
    static let keyWebhook: String = "f0654a84c00ba723c9aaaaf31e968dd8c48e0bd716ba38080e37a9e0316d2966"
    struct URL {
        static let baseURLSocket: String = "wss://streamer.cryptocompare.com/v2?api_key=\(Constants.keyWebhook)"
        static let baseURL: String = "https://min-api.cryptocompare.com/data"
        struct Route {
            static let topTierCoin: String = "/top/totaltoptiervolfull"
            static let listNews: String = "/v2/news/"
        }
    }
}

enum CurrencyName: String {
    case USD = "USD"
}

enum ErrorMessage: Error, LocalizedError {
    case unknow
    
    var errorDescription: String? {
        switch self {
        case .unknow:
            return NSLocalizedString(
                "Unknow error",
                comment: ""
            )
        }
    }
}
