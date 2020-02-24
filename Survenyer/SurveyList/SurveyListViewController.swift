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
    private var didSelectHandler: VoidClosure {
        return {
            let vc = SurveyDetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    override func loadView() {
        super.loadView()
        
        let viewModel = SurveyListViewModel(list: [], didSelectedHandler: didSelectHandler)
        mainView = SurveyListView(viewModel: viewModel)
        
        // TODO: delete
        stub()
        
        if let mainView = mainView {
            view.addSubview(mainView)
        }
    }
    
    func stub() {
        let model1 = SurveyListViewModel.SurveyViewModel(name: "test1",
                                                         dateString: "2020/02/24")
        let model2 = SurveyListViewModel.SurveyViewModel(name: "test2",
                                                         dateString: "2020/02/24")
        let model3 = SurveyListViewModel.SurveyViewModel(name: "test3",
                                                         dateString: "2020/02/24")
        
        let viewModel = SurveyListViewModel(list: [model1, model2, model3], didSelectedHandler: didSelectHandler)
        mainView?.viewModel = viewModel
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mainView?.frame = view.frame
    }
}

extension SurveyListViewController: InputAppliable {
    enum Input {
        case setSurveyList(surveyList: [SurveyListViewModel.SurveyViewModel])
    }
    
    func apply(input: SurveyListViewController.Input) {
        switch input {
        case .setSurveyList(let list):
            let viewModel = SurveyListViewModel(list: list,
                                                didSelectedHandler: {})
            mainView?.viewModel = viewModel
        }
    }
}
