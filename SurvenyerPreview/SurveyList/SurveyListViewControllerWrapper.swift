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
        let model1 = SurveyListViewModel.SurveyViewModel(name: "test1",
                                                         dateString: "2020/02/24")
        let model2 = SurveyListViewModel.SurveyViewModel(name: "test2",
                                                         dateString: "2020/02/24")
        let model3 = SurveyListViewModel.SurveyViewModel(name: "test3",
                                                         dateString: "2020/02/24")
        return Group {
            SurveyListViewControllerWrapper(inputs: [.setSurveyList(surveyList: [model1, model2, model3])])
        }
    }
    
}
