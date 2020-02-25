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
            let id = SurveyItemIdentifier(id: ObjectIdentifier(Int.self))
            let surveyItem = SurveyItem(id: id, name: "温度")
            let surveyItem2 = SurveyItem(id: id, name: "湿度")
            let sample = Sample(id: SampleIdentifier(id: ObjectIdentifier(Int.self)),
                                name: "No.1",
                                measuredResult: [id.id : "loadViewAdding"])
            let viewModel = SurveyDetailViewModel(didSelectHandler: nil,
                                                  name: "調査その1",
                                                  dateString: "2020/02/24",
                                                  surveyItemList: [surveyItem, surveyItem2],
                                                  sampleList: [sample, sample, sample, sample, sample, sample, sample, sample, sample, sample])
            let vc = SurveyDetailViewController(viewModel: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    override func loadView() {
        super.loadView()
        
        let viewModel = SurveyListViewModel(list: [], didSelectedHandler: didSelectHandler)
        mainView = SurveyListView(viewModel: viewModel)
        
        setupNavigationItem()
        // TODO: delete
        stub()
        
        if let mainView = mainView {
            view.addSubview(mainView)
        }
        
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "調査票"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton =
            UIBarButtonItem(title: "+"
                , style: .plain,
                  target: self,
                  action: #selector(didPushAddButton))
        
        let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                  target: nil, action: nil)
        toolbarItems = [flexibleSpaceButton, addButton]
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    @objc private func didPushAddButton() {
        print("add pushed")
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
