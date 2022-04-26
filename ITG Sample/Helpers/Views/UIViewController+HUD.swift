//
//  UIViewController+HUD.swift
//  ISChat
//
//  Created by Khaled Khaldi on 9/19/18.
//  Copyright © 2018 iPhoneAlsham. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    @discardableResult
    func showHUD(style: UIView.HUDStyle = .none, title:String? = nil, details: String? = nil, hideAfter:TimeInterval? = nil, completion: (() -> Void)? = nil) -> MBProgressHUD {
        return view.showHUD(style: style, title: title, details: details, hideAfter: hideAfter, completion: completion)
    }
    
    @discardableResult
    public func showIndeterminateHUD(title:String? = nil, details: String? = nil) -> MBProgressHUD {
        return view.showIndeterminateHUD(title: title, details: details)
    }
    
    public func hideHUD(animated:Bool = true) {
        view.hideHUD(animated: animated)
    }
    
}

extension UIView {
    
    public enum HUDStyle {
        case success
        case error
        case warning
        case none
    }
    

    @discardableResult
    func showHUD(style: UIView.HUDStyle = .none, title:String? = nil, details: String? = nil, hideAfter:TimeInterval? = nil, completion: (() -> Void)? = nil) -> MBProgressHUD {
        var hud: MBProgressHUD! = MBProgressHUD.forView(self)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.removeFromSuperViewOnHide = true
        }
        
        switch style {
        case .success:
            hud.mode = .customView
            hud.customView = UIImageView(image: UIImage(named: "HUD-check"))
        case .warning:
            hud.mode = .customView
            hud.customView = UIImageView(image: UIImage(named: "HUD-warning"))
        case .error:
            hud.mode = .customView
            hud.customView = UIImageView(image: UIImage(named: "HUD-remove"))
        default:
            hud.mode = .text
        }
        hud.label.text = title
        hud.detailsLabel.text = details
        if let hideAfter = hideAfter {
            hud.hide(animated:true, afterDelay:hideAfter)
        }
        
        if let completion = completion {
            DispatchQueue.main.asyncAfter(deadline: .now() + (hideAfter ?? 0.0)) {
                completion()
            }
        }
        
        return hud
    }
    
    @discardableResult
    func showIndeterminateHUD(title: String? = nil, details: String? = nil) -> MBProgressHUD {
        var hud: MBProgressHUD! = MBProgressHUD.forView(self)
        if hud == nil {
            hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.removeFromSuperViewOnHide = true
        }
        
        hud.mode = .indeterminate;
        hud.label.text = title
        hud.detailsLabel.text = details
        
        return hud
    }
    
    func hideHUD(animated:Bool = true) {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
}


