//
//  SpeechInputViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

class SpeechInputViewController: UIViewController {
    
    private let speechActiveLabel = UILabel()
    private let finishButton = UIButton()
    
    private var speechContoller = SpeechManager.shared
    
    var sampleNumber = 1
    
    let viewModelA = SurveyInputTextFiledViewModel()
    
    lazy var inputA: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "A", viewModel: self.viewModelA)
    }()
    
    let viewModelB = SurveyInputTextFiledViewModel()
    
    lazy var inputB: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "B", viewModel: self.viewModelB)
    }()
    
    let viewModelC = SurveyInputTextFiledViewModel()
    
    lazy var inputC: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "C", viewModel: self.viewModelC)
    }()
    
    var inputTextFiledList: InputTextFieldList?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Sample\(sampleNumber)"
        
        speechActiveLabel.numberOfLines = 0
        view.addSubview(speechActiveLabel)
        
        finishButton.addTarget(self, action: #selector(didPushFinishButton), for: .touchUpInside)
        finishButton.backgroundColor = .red
        view.addSubview(finishButton)
        
        viewModelA.handler = {
            self.speechContoller.chnageControl()
        }
        
        viewModelB.handler = {
            self.speechContoller.chnageControl()
        }
        
        viewModelC.handler = {
            self.speechContoller.chnageControl()
        }
        
        speechContoller.delegate = self
        
        view.addSubview(inputA)
        view.addSubview(inputB)
        view.addSubview(inputC)
        
        inputTextFiledList = InputTextFieldList(list: [inputA, inputB, inputC], focusedInputTextField: inputA)
        
        updateTextForSpeechAvailable(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(title: "Next >", style: .plain, target: self, action: #selector(didPushRightBarButton))
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func didPushRightBarButton() {
        let vc = SpeechInputViewController()
        vc.sampleNumber = sampleNumber + 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPushFinishButton() {
        speechContoller.chnageControl()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let margin = CGFloat(32)
        
        inputA.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        let inputABottom = inputA.frame.maxY
        
        inputB.frame = CGRect(x: inputA.frame.minX, y: inputABottom + margin, width: 300, height: 50)
        
        inputC.frame = CGRect(x: inputA.frame.minX, y: inputB.frame.maxY + margin, width: 300, height: 50)
        
        speechActiveLabel.sizeToFit()
        speechActiveLabel.frame.origin.x = inputA.frame.minX
        speechActiveLabel.frame.origin.y = inputC.frame.maxY + margin
        
        finishButton.frame = CGRect(x: inputA.frame.minX, y: speechActiveLabel.frame.maxY,
                                    width: 300, height: 50)
    }
    
    func updateTextForSpeechAvailable(_ available: Bool) {
        defer {
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
        if available {
            finishButton.setTitle("音声認識を止める", for: .normal)
            speechActiveLabel.text = "音声を認識しています\nスラッシュで次に移ります"
            return
        }
        
        finishButton.setTitle("音声認識を開始", for: .normal)
        speechActiveLabel.text = "音声を認識していません"
    }
    
}

extension SpeechInputViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechManager, didUpdate text: String) {
        
        if let lastChar = text.last,
            lastChar == "/" {
            print("スラッシュ")
            
            speechContoller = SpeechManager()
            speechContoller.delegate = self
            
            inputTextFiledList?.next()
            inputTextFiledList?.focusedInputTextField.becomeFirstResponderTextFiled()
            
        } else {
            inputTextFiledList?.focusedInputTextField.updateText(text)
        }
    }
    
    func update(_ controller: SpeechManager, availabilityDidChange available: Bool) {
        
        updateTextForSpeechAvailable(available)
    }
}

