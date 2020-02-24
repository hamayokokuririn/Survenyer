//
//  SurveyDetailView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

final class SurveyDetailView: UIView {
    
    var viewModel: SurveyDetailViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            dateLabel.text = viewModel.dateString
            surveyItemView.text = viewModel.surveyItemListString
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private var tableViewHeight: CGFloat {
        guard let count = viewModel?.sampleList.count else {
            return .zero
        }
        return CGFloat(count) * 60
    }
    
    private let cellID = "ID"
    
    private let contentScrollView = UIScrollView()
    
    private let dateLabel = UILabel()
    private let surveyItemView = UILabel()
    private let sampleTable = UITableView()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(contentScrollView)
        contentScrollView.addSubview(dateLabel)
        contentScrollView.addSubview(surveyItemView)
        
        sampleTable.isScrollEnabled = false
        sampleTable.dataSource = self
        contentScrollView.addSubview(sampleTable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.sizeToFit()
        
        surveyItemView.sizeToFit()
        surveyItemView.top = dateLabel.bottom + CGFloat(8)
        
        sampleTable.viewHeight = tableViewHeight
        sampleTable.viewWidth = viewWidth
        sampleTable.top = surveyItemView.bottom + CGFloat(8)
        
        contentScrollView.frame.size = CGSize(width: viewWidth, height: viewHeight)
    }
}

extension SurveyDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.sampleList.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sampleList = viewModel?.sampleList,
            sampleList.indices.contains(indexPath.row) else {
            return UITableViewCell()
        }
            
        let sample = sampleList[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = sample.name
        cell?.detailTextLabel?.text = sample.measuredResult.first!.value
        cell?.detailTextLabel?.numberOfLines = 2
        cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
        
        return cell!
    }
    
}
