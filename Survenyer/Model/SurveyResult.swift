//
//  SurveyResult.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/18.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation

struct SurveyResult: Codable {
    let result: [String: SurveySampleResult]
}

struct SurveySampleResult: Codable {
    let fieldA: String
    let fieldB: String
    let fieldC: String
}
