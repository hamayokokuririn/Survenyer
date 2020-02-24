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
    let viewModel: SurveyDetailViewModel
    
    init(viewModel: SurveyDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        setupNavigationItem()
        
        mainView = SurveyDetailView()
        mainView?.viewModel = viewModel
        if let mainView = mainView {
            view.addSubview(mainView)
        }
    }
    
    private func setupNavigationItem() {
        navigationItem.title = viewModel.name
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
        print("didPushAdd")
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
