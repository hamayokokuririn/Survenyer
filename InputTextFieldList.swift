//
//  InputTextFieldList.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/14.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation

final class InputTextFieldList {
    var list = [SurveyInputTextField]()
    var focusedInputTextField: SurveyInputTextField
    
    init(list: [SurveyInputTextField], focusedInputTextField: SurveyInputTextField) {
        self.list = list
        self.focusedInputTextField = focusedInputTextField
    }
    
    func next() -> Bool {
        guard let index = list.firstIndex(of: focusedInputTextField) else { return false }
        let intIndex = index as Int
        if list.indices.contains(intIndex + 1) {
            focusedInputTextField = list[intIndex + 1]
            return true
        }
        return false
    }
    
    func updateFocusedInputTextField(_ textField: SurveyInputTextField) {
        self.focusedInputTextField = textField
    }
}
