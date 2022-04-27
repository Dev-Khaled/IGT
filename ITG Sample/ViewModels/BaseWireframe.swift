//
//  BaseWireframe.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import UIKit
import Interstellar


/// Base Wireframe for observable view controllers
class BaseWireframe<T: BaseViewModel>: UIViewController {
    
    var viewModel: T! = T()
    
    func configure(with viewModel: T) {
        loadingViewObserve(self.viewModel.isLoaderHidden)
        errorObserve(self.viewModel.alertMessage)
    }
    
    deinit {
        print("deinit \(self)")
    }
    
    
    /// Change loading status observer
    /// - Parameter loadingObservable: Dynamic Basic Loading observer
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
    
    
    /// Change error status observer
    /// - Parameter errorsObservable: Observable error string
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


