//
//  NewsViewController.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import UIKit

class NewsViewController: UIViewController {

    private let tableContent = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        setNewsTable()
    }
    
    private func setConstraints() {
        let views: [String: Any] = ["tableContent": tableContent]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: tableContent constraints
        tableContent.translatesAutoresizingMaskIntoConstraints = false
        let hTableContent = "H:|-0-[tableContent]-0-|"
        let vTableContent = "V:|-0-[tableContent]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTableContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTableContent, options: .alignAllLeading, metrics: metrix, views: views)
        NSLayoutConstraint.activate(constraints)
        
    }
    
    private func setNewsTable() {
        tableContent.allowsSelection = false
        view.addSubview(tableContent)
    }

}
