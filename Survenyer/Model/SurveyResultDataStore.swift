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
    
    var surveyResult = SurveyResultCodable(result: [String : SurveySampleResult]())
    
    var fieldNames = ["A", "B", "C", "D", "E", "F", "G", "H"]
    
    func updateSettingFieldNames(_ fieldNames: [String]) {
        self.fieldNames = fieldNames
    }
    
    func shareItems() -> [String] {
        
        guard let data = try? JSONEncoder().encode(surveyResult) else {
            return []
        }
        let string = String(data: data, encoding: .utf8)!
        return [string]
    }
}
