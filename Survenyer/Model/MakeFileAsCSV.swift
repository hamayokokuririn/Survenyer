//
//  ExportAsCSV.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/19.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import CSV

struct MakeFileAsCSV {
    let surveyResult: SurveyResultCodable
    
    private func makeStringAsCSV() -> String {
        let csv = try! CSVWriter(stream: .toMemory())

        // Write a row
        try! csv.write(row: ["sample", "inputA", "inputB", "inputC"])

        let sortedResult = surveyResult.result.sorted { (result1, result2) -> Bool in
            result1.key.localizedStandardCompare(result2.key) == .orderedAscending
        }
        for sample in sortedResult {
            csv.beginNewRow()
            try! csv.write(field: sample.key)
            try! csv.write(field: sample.value.fieldA)
            try! csv.write(field: sample.value.fieldB)
            try! csv.write(field: sample.value.fieldC)
        }
        csv.stream.close()

        // Get a String
        let csvData = csv.stream.property(forKey: .dataWrittenToMemoryStreamKey) as! Data
        let csvString = String(data: csvData, encoding: .utf8)!
        print(csvString)
        return csvString
    }
    
    func exportFileAsCSV(fileName: String) -> URL {
        
        let tmpPath = FileManager.default.temporaryDirectory
        let filePath = tmpPath.appendingPathComponent("\(fileName).csv")
        let csvString = makeStringAsCSV()
        do {
            try csvString.write(to: filePath, atomically: true, encoding: .shiftJIS)
        } catch {
            print(error)
        }
        
        return filePath
    }
    
}
