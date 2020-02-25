//
//  SampleInputViewControllerWrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/23.
//

import SwiftUI

struct SampleInputViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = SampleInputViewController
    
    let inputs: [UIViewControllerType.Input]

    init(inputs: [UIViewControllerType.Input]) {
        self.inputs = inputs
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SampleInputViewControllerWrapper>) -> SampleInputViewController {
        SampleInputViewController(sampleName: "test")
    }
    
    func updateUIViewController(_ uiViewController: SampleInputViewController, context: UIViewControllerRepresentableContext<SampleInputViewControllerWrapper>) {
        inputs.forEach {
            uiViewController.apply(input: $0)
        }
    }
}

struct SpeechInputViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            SampleInputViewControllerWrapper(inputs: [.setSampleName(name: "No.1")])
        }
    }
    
}
