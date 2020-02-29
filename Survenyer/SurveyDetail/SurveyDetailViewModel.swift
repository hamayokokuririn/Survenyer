//
//  SurveyDetailViewModel.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

class SurveyDetailViewModel: NSObject {
    
    private let cellID = "ID"

    var didSelectHandler: ((Sample) -> Void)?
    
    let name: String
    let dateString: String
    let surveyItemList: [SurveyItem]
    let sampleList: [Sample]
    
    init(name: String,
         dateString: String,
         surveyItemList: [SurveyItem],
         sampleList: [Sample]) {
        
        self.name = name
        self.dateString = dateString
        self.surveyItemList = surveyItemList
        self.sampleList = sampleList
    }
    
    var surveyItemListString: String {
        surveyItemList.reduce("") { (result, item) -> String in
            result + item.name + "/"
        }
    }
}

extension SurveyDetailViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard sampleList.indices.contains(indexPath.row) else {
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

extension SurveyDetailViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let sample = sampleList[indexPath.row]
        didSelectHandler?(sample)
    }
}
