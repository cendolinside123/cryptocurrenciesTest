//
//  CoinChangeUseCase.swift
//  CrptoInfo
//
//  Created by Mac on 07/01/22.
//

import Foundation
import Starscream

class CoinChangeUseCase {
//    private let key: String = "f0654a84c00ba723c9aaaaf31e968dd8c48e0bd716ba38080e37a9e0316d2966"
    private let socket: WebSocket?
    
    var coinResult: (([String: Any]) -> Void)?
    var fetchError: ((String) -> Void)?
    
    private var coinRequest: Coin?
    private var isConected: Bool = false
    private var listSubs: [String] = [String]()
    private var jsonData: Data?
    
    init() {
        var request = URLRequest(url: URL(string: Constants.URL.baseURLSocket)!)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        
    }
}

extension CoinChangeUseCase: CoinChangeNetworkProvider {
    func connect(coins: [Coin], toCurency: String, completion: (NetworkResult<Bool>) -> Void) {
        if !isConected {
            socket?.delegate = self
            
            
            listSubs = coins.filter({ $0.usdCurency.toSymbol != ""}).map({ item -> String in
                return "2~\(item.usdCurency.lastmarket)~\(item.name)~\(toCurency)"
            })
            
            let props: [String: Any] = ["action": "SubAdd", "subs": listSubs]
            do {
                jsonData = try JSONSerialization.data(withJSONObject: props, options: [])
                socket?.connect()
                completion(.success(true))
            } catch let error {
                print("error converting to json: \(error)")
                isConected = false
                completion(.failed(error))
            }
        } else {
            print("socket already request before")
            completion(.success(false))
        }
        
    }
    
    func disconect() {
        socket?.disconnect()
    }
    
    
}

extension CoinChangeUseCase: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket conected with headers info: \(headers)")
            
            socket?.write(data: jsonData!, completion: nil)
            isConected = true
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code) ")
        case .text(let textValue):
//            print("text result: \(textValue)")
            
            if let data = textValue.data(using: .utf8) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String,Any>
                    {
                       
                        if json["TYPE"] as? String == "20" {
                            print("text result: fresh start")
                        } else {
//                            print("text result: \(textValue)")
                            var webSocketValue: [String: Any] = [:]
                            if let fromSymbol = json["FROMSYMBOL"] as? String, let toSymbol = json["TOSYMBOL"] as? String, let price = json["PRICE"] as? Double {
                                webSocketValue = ["FROMSYMBOL": fromSymbol, "TOSYMBOL": toSymbol, "PRICE": price]
                            }
                            
                            if let openDay = json["OPENDAY"] as? Double {
                                webSocketValue["OPENDAY"] = openDay
                            }
                            
                            if webSocketValue.isEmpty == false {
                                self.coinResult?(webSocketValue)
                            } else {
                                print("other: \(json)")
                            }
                            
                        }
                        
                    } else {
                        print("text result bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            } else {
                print("text result failed convert to data")
            }
            
        case .binary(let data):
            print("binary result: \(data)")
        case .pong(_):
            break
        case .ping(_):
            break
        case .error(let error):
            print("error result: \(error?.localizedDescription ?? "unknow error")")
            self.fetchError?(error?.localizedDescription ?? "")
            isConected = false
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            print("reconnectSuggested")
        case .cancelled:
            isConected = false
        }
    }
    
    
}



