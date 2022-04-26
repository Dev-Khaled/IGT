//
//  BaseWireframe.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import UIKit
import Interstellar

class BaseWireframe<T: BaseViewModel>: UIViewController {
    
    var viewModel: T! = T()
    
    func configure(with viewModel: T) {
        loadingViewObserve(self.viewModel.isLoaderHidden)
        errorObserve(self.viewModel.alertMessage)
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    func loadingViewObserve(_ loadingObservable: Dynamic<BaseLoading>){
        loadingObservable.bind { [weak self] loading in
            switch loading {
            case .show:
                self?.showIndeterminateHUD()
                
            case .hide:
                self?.hideHUD()
                
            case .withText(let text):
                self?.showHUD(style: .warning, details: text)
            }
        }
    }
    
    func errorObserve(_ errorsObservable: Observable<String>) {
        errorsObservable.subscribe { [weak self] error in
            self?.viewModel.isLoaderHidden.value = .hide
            self?.showHUD(
                style: .warning,
                details: error,
                hideAfter: 2.0
            )
        }
        
    }
    
}


