//
//  Survey.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation

struct Survey {
    let id: SurveyIdentifier
    let name: String
    let date: Date
    let surveyItems: [SurveyItem]
    let samples: [Sample]
}

struct SurveyIdentifier: Identifiable {
    let id: ObjectIdentifier
}

struct SurveyItem {
    let id: SurveyItemIdentifier
    let name: String
}

struct SurveyItemIdentifier: Identifiable {
    let id: ObjectIdentifier
}

struct Sample {
    let measuredResult: [SurveyItemIdentifier.ID: String]
}
