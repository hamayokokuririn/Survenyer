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
    
    private var speechDetector = SpeechDetector.shared
    
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
    
    private func updateTextFieldBackgroundColor(index: Int) {
        let activeColor = UIColor(white: 0.8, alpha: 1)
        let unactiveColor = UIColor(white: 0.9, alpha: 1)
        switch index {
        case 0:
            inputA.changeBackgroundColor(activeColor)
            inputB.changeBackgroundColor(unactiveColor)
            inputC.changeBackgroundColor(unactiveColor)
        case 1:
            inputA.changeBackgroundColor(unactiveColor)
            inputB.changeBackgroundColor(activeColor)
            inputC.changeBackgroundColor(unactiveColor)
        case 2:
            inputA.changeBackgroundColor(unactiveColor)
            inputB.changeBackgroundColor(unactiveColor)
            inputC.changeBackgroundColor(activeColor)
        default:
            break
        }
    }

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Sample\(sampleNumber)"
        
        speechActiveLabel.numberOfLines = 0
        view.addSubview(speechActiveLabel)
        
        finishButton.addTarget(self, action: #selector(didPushRecognizeButton), for: .touchUpInside)
        view.addSubview(finishButton)
        
        viewModelA.handlerShouldBeginEditing = {
            self.speechDetector.startRecognition()
            self.inputTextFiledList?.updateFocusedInputTextField(self.inputA)
            self.updateTextFieldBackgroundColor(index: 0)
        }
        
        viewModelB.handlerShouldBeginEditing = {
            self.speechDetector.startRecognition()
            self.inputTextFiledList?.updateFocusedInputTextField(self.inputB)
            self.updateTextFieldBackgroundColor(index: 1)
        }
        
        viewModelC.handlerShouldBeginEditing = {
            self.speechDetector.startRecognition()
            self.inputTextFiledList?.updateFocusedInputTextField(self.inputC)
            self.updateTextFieldBackgroundColor(index: 2)
        }
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        speechDetector.delegate = self
    }
    
    @objc private func didPushRightBarButton() {
        let vc = SpeechInputViewController()
        vc.sampleNumber = sampleNumber + 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPushRecognizeButton() {
        speechDetector.chnageRecognition()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let margin = CGFloat(32)
        
        inputA.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        let inputABottom = inputA.frame.maxY
        
        inputB.frame = CGRect(x: inputA.frame.minX, y: inputABottom + margin, width: 300, height: 50)
        
        inputC.frame = CGRect(x: inputA.frame.minX, y: inputB.frame.maxY + margin, width: 300, height: 50)
        
        speechActiveLabel.frame.size.width = view.frame.size.width - 40
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
            finishButton.backgroundColor = .red
            finishButton.setTitleColor(.white, for: .normal)
            speechActiveLabel.text = "音声を認識しています\nスラッシュで次に移ります"
            return
        }
        
        finishButton.setTitle("音声認識を開始", for: .normal)
        finishButton.layer.borderColor = UIColor.red.cgColor
        finishButton.layer.borderWidth = 1
        finishButton.backgroundColor = .white
        finishButton.setTitleColor(.black, for: .normal)
        speechActiveLabel.text = "音声を認識していません"
    }
    
    private var previousText = ""
    private var previousInputTextCount = 0
}

extension SpeechInputViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechDetector, didUpdate text: String) {
        guard text != previousText else {
            return
        }
        previousText = text

        if let lastChar = text.last,
            lastChar == "/" {
            print("スラッシュ")
            previousInputTextCount = text.count
            
            if let existsNext = inputTextFiledList?.next(),
                existsNext {
                inputTextFiledList?.focusedInputTextField.becomeFirstResponderTextField()
            } else {
                inputTextFiledList?.focusedInputTextField.resignFirstResponderTextField()
                speechDetector.stopRecognition()
            }
            
            
        } else {
            let shownText: String
            if previousInputTextCount == 0 {
                shownText = text
            } else {
                shownText = String(text.dropFirst(previousInputTextCount))
            }
            inputTextFiledList?.focusedInputTextField.updateText(shownText)
        }
    }
    
    func update(_ controller: SpeechDetector, availabilityDidChange available: Bool) {
        
        updateTextForSpeechAvailable(available)
        if !available {
            previousInputTextCount = 0
        }
    }
}

