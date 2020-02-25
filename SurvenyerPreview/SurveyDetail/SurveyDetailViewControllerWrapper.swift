//
//  SurveyDetailViewControllerWrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/24.
//

import SwiftUI

struct SurveyDetailViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = SurveyDetailViewController
    
    let inputs: [UIViewControllerType.Input]
    
    init(inputs: [UIViewControllerType.Input]) {
        self.inputs = inputs
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SurveyDetailViewControllerWrapper>) -> SurveyDetailViewController {
        let id = SurveyItemIdentifier(id: 0)
        let surveyItem = SurveyItem(id: id, name: "温度")
        let surveyItem2 = SurveyItem(id: id, name: "湿度")
        let sample = Sample(id: SampleIdentifier(id: 0),
                            name: "No.1",
                            results: [])
        let viewModel = SurveyDetailViewModel(name: "調査その1",
                                              dateString: "2020/02/24",
                                              surveyItemList: [surveyItem, surveyItem2, surveyItem, surveyItem2, surveyItem, surveyItem2, surveyItem, surveyItem2],
                                              sampleList: [sample])
        return SurveyDetailViewController(viewModel: viewModel)
    }
    
    func updateUIViewController(_ uiViewController: SurveyDetailViewController, context: UIViewControllerRepresentableContext<SurveyDetailViewControllerWrapper>) {
        inputs.forEach {
            uiViewController.apply(input: $0)
        }
    }
}

struct SurveyDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        let sample = Sample(id: SampleIdentifier(id: 0),
                            name: "Sample1", results: [])
        let sample2 = Sample(id: SampleIdentifier(id: 1),
                             name: "Sample2", results: [])
        return Group {
            SurveyDetailViewControllerWrapper(inputs: [.setSurveyItems(items: ["テスト", "サンプル", "温度"]),
                                                       .setSamples(samples: [sample, sample2, sample, sample2, sample, sample2, sample, sample2, sample, sample2, sample, sample2])])
        }
    }
    
}

