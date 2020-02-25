//
//  SurveyResult.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/18.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation

struct SurveyResultCodable: Codable {
    var result: [String: SurveySampleResult]
    
    mutating func append(sample: [String: SurveySampleResult]) {
        result.merge(sample) {$1}
    }
}

struct SurveySampleResult: Codable {
    let fieldA: String
    let fieldB: String
    let fieldC: String
}
