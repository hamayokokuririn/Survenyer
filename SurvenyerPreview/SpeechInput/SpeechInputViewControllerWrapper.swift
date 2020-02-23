//
//  SpeechInputViewControllerWrapper.swift
//  SurvenyerPreview
//
//  Created by 齋藤健悟 on 2020/02/23.
//

import SwiftUI

struct SpeechInputViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = SpeechInputViewController
    
    let inputs: [UIViewControllerType.Input]

    init(inputs: [UIViewControllerType.Input]) {
        self.inputs = inputs
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SpeechInputViewControllerWrapper>) -> SpeechInputViewController {
        SpeechInputViewController(nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: SpeechInputViewController, context: UIViewControllerRepresentableContext<SpeechInputViewControllerWrapper>) {
        inputs.forEach {
            uiViewController.apply(input: $0)
        }
    }
}

struct SpeechInputViewControllerPreview: PreviewProvider {
    static var previews: some View {
        Group {
            SpeechInputViewControllerWrapper(inputs: [.setText(text: "test")])
        }
    }
    
}
