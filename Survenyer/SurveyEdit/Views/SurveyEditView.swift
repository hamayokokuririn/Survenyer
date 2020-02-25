//
//  SpeechFieldSettingView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/19.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SurveyEditView: UIView {
    private let dataStore = SurveyResultDataStore.shared
    
    private let inputASettingLabel = UITextField()
    private let inputBSettingLabel = UITextField()
    private let inputCSettingLabel = UITextField()
    private let saveButton = UIButton()
    
    private let didPushSaveButtonHandler: ([String]) -> ()
    
    init(didPushSaveButtonHandler: @escaping ([String]) -> ()) {
        self.didPushSaveButtonHandler = didPushSaveButtonHandler
        
        super.init(frame: .zero)
        
        inputASettingLabel.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputASettingLabel.placeholder = dataStore.fieldNames[0]
        addSubview(inputASettingLabel)
        
        inputBSettingLabel.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputBSettingLabel.placeholder = dataStore.fieldNames[1]
        addSubview(inputBSettingLabel)
        
        inputCSettingLabel.backgroundColor = UIColor(white: 0.9, alpha: 1)
        inputCSettingLabel.placeholder = dataStore.fieldNames[2]
        addSubview(inputCSettingLabel)
        
        saveButton.setTitle("保存", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.layer.borderColor = UIColor.red.cgColor
        saveButton.layer.borderWidth = 1
        saveButton.addTarget(self, action: #selector(didPushSaveButton), for: .touchUpInside)
        addSubview(saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin = CGFloat(32)
        
        inputASettingLabel.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
        
        inputBSettingLabel.frame = CGRect(x: inputASettingLabel.frame.minX,
                                          y: inputASettingLabel.frame.maxY + margin,
                                          width: 300,
                                          height: 50)
        
        inputCSettingLabel.frame = CGRect(x: inputBSettingLabel.frame.minX,
                                          y: inputBSettingLabel.frame.maxY + margin,
                                          width: 300,
                                          height: 50)
        
        saveButton.frame = CGRect(x: inputCSettingLabel.frame.minX,
                                  y: inputCSettingLabel.frame.maxY + margin,
                                  width: 300,
                                  height: 50)
    }
    
    @objc private func didPushSaveButton() {
        didPushSaveButtonHandler([inputASettingLabel.text!,
                                  inputBSettingLabel.text!,
                                  inputCSettingLabel.text!])
    }
}
