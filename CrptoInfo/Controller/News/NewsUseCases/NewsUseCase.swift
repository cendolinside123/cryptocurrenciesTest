//
//  NewsUseCase.swift
//  CrptoInfo
//
//  Created by Mac on 04/01/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct NewsUseCase {
    
}

extension NewsUseCase: NewsNetworkProvider {
    
    struct NewsGETParams : Codable {
        let lang: String
        let categories: String
    }
    
    func fetchNews(category: String, completion: @escaping (NetworkResult<[News]>) -> Void) {
        
        let params: NewsGETParams = NewsGETParams(lang: "EN", categories: category)
        // "https://min-api.cryptocompare.com/data/v2/news/"
        HttpHelper.shared.session.request(Constants.URL.Route.listNews.urlAPI, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let getJSON = JSON(data)
                let getData = getJSON["Data"].arrayValue
                var listBerita = [News]()
                for item in getData {
                    listBerita.append(News(json: item))
                }
                completion(.success(listBerita))
                
            case .failure(let error):
                completion(.failed(error))
            }
        })
    }
    
    
}

