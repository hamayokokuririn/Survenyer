//
//  SurveyListViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

final class SurveyListViewController: UIViewController {
    
    private var mainView: SurveyListView?
    
    override func loadView() {
        super.loadView()
        
        mainView = SurveyListView(frame: .zero)
        
        stub()
        
        if let mainView = mainView {
            view.addSubview(mainView)
        }
    }
    
    func stub() {
        let survey = Survey(id: SurveyIdentifier(id: ObjectIdentifier(Int.self)),
                            name: "河川調査",
                            date: Date(),
                            surveyItems: [],
                            samples: [])
        let viewModel = SurveyListViewModel(survey: survey)
        mainView?.surveyList = [viewModel]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mainView?.frame = view.frame
    }
}

extension SurveyListViewController: InputAppliable {
    enum Input {
        case setSurveyList(surveyList: [SurveyListViewModel])
    }
    
    func apply(input: SurveyListViewController.Input) {
        switch input {
        case .setSurveyList(let list):
            mainView?.surveyList = list
        }
    }
}
