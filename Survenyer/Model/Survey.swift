//
//  Survey.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation

struct Survey {
    let id: SurveyIdentifier
    var name: String
    let date: Date
    var surveyItems: [SurveyItem]
    var samples: [Sample]
}

struct SurveyIdentifier: Identifiable {
    let id: Int
}

struct SurveyItem {
    let id: SurveyItemIdentifier
    let name: String
}

struct SurveyItemIdentifier: Identifiable {
    let id: Int
}

struct Sample {
    let id: SampleIdentifier
    let name: String
    var results: [SurveyResult]
    
    mutating func updateResults(_ result: SurveyResult) {
        guard let index = results.firstIndex(where: {
            $0.item.id.id == result.item.id.id
        }) else {
            return
        }
        results[index] = result
    }
}

struct SurveyResult {
    let item: SurveyItem
    let result: String
}

struct SampleIdentifier: Identifiable {
    let id: Int
}
