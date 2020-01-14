//
//  InputTextFieldList.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/14.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation

final class InputTextFieldList {
    var list = [SurveyInputTextFiled]()
    var focusedInputTextField: SurveyInputTextFiled
    
    init(list: [SurveyInputTextFiled], focusedInputTextField: SurveyInputTextFiled) {
        self.list = list
        self.focusedInputTextField = focusedInputTextField
    }
    
    func next() {
        guard let index = list.firstIndex(of: focusedInputTextField) else { return }
        if let intIndex = index as? Int,
            list.indices.contains(intIndex + 1) {
            focusedInputTextField = list[intIndex + 1]
        }
    }
}
