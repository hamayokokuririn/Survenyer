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
    var viewModel: SurveyDetailViewModel?
    
    private var didSelectHandler: VoidClosure {
        return {
            guard let name = self.viewModel?.name else {
                return
            }
            let vc = SpeechInputViewController(sampleName: name)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    init(viewModel: SurveyDetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        let newViewModel = SurveyDetailViewModel(didSelectHandler: self.didSelectHandler,
                                                 name: viewModel.name,
                                                 dateString: viewModel.dateString,
                                                 surveyItemList: viewModel.surveyItemList,
                                                 sampleList: viewModel.sampleList)
        self.viewModel = newViewModel
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
        guard let titleName = viewModel?.name else {
            return
        }
        navigationItem.title = titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                         target: self, action: #selector(didPushEditButton))
        navigationItem.rightBarButtonItem = editButton
        
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
        let vc = SpeechInputViewController(sampleName: "新規サンプル")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didPushEditButton() {
        let vc = SpeechFieldSettingViewController()
        navigationController?.pushViewController(vc, animated: true)
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
