//
//  SurveyDetailViewController.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import Foundation
import UIKit

final class SurveyDetailViewController: UIViewController {
    var mainView: SurveyDetailView?
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        mainView = SurveyDetailView()
        if let mainView = mainView {
            view.addSubview(mainView)
        }
        
        addViewModel()
    }
    
    private func addViewModel() {
        let id = SurveyItemIdentifier(id: ObjectIdentifier(Int.self))
        let surveyItem = SurveyItem(id: id, name: "温度")
        let surveyItem2 = SurveyItem(id: id, name: "湿度")
        let sample = Sample(id: SampleIdentifier(id: ObjectIdentifier(Int.self)),
                            name: "No.1",
                            measuredResult: [id.id : "loadViewAdding"])
        let viewModel = SurveyDetailViewModel(name: "調査その1",
                                              dateString: "2020/02/24",
                                              surveyItemList: [surveyItem, surveyItem2],
                                              sampleList: [sample])
        
        mainView?.viewModel = viewModel
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        mainView?.frame = view.frame
    }
}

extension SurveyDetailViewController: InputAppliable {
    enum Input {
        case setSurveyItems(items: [String])
        case setSamples(samples: [Sample])
    }
    
    func apply(input: SurveyDetailViewController.Input) {
        switch input {
        case .setSurveyItems(let items):
            guard let samples = mainView?.viewModel?.sampleList else {return}
            let surveyItemList = items.map {
                return SurveyItem(id: SurveyItemIdentifier(id: ObjectIdentifier(Int.self)),
                                                           name: $0)
            }
            let viewModel = SurveyDetailViewModel(name: "test",
                                                  dateString: "2020/02/24",
                                                  surveyItemList: surveyItemList,
                                                  sampleList: samples)
            mainView?.viewModel = viewModel
            
        case .setSamples(let samples):
            guard let items = mainView?.viewModel?.surveyItemList else {return}
            let viewModel = SurveyDetailViewModel(name: "test",
                                                  dateString: "2020/02/24",
                                                  surveyItemList: items,
                                                  sampleList: samples)
            mainView?.viewModel = viewModel
        }
    }
}
