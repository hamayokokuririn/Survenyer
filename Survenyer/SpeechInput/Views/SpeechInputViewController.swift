//
//  SpeechInputViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

class SpeechInputViewController: UIViewController,  InputAppliable {
    enum Input {
        case setSampleName(name: String)
    }
    
    func apply(input: Input) {
        switch input {
        case .setSampleName(let name):
            navigationItem.title = name
        }
    }
    
    private var previousText = ""
    private var previousInputTextCount = 0
    
    private var speechDetector = SpeechDetector.shared
    private let dataStore = SurveyResultDataStore.shared
    
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
    
    init(sampleName: String) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = sampleName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        
        hideKeyboardWhenTappedAround()

        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextButton =
            UIBarButtonItem(title: "進む"
                , style: .plain,
                  target: self,
                  action: #selector(didPushNextButton))
        
        let previousButton =
            UIBarButtonItem(title: "戻る"
                , style: .plain,
                  target: self,
                  action: #selector(didPushPreviousButton))
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                  target: nil, action: nil)
        toolbarItems = [flexibleSpaceButton, previousButton, nextButton]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc private func didPushNextButton() {
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
        
        let mainFrame = UIScreen.main.bounds
        let sideMargin = CGFloat(16)
        inputA.viewWidth = mainFrame.width - sideMargin * 2
        inputA.sizeToFit()
        inputA.top = (navigationController?.navigationBar.bottom ?? CGFloat(44)) +  margin
        inputA.left = sideMargin
        
        inputB.viewWidth = inputA.viewWidth
        inputB.sizeToFit()
        inputB.top = inputA.bottom + margin
        inputB.left = inputA.left
        
        inputC.viewWidth = inputA.viewWidth
        inputC.sizeToFit()
        inputC.top = inputB.bottom + margin
        inputC.left = inputA.left
    }
    
    private func updateTextFieldBackgroundColor(index: Int) {
        switch index {
        case 0:
            inputA.isSpeechTarget(true)
            inputB.isSpeechTarget(false)
            inputC.isSpeechTarget(false)
        case 1:
            inputA.isSpeechTarget(false)
            inputB.isSpeechTarget(true)
            inputC.isSpeechTarget(false)
        case 2:
            inputA.isSpeechTarget(false)
            inputB.isSpeechTarget(false)
            inputC.isSpeechTarget(true)
        default:
            inputA.isSpeechTarget(false)
            inputB.isSpeechTarget(false)
            inputC.isSpeechTarget(false)
        }
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
    
    @objc private func didPushPreviousButton() {
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
        
        if !available {
            previousInputTextCount = 0
        }
    }
}

