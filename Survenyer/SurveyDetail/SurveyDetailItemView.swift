//
//  SurveyDetailItemView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/25.
//

import Foundation
import UIKit

final class SurveyDetailItemView: UIView {
    private let margin = CGFloat(4)
    
    private let titleLabel = UILabel()
    private let itemListLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.text = "調査項目"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(titleLabel)
        
        itemListLabel.numberOfLines = 0
        itemListLabel.lineBreakMode = .byWordWrapping
        itemListLabel.font = UIFont.preferredFont(forTextStyle: .body)
        addSubview(itemListLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setSizeViews()
        itemListLabel.top = titleLabel.bottom + margin
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        setSizeViews()
        let height = titleLabel.viewHeight + margin + itemListLabel.viewHeight
        return CGSize(width: viewWidth, height: height)
    }
    
    private func setSizeViews() {
        titleLabel.sizeToFit()
        itemListLabel.viewWidth = viewWidth
        itemListLabel.sizeToFit()
    }
    
    func setItemList(item: String) {
        itemListLabel.text = item
    }
}
