//
//  NewsViewController.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import UIKit

class NewsViewController: UIViewController {

    private let tableContent = UITableView()
    private var listNews = [News]()
    private var viewModel: NewsGuideline = NewsViewModel(useCase: NewsUseCase())
    private var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // Do any additional setup after loading the view.
        setLayout()
        setConstraints()
        setupTable()
        bind()
        viewModel.loadNews(category: category, reloadTime: 3)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    private func bind() {
        viewModel.newsResult = { [weak self] listNews in
            self?.listNews = listNews
            self?.tableContent.reloadData()
        }
        viewModel.fetchError = { message in
            print("error: \(message)")
        }
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        setNewsTable()
    }
    
    private func setConstraints() {
        let views: [String: Any] = ["tableContent": tableContent]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: tableContent constraints
        tableContent.translatesAutoresizingMaskIntoConstraints = false
        let hTableContent = "H:|-5-[tableContent]-5-|"
        let vTableContent = "V:|-[tableContent]-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTableContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTableContent, options: .alignAllLeading, metrics: metrix, views: views)
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setNewsTable() {
        tableContent.allowsSelection = false
        tableContent.backgroundColor = .white
        view.addSubview(tableContent)
    }
    
    private func setupTable() {
        tableContent.delegate = self
        tableContent.dataSource = self
        tableContent.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsCell")
        tableContent.rowHeight = UITableView.automaticDimension
        tableContent.estimatedRowHeight = 250
        tableContent.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableContent.tableFooterView = UIView()
    }

}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        let getItem = listNews[indexPath.row]
        cell.setValue(news: getItem)
        return cell
    }
}
extension NewsViewController {
    func setCategory(category: String) {
        self.category = category
    }
}
