//
//  Localizable+Extensions.swift
//  Snack
//
//  Created by Khaled Khaldi on 23/02/2022.
//

import UIKit

extension UILabel {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}

extension UIButton {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
   }
}

extension UITabBarItem {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
   }
}

extension UINavigationItem {
    @IBInspectable var localizeKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
   }
}

extension UITextField {
    @IBInspectable var localizeText: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    @IBInspectable var localizePlaceholder: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}
