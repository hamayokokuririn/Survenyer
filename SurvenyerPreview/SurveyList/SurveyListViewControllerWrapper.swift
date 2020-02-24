//
//  SurveyListViewControllerWrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import SwiftUI

struct SurveyListViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = SurveyListViewController
    
    let inputs: [UIViewControllerType.Input]
    
    init(inputs: [UIViewControllerType.Input]) {
        self.inputs = inputs
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SurveyListViewControllerWrapper>) -> SurveyListViewController {
        SurveyListViewController(nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: SurveyListViewController, context: UIViewControllerRepresentableContext<SurveyListViewControllerWrapper>) {
        inputs.forEach {
            uiViewController.apply(input: $0)
        }
    }
}

struct SurveyListViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let survey = SurveyListViewModel(name: "test", dateString: "2020/02/24")
        let survey2 = SurveyListViewModel(name: "test2", dateString: "2020/02/24")
        let survey3 = SurveyListViewModel(name: "test3", dateString: "2020/02/24")
        return Group {
            SurveyListViewControllerWrapper(inputs: [.setSurveyList(surveyList: [survey, survey2, survey3])])
        }
    }
    
}
