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
    
    // TODO: どの調査票のサンプルかを判断できる様にすること
    var sampleList = [Sample]()
    
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
    
    func updateSample(sample: Sample) {
        guard let index = sampleList.firstIndex(where: {
            $0.id.id == sample.id.id
        }) else {
            // 重複がない場合は新規追加
            sampleList.append(sample)
            return
        }
        sampleList[index] = sample
    }
}
