//
//  CoinUseCase.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CoinUseCase {
    
}
extension CoinUseCase: CoinNetworkProvider {
    
    struct CoinGetParams: Codable {
        let limit: Int
        let tsym: String
    }
    
    func fetchCoin(limit: Int, tsym: String, completion: @escaping (NetworkResult<[Coin]>) -> Void) {
        let params = CoinGetParams(limit: limit, tsym: tsym)
        
        // "https://min-api.cryptocompare.com/data/top/totaltoptiervolfull"
        HttpHelper.shared.session.request(Constants.URL.Route.topTierCoin.urlAPI, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let getJSON = JSON(data)
                let getData = getJSON["Data"].arrayValue
                var listCoin = [Coin]()
                for item in getData {
                    listCoin.append(Coin(json: item))
                }
                completion(.success(listCoin))
                
            case .failure(let error):
                completion(.failed(error))
            }
        })
        
    }
    
    
}
