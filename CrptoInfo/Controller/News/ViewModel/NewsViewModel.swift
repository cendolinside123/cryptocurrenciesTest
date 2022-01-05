//
//  NewsViewModel.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import Foundation

class NewsViewModel {
    
    private let useCase: NewsNetworkProvider?
    var newsResult: (([News]) -> Void)?
    var fetchError: ((String) -> Void)?
    
    init(useCase: NewsNetworkProvider) {
        self.useCase = useCase
    }
    
}

extension NewsViewModel: NewsGuideline {
    func loadNews(category: String, reloadTime: Int) {
        useCase?.fetchNews(category: category, completion: { [weak self] result in
            switch result {
            case .success(let listBerita):
                self?.newsResult?(listBerita)
            case .failed(let error):
                if reloadTime > 0 {
                    self?.loadNews(category: category, reloadTime: reloadTime - 1)
                } else {
                    self?.fetchError?(error.localizedDescription)
                }
            }
        })
    }
}
