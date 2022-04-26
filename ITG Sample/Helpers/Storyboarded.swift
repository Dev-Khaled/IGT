//
//  Storyboarded.swift
//  Snack
//
//  Created by Khaled Khaldi on 23/02/2022.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"
}

protocol Storyboarded {
    static var storyboardIdentifier: String { get }
    static var storyboardName: StoryboardName { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static var storyboardName: StoryboardName { .main }

    static func instantiate() -> Self {
        UIStoryboard(storyboardName).instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}

extension UIStoryboard {
    convenience init(_ name: StoryboardName) {
        self.init(name: name.rawValue, bundle: .main)
    }
}
