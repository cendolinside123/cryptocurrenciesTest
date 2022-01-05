//
//  NewsTableViewCell.swift
//  CrptoInfo
//
//  Created by Mac on 05/01/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    let labelSource = UILabel()
    let labelTitle = UILabel()
    let labelNewsBody = UILabel()
    let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        addLabelSource()
        addLabelTitle()
        addLabelNewsBody()
        addStackView()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["labelSource": labelSource, "labelTitle": labelTitle, "labelNewsBody": labelNewsBody, "contentStackView": contentStackView]
        let metrix: [String: Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentStackView constraints
        let hStackViewConstraints = "H:|-5-[contentStackView]-5-|"
        let vStackViewConstraints = "V:|-5-[contentStackView]-5-|"
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackViewConstraints, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackViewConstraints, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: labelSource constraints
        labelSource.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: labelSource, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLabelSource() {
        labelSource.font = labelSource.font.withSize(9)
        labelSource.text = ""
        labelSource.textColor = .gray
        labelSource.numberOfLines = 0
        labelSource.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(labelSource)
    }
    
    private func addLabelTitle() {
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        labelTitle.text = ""
        labelTitle.textColor = .black
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(labelTitle)
    }
    
    private func addLabelNewsBody() {
        labelNewsBody.font = labelNewsBody.font.withSize(11)
        labelNewsBody.text = ""
        labelNewsBody.textColor = .black
        labelNewsBody.numberOfLines = 0
        labelNewsBody.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(labelNewsBody)
    }
    
    private func addStackView() {
        contentStackView.addArrangedSubview(labelSource)
        contentStackView.addArrangedSubview(labelTitle)
        contentStackView.addArrangedSubview(labelNewsBody)
        self.contentView.addSubview(contentStackView)
    }
    
}
extension NewsTableViewCell {
    func setValue(news: News) {
        labelSource.text = news.source
        labelTitle.text = news.title
        labelNewsBody.text = news.body
    }
}
