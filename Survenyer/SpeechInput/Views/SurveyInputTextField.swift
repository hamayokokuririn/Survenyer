//
//  SurveyInputTextFiled.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/13.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyInputTextField: UIView {
    private let label = UILabel()
    private let textField = UITextField()
    
    let viewModel: SurveyInputTextFiledViewModel

    var text: String {
        return textField.text ?? ""
    }
    
    init(labelText: String, viewModel: SurveyInputTextFiledViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        
        label.text = labelText
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        addSubview(label)
        
        textField.delegate = viewModel
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        label.frame.size.width = frame.size.width
        
        textField.frame.size.width = label.frame.width
        textField.frame.size.height = 36
        textField.frame.origin = CGPoint(x: label.frame.minX,
                                         y: label.frame.maxY)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        label.frame.size.width = frame.size.width
        label.sizeToFit()
        
        return CGSize(width: size.width,
                      height: label.frame.height * 2)
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
    
    func changeBackgroundColor(_ color: UIColor) {
        textField.backgroundColor = color
    }
    
    func updateTitle(_ title: String) {
        label.text = title
    }
}



