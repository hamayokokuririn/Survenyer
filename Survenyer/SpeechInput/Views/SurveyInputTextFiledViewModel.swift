//
//  SurveyInputTextFiledViewModel.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/13.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyInputTextFiledViewModel: NSObject {
    var handlerShouldBeginEditing: (() -> Void)?
    
}

extension SurveyInputTextFiledViewModel: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("start!!!!")
        handlerShouldBeginEditing?()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end!!!!")
    }
}
