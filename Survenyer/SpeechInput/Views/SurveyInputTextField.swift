//
//  SurveyInputTextFiled.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/13.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyInputTextField: UIView, InputAppliable {
    enum Input {
        case setTitleTextVisibility(visible: Bool)
        case setBorderColor(color: UIColor)
    }
    
    private let sideMargin = CGFloat(8)
    private let labelToTextFieldMargin = CGFloat(4)
    private let topAndBottomMargin = CGFloat(8)
    private let textFieldHeight = CGFloat(36)
    
    private let label = UILabel()
    private let textField = UITextField()
    
    let viewModel: SurveyInputTextFiledViewModel

    var text: String {
        return textField.text ?? ""
    }
    
    init(labelText: String, viewModel: SurveyInputTextFiledViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        layer.cornerRadius = 4
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        
        label.text = labelText
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        addSubview(label)
        
        textField.delegate = viewModel
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.placeholder = "音声で入力"
        textField.layer.cornerRadius = 2
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func apply(input: Input) {
        switch input {
        case .setTitleTextVisibility(let visible):
            label.isHidden = !visible
        case .setBorderColor(let color):
            layer.borderColor = color.cgColor
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        label.viewWidth = viewWidth - sideMargin * 2
        label.top = topAndBottomMargin
        label.left = sideMargin

        textField.viewWidth = label.viewWidth
        textField.viewHeight = textFieldHeight
        textField.left = label.viewWidth
        textField.frame.origin = CGPoint(x: label.left,
                                         y: label.bottom + labelToTextFieldMargin)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        label.viewWidth = viewWidth
        label.sizeToFit()
        
        let height = topAndBottomMargin * 2 + label.viewHeight + textFieldHeight + labelToTextFieldMargin
        return CGSize(width: viewWidth,
                      height: height)
    }
    
    func becomeFirstResponderTextField() {
        textField.becomeFirstResponder()
    }
    
    func resignFirstResponderTextField() {
        textField.resignFirstResponder()
    }
    
    func updateText(_ text: String) {
        textField.text = text
    }
    
    func isSpeechTarget(_ isTarget: Bool) {
        if isTarget {
            backgroundColor = .green
            layer.borderColor = UIColor.green.cgColor
            textField.backgroundColor = .white
            return
        }
        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    func updateTitle(_ title: String) {
        label.text = title
    }
}



