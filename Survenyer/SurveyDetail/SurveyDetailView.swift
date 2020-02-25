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
            
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private let cellID = "ID"
    
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
        sampleTable.dataSource = self
        sampleTable.delegate = self
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
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = sample.name
        cell?.detailTextLabel?.text = sample.results.first?.result ?? ""
        cell?.detailTextLabel?.numberOfLines = 2
        cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "サンプル"
    }
    
}

extension SurveyDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectHandler?()
    }
}
