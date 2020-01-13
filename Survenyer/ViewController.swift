//
//  ViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var speechContoller: SpeechController? = SpeechController()
    
    let viewModelA = SurveyInputTextFiledViewModel()
    
    lazy var inputA: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "A", viewModel: self.viewModelA)
    }()
    
    let viewModelB = SurveyInputTextFiledViewModel()
    
    lazy var inputB: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "B", viewModel: self.viewModelA)
    }()
    
    var focusedTextFiled: SurveyInputTextFiled?
    
    override func loadView() {
        super.loadView()
        
        self.focusedTextFiled = inputA
        
        viewModelA.handler = {
            self.speechContoller?.chnageControl()
        }
        
        viewModelB.handler = {
            self.speechContoller?.chnageControl()
        }
        
        speechContoller?.delegate = self
        
        view.addSubview(inputA)
        view.addSubview(inputB)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let margin = CGFloat(32)
        
        inputA.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        let inputABottom = inputA.frame.maxY
        
        inputB.frame = CGRect(x: inputA.frame.minX, y: inputABottom + margin, width: 300, height: 50)
    }
    
}

extension ViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechController, didUpdate text: String) {
        print(text)
        focusedTextFiled?.updateText(text)
        
        if let lastChar = text.last,
            lastChar == "," {
            print("カンマ")
            
            speechContoller = SpeechController()
            speechContoller?.delegate = self
            
            inputB.becomeFirstResponderTextFiled()
            focusedTextFiled = inputB
        }
    }
}

