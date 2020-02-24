//
//  Wrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/23.
//

import SwiftUI

struct SurveyInputTextFieldWrapper: UIViewRepresentable {
    typealias UIViewType = SurveyInputTextField
    
    let inputs: [SurveyInputTextField.Input]
    
    init(inputs: [SurveyInputTextField.Input]) {
        self.inputs = inputs
    }
    
    func makeUIView(context: UIViewRepresentableContext<SurveyInputTextFieldWrapper>) -> SurveyInputTextField {
        let viewModel = SurveyInputTextFiledViewModel()
        return SurveyInputTextField(labelText: "Kengo",
                             viewModel: viewModel)
    }
    
    func updateUIView(_ uiView: SurveyInputTextField, context: UIViewRepresentableContext<SurveyInputTextFieldWrapper>) {
        inputs.forEach {
            uiView.apply(input: $0)
        }
    }
}

struct SurveyInputTextFieldPreview: PreviewProvider {
    static var previews: some View {
        Group {
            SurveyInputTextFieldWrapper(inputs: [.setBorderColor(color: .blue)])
        }.previewLayout(.fixed(width: 375, height: 80))
    }
    
    static var platform: PreviewPlatform? = .iOS
}
