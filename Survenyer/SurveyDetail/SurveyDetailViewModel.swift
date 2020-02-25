//
//  SurveyDetailViewModel.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation

struct SurveyDetailViewModel {
    
    var didSelectHandler: VoidClosure?
    
    let name: String
    let dateString: String
    let surveyItemList: [SurveyItem]
    let sampleList: [Sample]
    
    var surveyItemListString: String {
        surveyItemList.reduce("") { (result, item) -> String in
            result + item.name + "/"
        }
    }
}
