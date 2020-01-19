//
//  SpeechFieldSettingViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/19.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

final class SpeechFieldSettingViewController: UIViewController {
    private let dataStore = SurveyResultDataStore.shared
    
    private lazy var mainView = SpeechFieldSettingView { (names: [String]) in
        self.dataStore.updateSettingFieldNames(names)
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        view.addSubview(mainView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.frame = UIScreen.main.bounds
        mainView.frame = view.frame
    }
}
