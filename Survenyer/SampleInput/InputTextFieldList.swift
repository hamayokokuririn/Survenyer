//
//  InputTextFieldList.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/14.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation

final class InputTextFieldList {
    var list = [SampleInputTextField]()
    var focusedInputTextField: SampleInputTextField?
    
    init(surveyResults: [SurveyResult],
         handlerShouldBeginEditing: @escaping VoidClosure,
         didUpdateTextHandler: @escaping (SurveyResult) -> Void) {
        self.list = surveyResults.map {
            let viewModel = SurveyInputTextFiledViewModel(surveyItem: $0.item)
            viewModel.handlerShouldBeginEditing = handlerShouldBeginEditing
            viewModel.didUpdateTextHandler = didUpdateTextHandler
            let input = SampleInputTextField(viewModel: viewModel)
            input.updateText($0.result)
            return input
        }
    }
    
//    func next() -> Bool {
//        guard let index = list.firstIndex(of: focusedInputTextField) else { return false }
//        let intIndex = index as Int
//        if list.indices.contains(intIndex + 1) {
//            focusedInputTextField = list[intIndex + 1]
//            return true
//        }
//        return false
//    }
    
    func updateFocusedInputTextField(_ textField: SampleInputTextField) {
        self.focusedInputTextField = textField
    }
    
    func updateText() {
//        if let result = dataStore.surveyResult.result[navigationItem.title!] {
//            inputA.updateText(result.fieldA)
//            inputB.updateText(result.fieldB)
//            inputC.updateText(result.fieldC)
//        }
    }
    
//    func updateTitles() {
//        for (index, field) in list.enumerated() {
//            field.updateTitle(dataStore.fieldNames[index])
//        }
//    }
    
    func updateTextFieldBackgroundColor(index: Int) {
        list.forEach{$0.isSpeechTarget(false)}
        list[index].isSpeechTarget(true)
    }
    
    func storeSampleResult() {
        
//        let result = SurveySampleResult(fieldA: inputA.text,
//                                        fieldB: inputB.text,
//                                        fieldC: inputC.text)
//        dataStore.surveyResult.append(sample: [navigationItem.title!: result])
    }
}
