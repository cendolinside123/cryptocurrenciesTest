//
//  HTTPHelper.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import Foundation
import Alamofire

class HttpHelper {
    static let shared = HttpHelper()
    lazy var session: Session = {
        let sessionManager = URLSessionConfiguration.default
        sessionManager.urlCache = nil
        sessionManager.requestCachePolicy = .reloadIgnoringCacheData
        sessionManager.timeoutIntervalForRequest = 60
        
        return Session(configuration: sessionManager)
    }()
}
