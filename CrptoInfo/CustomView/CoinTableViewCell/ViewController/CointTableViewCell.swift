//
//  CointTableViewCell.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import UIKit

class CointTableViewCell: UITableViewCell {

    let labelCoinCode = UILabel()
    let labelCoinName = UILabel()
    let labelPrice = UILabel()
    let labelChange = UILabel()
    let nameStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    let changeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup() {
        self.backgroundColor = .white
        addLayouts()
        addConstraints()
    }
    
    private func addLayouts() {
        addLabelCoinCode()
        addLabelCoinName()
        addLabelPrice()
        addLabelChange()
        addStackView()
    }

    private func addConstraints() {
        let views: [String: Any] = ["labelCoinCode": labelCoinCode, "labelCoinName": labelCoinName, "labelPrice": labelPrice, "labelChange": labelChange, "contentStackView": contentStackView, "nameStackView": nameStackView, "changeStackView": changeStackView]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hStackViewConstraints = "H:|-5-[contentStackView]-5-|"
        let vStackViewConstraints = "V:|-5-[contentStackView]-5-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackViewConstraints, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackViewConstraints, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: nameStackView and changeStackView constraints
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        changeStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: nameStackView, attribute: .width, relatedBy: .equal, toItem: changeStackView, attribute: .width, multiplier: 5/3, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLabelCoinCode() {
        labelCoinCode.font = UIFont.boldSystemFont(ofSize: 18)
        labelCoinCode.textColor = .black
        contentView.addSubview(labelCoinCode)
    }
    
    private func addLabelCoinName() {
        labelCoinName.font = labelCoinName.font.withSize(9)
        labelCoinName.textColor = .gray
        contentView.addSubview(labelCoinName)
    }
    
    private func addLabelPrice() {
        labelPrice.font = UIFont.boldSystemFont(ofSize: 18)
        labelPrice.textAlignment = .right
        labelPrice.textColor = .black
        contentView.addSubview(labelPrice)
    }
    
    private func addLabelChange() {
        labelChange.textAlignment = .center
        labelChange.textColor = .white
        labelChange.backgroundColor = .gray
        contentView.addSubview(labelChange)
    }
    private func addStackView() {
        nameStackView.addArrangedSubview(labelCoinCode)
        nameStackView.addArrangedSubview(labelCoinName)
        contentView.addSubview(nameStackView)
        
        changeStackView.addArrangedSubview(labelPrice)
        changeStackView.addArrangedSubview(labelChange)
        contentView.addSubview(changeStackView)
        
        contentStackView.addArrangedSubview(nameStackView)
        contentStackView.addArrangedSubview(changeStackView)
        contentView.addSubview(contentStackView)
    }
}

extension CointTableViewCell {
    func setValue(coin: Coin) {
        labelCoinName.text = coin.fullName
        labelCoinCode.text = coin.name
        labelPrice.text = "\(coin.usdCurency.toSymbol)\(coin.usdCurency.price)"
        labelChange.text = "\(String(format: "%.2f", coin.usdCurency.change))(\(coin.usdCurency.changePercent))"
        if coin.usdCurency.change.sign == .minus {
            labelChange.backgroundColor = .red
        } else {
            labelChange.backgroundColor = .green
        }
    }
}
