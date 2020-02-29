//
//  SurveyDetailView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

final class SurveyDetailView: UIView {
    
    private let sideMargin = CGFloat(16)
    
    var viewModel: SurveyDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            dateLabel.text = viewModel.dateString
            surveyItemView.setItemList(item: viewModel.surveyItemListString)
            
            sampleTable.dataSource = viewModel
            sampleTable.delegate = viewModel
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private let contentScrollView = UIScrollView()
    
    private let dateLabel = UILabel()
    private let surveyItemView = SurveyDetailItemView()
    private let sampleTable = UITableView()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(contentScrollView)
        contentScrollView.addSubview(dateLabel)
        
        contentScrollView.addSubview(surveyItemView)
        
        sampleTable.isScrollEnabled = false
        contentScrollView.addSubview(sampleTable)
        contentScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let contentWidth = viewWidth - sideMargin * 2
        dateLabel.viewWidth = contentWidth
        dateLabel.sizeToFit()
        dateLabel.left = sideMargin
        
        surveyItemView.viewWidth = contentWidth
        surveyItemView.sizeToFit()
        surveyItemView.left = sideMargin
        surveyItemView.top = dateLabel.bottom + CGFloat(24)
        
        sampleTable.viewHeight = viewHeight - surveyItemView.bottom
        sampleTable.viewWidth = viewWidth
        sampleTable.top = surveyItemView.bottom + CGFloat(24)
        
        contentScrollView.frame.size = CGSize(width: viewWidth, height: viewHeight)
        contentScrollView.contentSize = CGSize(width: viewWidth, height: viewHeight)
    }
}


