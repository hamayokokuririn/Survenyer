//
//  SurveyListViewModel.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation

typealias VoidClosure = () -> Void

struct SurveyListViewModel {
    
    let list: [SurveyViewModel]
    let didSelectedHandler: VoidClosure
    
    struct SurveyViewModel {
        let name: String
        let dateString: String
        
        init(name: String, dateString: String) {
            self.name = name
            self.dateString = dateString
        }
        
        init(survey: Survey) {
            self.name = survey.name
            let dateFormatter = DateFormatter()
            dateFormatter.calendar = Calendar(identifier: .gregorian)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: survey.date)
            self.dateString = dateString
        }
    }
}
