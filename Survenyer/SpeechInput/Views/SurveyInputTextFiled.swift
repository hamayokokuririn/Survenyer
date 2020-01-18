//
//  SurveyInputTextFiled.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/13.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyInputTextFiled: UIView {
    private let label = UILabel()
    private let textFiled = UITextField()
    
    let viewModel: SurveyInputTextFiledViewModel

    init(labelText: String, viewModel: SurveyInputTextFiledViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        
        label.text = labelText
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        addSubview(label)
        
        textFiled.delegate = viewModel
        textFiled.backgroundColor = .systemGray
        addSubview(textFiled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        
        let margin = CGFloat(8)
        let x = label.frame.size.width + margin
        textFiled.frame.size = CGSize(width: frame.width - x, height: label.frame.size.height)
        textFiled.frame.origin.x = x
    }
    
    func becomeFirstResponderTextField() {
        textFiled.becomeFirstResponder()
    }
    
    func resignFirstResponderTextField() {
        textFiled.resignFirstResponder()
    }
    
    func updateText(_ text: String) {
        textFiled.text = text
    }
}



