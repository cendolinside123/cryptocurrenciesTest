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
    private var viewModel: CoinGuideline = CoinViewModel(useCase: CoinUseCase(), webSocket: CoinChangeUseCase())
    private var uiControll: ListUIGuideHelper?
    private var coinChangeControl: CoinWebSocketUIGuide?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Toplists"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        // Do any additional setup after loading the view.
        setLayout()
        setConstraints()
        setupTable()
        uiControll = ListCoinUIControll(controller: self)
        coinChangeControl = CoinWebSocketUIController(controller: self)
        bind()
        viewModel.loadCoins(limit: 50, tsym: "USD", reloadTime: 3)
    }
    
    private func bind() {
        viewModel.coinResult = { [weak self] listCoins in
            self?.listCoin = listCoins
            self?.tableContent.reloadData()
            self?.hideLoading()
            self?.viewModel.coinsWebSocket(coins: listCoins, toCurency: "USD", retryTime: 3)
        }
        viewModel.fetchError = { [weak self] message in
            print("error: \(message)")
            self?.hideLoading()
        }
        viewModel.webSocketResponse = { [weak self] updateValue in
            self?.coinChangeControl?.editListData(newValue: updateValue)
        }
        viewModel.webSocketError = { message in
            print("websocket error: \(message)")
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
        uiControll?.hideLoading(completion: nil)
    }
    
    private func showLoading(completion: @escaping () -> Void) {
        uiControll?.showLoading(completion: {
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

extension ListCoinViewController {
    func getLoadingView() -> UIView {
        return loadingView
    }
    
    func getLoadingSpinner() -> UIActivityIndicatorView {
        return loadingSpinner
    }
    
    func getTableView() -> UITableView {
        return tableContent
    }
    
    func getListCoin() -> [Coin] {
        return listCoin
    }
    
    func updatePriceSelectedData(index: Int, coin: Coin) {
        let getIndex = IndexPath(row: index, section: 0)
        guard let cell = tableContent.cellForRow(at: getIndex) as? CointTableViewCell else {
            return
        }
        listCoin[index].usdCurency.price = coin.usdCurency.price
        listCoin[index].usdCurency.openDay = coin.usdCurency.openDay
        listCoin[index].usdCurency.countChange()
        cell.setValue(coin: coin)
        tableContent.reloadRows(at: [getIndex], with: .automatic)
        
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
        uiControll?.scrollControll(scrollView: scrollView, completion: { [weak self] in
            self?.viewModel.loadCoins(limit: 50, tsym: "USD", reloadTime: 3)
        })
    }
}
