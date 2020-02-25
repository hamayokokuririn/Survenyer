//
//  SampleInputViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

final class SampleInputViewController: UIViewController {
    private var previousText = ""
    private var previousInputTextCount = 0
    
    private var sample: Sample
    
    private var speechDetector = SpeechDetector.shared
    private let dataStore = SurveyResultDataStore.shared
    
    var inputTextFiledList: InputTextFieldList?
    private var contentScrollView: UIScrollView?
    
    init(sample: Sample) {
        self.sample = sample
        super.init(nibName: nil, bundle: nil)
        setupBar(sampleName: sample.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .white
        
        contentScrollView = UIScrollView()
        if let contentScrollView = contentScrollView {
            view.addSubview(contentScrollView)
        }
        
        let handlerShouldBeginEditing = {
            self.speechDetector.startRecognition()
            self.updateTextFieldBackgroundColor(index: 0)
        }
        
        inputTextFiledList = InputTextFieldList(surveyResults: sample.results)
        inputTextFiledList?.list.forEach {
            self.contentScrollView?.addSubview($0)
        }
        inputTextFiledList?.updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        speechDetector.delegate = self
        updateTitles()
    }
    
    private func updateTitles() {
//        inputTextFiledList?.updateTitles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        storeSampleResult()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        contentScrollView?.frame = view.frame
        
        let margin = CGFloat(32)
        let sideMargin = CGFloat(16)
        var topPosition = margin
        inputTextFiledList?.list.forEach {
            $0.viewWidth = view.viewWidth - sideMargin * 2
            $0.sizeToFit()
            $0.top = topPosition
            topPosition += $0.viewHeight + margin
            $0.left = sideMargin
        }
        
        contentScrollView?.contentSize = CGSize(width: view.viewWidth, height: topPosition)
        
    }
    
    private func updateTextFieldBackgroundColor(index: Int) {
        inputTextFiledList?.updateTextFieldBackgroundColor(index: index)
    }
    
    private func storeSampleResult() {
        inputTextFiledList?.storeSampleResult()
    }
    
    @objc private func didPushNextButton() {
        
    }
    
    @objc private func didPushPreviousButton() {
        
    }
    
    private func setupBar(sampleName: String) {
        navigationItem.title = sampleName
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    
    
}

extension SampleInputViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechDetector, didUpdate text: String) {
        guard text != previousText else {
            return
        }
        previousText = text

        if let lastChar = text.last,
            lastChar == "," {
            previousInputTextCount = text.count
            
//            if let existsNext = inputTextFiledList?.next(),
//                existsNext {
//                inputTextFiledList?.focusedInputTextField.becomeFirstResponderTextField()
//            } else {
//                inputTextFiledList?.focusedInputTextField.resignFirstResponderTextField()
//                speechDetector.stopRecognition()
//            }
            
            
        } else {
            let shownText: String
            if previousInputTextCount == 0 {
                shownText = text
            } else {
                shownText = String(text.dropFirst(previousInputTextCount))
            }
//            inputTextFiledList?.focusedInputTextField.updateText(shownText)
        }
    }
    
    func update(_ controller: SpeechDetector, availabilityDidChange available: Bool) {
        
        if !available {
            previousInputTextCount = 0
        }
    }
}

extension SampleInputViewController: InputAppliable {
    enum Input {
        case setSampleName(name: String)
    }
    
    func apply(input: Input) {
        switch input {
        case .setSampleName(let name):
            navigationItem.title = name
        }
    }
}

