//
//  Wrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/23.
//

import SwiftUI

struct SampleInputTextFieldWrapper: UIViewRepresentable {
    typealias UIViewType = SampleInputTextField
    
    let inputs: [SampleInputTextField.Input]
    
    init(inputs: [SampleInputTextField.Input]) {
        self.inputs = inputs
    }
    
    func makeUIView(context: UIViewRepresentableContext<SampleInputTextFieldWrapper>) -> SampleInputTextField {
        let viewModel = SurveyInputTextFiledViewModel(surveyItem: SurveyItem(id: SurveyItemIdentifier(id: 0),
                                                                             name: "test"))
        return SampleInputTextField(viewModel: viewModel)
    }
    
    func updateUIView(_ uiView: SampleInputTextField, context: UIViewRepresentableContext<SampleInputTextFieldWrapper>) {
        inputs.forEach {
            uiView.apply(input: $0)
        }
    }
}

struct SurveyInputTextFieldPreview: PreviewProvider {
    static var previews: some View {
        Group {
            SampleInputTextFieldWrapper(inputs: [.setBorderColor(color: .blue)])
        }.previewLayout(.fixed(width: 375, height: 80))
    }
    
    static var platform: PreviewPlatform? = .iOS
}
