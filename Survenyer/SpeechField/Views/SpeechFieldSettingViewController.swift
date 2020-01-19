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
    private let mainView = SpeechFieldSettingView()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(mainView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.frame = UIScreen.main.bounds
    }
}
