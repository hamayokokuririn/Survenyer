//
//  SurveyResultDataStore.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/18.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyResultDataStore {
    static let shared = SurveyResultDataStore()
    
    var surveyResult: SurveyResult = SurveyResult(result: [String : SurveySampleResult]())
    
    func shareItems() -> [String] {
        
        guard let data = try? JSONEncoder().encode(surveyResult) else {
            return []
        }
        let string = String(data: data, encoding: .utf8)!
        return [string]
        
    }
}
