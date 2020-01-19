//
//  SpeechInputViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

class SpeechInputViewController: UIViewController {
    
    private var previousText = ""
    private var previousInputTextCount = 0
    
    private let speechActiveLabel = UILabel()
    private let recognizeButton = UIButton()
    
    private var speechDetector = SpeechDetector.shared
    private let dataStore = SurveyResultDataStore.shared
    
    var sampleNumber = 1
    
    let viewModelA = SurveyInputTextFiledViewModel()
    
    lazy var inputA: SurveyInputTextField = {
        return SurveyInputTextField(labelText: self.dataStore.fieldNames[0], viewModel: self.viewModelA)
    }()
    
    let viewModelB = SurveyInputTextFiledViewModel()
    
    lazy var inputB: SurveyInputTextField = {
        return SurveyInputTextField(labelText: self.dataStore.fieldNames[1], viewModel: self.viewModelB)
    }()
    
    let viewModelC = SurveyInputTextFiledViewModel()
    
    lazy var inputC: SurveyInputTextField = {
        return SurveyInputTextField(labelText: self.dataStore.fieldNames[2], viewModel: self.viewModelC)
    }()
    
    var inputTextFiledList: InputTextFieldList?
    
    override func loadView() {
        super.loadView()
        
        
        hideKeyboardWhenTappedAround()

        view.backgroundColor = .white
        
        navigationItem.title = "Sample\(sampleNumber)"
        
        speechActiveLabel.numberOfLines = 0
        view.addSubview(speechActiveLabel)
        
        recognizeButton.addTarget(self, action: #selector(didPushRecognizeButton), for: .touchUpInside)
        view.addSubview(recognizeButton)
        
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
        
        if let result = dataStore.surveyResult.result[navigationItem.title!] {
            inputA.updateText(result.fieldA)
            inputB.updateText(result.fieldB)
            inputC.updateText(result.fieldC)
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
        navigationItem.rightBarButtonItem = rightBarButton
        
        let speechFieldSettingButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                                       target: self, action: #selector(didPushSettingEditButton))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action,
                                          target: self, action: #selector(didPushShareButton))
        toolbarItems = [speechFieldSettingButton, shareButton]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc private func didPushSettingEditButton() {
        let vc = SpeechFieldSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        speechDetector.delegate = self
        updateTitles()
    }
    
    private func updateTitles() {
        inputA.updateTitle(dataStore.fieldNames[0])
        inputB.updateTitle(dataStore.fieldNames[1])
        inputC.updateTitle(dataStore.fieldNames[2])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        storeSampleResult()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let margin = CGFloat(32)
        
        inputA.frame.size.width = 300
        inputA.sizeToFit()
        inputA.frame.origin = CGPoint(x: 20, y: 100)
        
        inputB.frame.size.width = 300
        inputB.sizeToFit()
        inputB.frame.origin = CGPoint(x: inputA.frame.minX, y: inputA.frame.maxY + margin)
        
        inputC.frame.size.width = 300
        inputC.sizeToFit()
        inputC.frame.origin = CGPoint(x: inputA.frame.minX, y: inputB.frame.maxY + margin)
        
        speechActiveLabel.frame.size.width = view.frame.size.width - 40
        speechActiveLabel.sizeToFit()
        speechActiveLabel.frame.origin.x = inputA.frame.minX
        speechActiveLabel.frame.origin.y = inputC.frame.maxY + margin
        
        recognizeButton.frame = CGRect(x: inputA.frame.minX,
                                       y: speechActiveLabel.frame.maxY,
                                       width: 300,
                                       height: 50)
    }
    
    func updateTextForSpeechAvailable(_ available: Bool) {
        defer {
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
        if available {
            recognizeButton.setTitle("音声認識を止める", for: .normal)
            recognizeButton.backgroundColor = .red
            recognizeButton.setTitleColor(.white, for: .normal)
            speechActiveLabel.text = "音声を認識しています\nコンマで次に移ります"
            return
        }
        
        recognizeButton.setTitle("音声認識を開始", for: .normal)
        recognizeButton.layer.borderColor = UIColor.red.cgColor
        recognizeButton.layer.borderWidth = 1
        recognizeButton.backgroundColor = .white
        recognizeButton.setTitleColor(.black, for: .normal)
        speechActiveLabel.text = "音声を認識していません"
    }
    
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
            inputA.changeBackgroundColor(unactiveColor)
            inputB.changeBackgroundColor(unactiveColor)
            inputC.changeBackgroundColor(unactiveColor)
        }
    }
    
    @objc private func didPushRightBarButton() {
        let vc = SpeechInputViewController()
        vc.sampleNumber = sampleNumber + 1
        storeSampleResult()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPushRecognizeButton() {
        speechDetector.chnageRecognition()
        inputA.becomeFirstResponderTextField()
    }
    
    private func storeSampleResult() {
        let result = SurveySampleResult(fieldA: inputA.text,
                                        fieldB: inputB.text,
                                        fieldC: inputC.text)
        dataStore.surveyResult.append(sample: [navigationItem.title!: result])
    }
    
    private func showFileNameInputAlert() {
        let ac = UIAlertController(title: "ファイル名を入力", message: "CSV形式で保存します", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: {[weak ac] (action) -> Void in
            guard let text = ac?.textFields?.first?.text else {
                return
            }
            guard !text.isEmpty else {
                return
            }
            self.showShareSheet(fileName: text)
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        //textfiled1の追加
        ac.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = ".csvは不要です"
        })

        ac.addAction(ok)
        ac.addAction(cancel)

        present(ac, animated: true, completion: nil)
    }
    
    private func showShareSheet(fileName: String) {
        let maker = MakeFileAsCSV(surveyResult: dataStore.surveyResult)
        let item = maker.exportFileAsCSV(fileName: fileName)
        // 初期化
        let activityVC = UIActivityViewController(activityItems: [item], applicationActivities: nil)
        
        // UIViewを出すViewを指定：iPadでは以下を入れないと落ちる
        activityVC.popoverPresentationController?.sourceView = view
        
        // 共有で使用しないタイプを指定
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.print
        ]
        
        // タイプを登録
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC,
                     animated: true,
                         completion: nil)
    }
    
    @objc private func didPushShareButton() {
        storeSampleResult()
        showFileNameInputAlert()
    }
}

extension SpeechInputViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechDetector, didUpdate text: String) {
        guard text != previousText else {
            return
        }
        previousText = text

        if let lastChar = text.last,
            lastChar == "," {
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

