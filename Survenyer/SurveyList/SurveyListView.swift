//
//  SurveyListView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

final class SurveyListView: UIView {
    var viewModel: SurveyListViewModel {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private let table = UITableView()
    private let cellID = "ID"
    init(viewModel: SurveyListViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        table.dataSource = self
        table.delegate = self
        addSubview(table)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        table.frame = frame
    }
}

extension SurveyListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelectedHandler()
    }
}

extension SurveyListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let survey = viewModel.list[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = survey.name
        cell?.detailTextLabel?.text = survey.dateString
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
}
