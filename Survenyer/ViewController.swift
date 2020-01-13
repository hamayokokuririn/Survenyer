//
//  ViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/01/11.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let speechContoller = SpeechController()
    
    let viewModelA = SurveyInputTextFiledViewModel()
    
    lazy var inputA: SurveyInputTextFiled = {
        return SurveyInputTextFiled(labelText: "A", viewModel: self.viewModelA)
    }()

    override func loadView() {
        super.loadView()
        
        viewModelA.handler = {
            self.speechContoller.chnageControl()
        }
        
        speechContoller.delegate = self
        
        view.addSubview(inputA)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        inputA.frame = CGRect(x: 20, y: 100, width: 300, height: 50)
    }
    
}

extension ViewController: SpeechControllerDelegate {
    func update(_ controller: SpeechController, didUpdate text: String) {
        print(text)
    }
}

