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
    var surveyResult: SurveyResult?
    
    func shareItems() -> [String] {
                guard let surveyResult = surveyResult else {
            return []
        }
        guard let data = try? JSONEncoder().encode(surveyResult) else {
            return []
        }
        let string = String(data: data, encoding: .utf8)!
        return [string]
                    
    }
}
