//
//  ListCoinViewController.swift
//  CrptoInfo
//
//  Created by Mac on 06/01/22.
//

import UIKit

class ListCoinViewController: UIViewController {
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let tableContent = UITableView()
    private var listCoin = [Coin]()
    private var viewModel: CoinGuideline = CoinViewModel(useCase: CoinUseCase())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Toplists"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // Do any additional setup after loading the view.
        setLayout()
        setConstraints()
        setupTable()
        bind()
        viewModel.loadCoins(limit: 50, tsym: "USD", reloadTime: 3)
    }
    
    private func bind() {
        viewModel.coinResult = { [weak self] listCoins in
            self?.listCoin = listCoins
            self?.tableContent.reloadData()
            self?.hideLoading()
            
        }
        viewModel.fetchError = { message in
            print("error: \(message)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func setLayout() {
        view.backgroundColor = .white
        setLoadingView()
        setCoinTable()
    }
    
    private func setConstraints() {
        let views: [String: Any] = ["loadingView": loadingView, "tableContent": tableContent, "loadingSpinner": loadingSpinner]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: tableContent and loadingView constraints
        tableContent.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let hTableContent = "H:|-5-[tableContent]-5-|"
        let vTableContentLoadingView = "V:|-[loadingView]-0-[tableContent]-|"
        let hLoadingView = "H:|-0-[loadingView]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTableContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTableContentLoadingView, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        let loadingViewHeight = NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)
        loadingViewHeight.identifier = "loadingViewHeight"
        constraints += [loadingViewHeight]
        
        //MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func hideLoading() {
        var constraints = view.constraints
        
        guard let getLoadingHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingViewHeight"
        }) else {
            return
        }
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let superSelf = self else {
                return
            }
            
            constraints[getLoadingHeigh] = NSLayoutConstraint(item: superSelf.loadingView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
            constraints[getLoadingHeigh].identifier = "loadingViewHeight"
            NSLayoutConstraint.activate(constraints)
            superSelf.loadingSpinner.stopAnimating()
            superSelf.view.layoutIfNeeded()
        })
    }
    
    private func showLoading(completion: @escaping () -> Void) {
        var constraints = loadingView.constraints
        
        guard let getLoadingHeigh = constraints.firstIndex(where: { (constraint) -> Bool in
            constraint.identifier == "loadingViewHeight"
        }) else {
            return
        }
        NSLayoutConstraint.deactivate(constraints)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let superSelf = self else {
                return
            }
            
            constraints[getLoadingHeigh] = NSLayoutConstraint(item: superSelf.loadingView, attribute: .height, relatedBy: .equal, toItem: superSelf.view, attribute: .height, multiplier: 1/9, constant: 0)
            constraints[getLoadingHeigh].identifier = "loadingViewHeight"
            NSLayoutConstraint.activate(constraints)
            superSelf.loadingSpinner.startAnimating()
            superSelf.view.layoutIfNeeded()
        }, completion: { _ in
            completion()
        })
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }
    
    private func setCoinTable() {
        tableContent.backgroundColor = .white
        view.addSubview(tableContent)
    }
    
    private func setupTable() {
        tableContent.delegate = self
        tableContent.dataSource = self
        tableContent.register(CointTableViewCell.self, forCellReuseIdentifier: "CoinCell")
        tableContent.rowHeight = 50
        tableContent.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableContent.tableFooterView = UIView()
    }

    
    
}
extension ListCoinViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCoin.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CointTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let getItem = listCoin[indexPath.row]
        cell.setValue(coin: getItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getItem = listCoin[indexPath.row]
        let newsVC = NewsViewController()
        newsVC.setCategory(category: getItem.name)
        let nav = UINavigationController(rootViewController: newsVC)
        nav.navigationBar.barTintColor = .white
        present(nav, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentSize.height > self.view.frame.size.height && scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentSize.height - scrollView.frame.size.height), animated: false)
        } else if scrollView.contentOffset.y <= 0 {
            showLoading(completion: { [weak self] in
                self?.viewModel.loadCoins(limit: 50, tsym: "USD", reloadTime: 3)
            })
        }
    }
}
