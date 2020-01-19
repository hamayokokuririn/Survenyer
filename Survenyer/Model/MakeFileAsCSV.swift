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
    let surveyResult: SurveyResult
    
    func makeStringAsCSV() -> String {
        let csv = try! CSVWriter(stream: .toMemory())

        // Write a row
        try! csv.write(row: ["sample", "inputA", "inputB", "inputC"])

        for sample in surveyResult.result {
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
    
    func exportFileAsCSV() {
        
        let stream = OutputStream(toFileAtPath: "/path/to/file.csv", append: false)!
        let csv = try! CSVWriter(stream: stream)

        try! csv.write(row: ["id", "name"])
        try! csv.write(row: ["1", "foo"])
        try! csv.write(row: ["1", "bar"])

        csv.stream.close()

    }
    
}
