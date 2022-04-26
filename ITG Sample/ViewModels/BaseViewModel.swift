//
//  BaseViewModel.swift
//  ITG Sample
//
//  Created by Khaled Khaldi on 27/04/2022.
//

import Foundation
import Interstellar

protocol BaseViewModelProtocol {
    var alertMessage: Observable<String> { get set }
    var isLoaderHidden: Dynamic<BaseLoading> { get set }
}

class BaseViewModel: NSObject, BaseViewModelProtocol {
  
    var alertMessage: Observable<String> = Observable()

    var isLoaderHidden: Dynamic<BaseLoading> = Dynamic(BaseLoading.show)

    required override init(){
        
    }
    
}
