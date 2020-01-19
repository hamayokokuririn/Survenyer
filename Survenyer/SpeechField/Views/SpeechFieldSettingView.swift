//
//  SpeechFieldSettingView.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/19.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SpeechFieldSettingView: UIView {
    private let dataStore = SurveyResultDataStore.shared
    
    private let inputASettingLabel = UITextField()
    private let inputBSettingLabel = UITextField()
    private let inputCSettingLabel = UITextField()
    private let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        inputASettingLabel.placeholder = "項目Aの名前"
        addSubview(inputASettingLabel)
        
        inputBSettingLabel.placeholder = "項目Bの名前"
        addSubview(inputBSettingLabel)
        
        inputCSettingLabel.placeholder = "項目Cの名前"
        addSubview(inputCSettingLabel)
        
        saveButton.setTitle("保存", for: .normal)
        saveButton.backgroundColor = .cyan
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
//        dataStore.updateSettingField()
    }
}
