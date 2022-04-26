//
//  NibBased.swift
//  Snack
//
//  Created by Khaled Khaldi on 23/02/2022.
//

import UIKit

protocol NibBased {

    // MARK: Static parameters

    static var nibName: String { get }

}


extension NibBased {

    // MARK: Static parameters

    static var nibName: String {
        String(describing: self)
    }

}

extension NibBased where Self: UIView {

    // MARK: Static functions

    static func instantiate(owner: Any? = nil) -> Self {
        let nib = UINib(nibName: nibName, bundle: nil)
        let items = nib.instantiate(withOwner: owner, options: nil)
        return (items.first! as? Self)!
    }

}


extension NibBased where Self: UIViewController {

    // MARK: Static functions

    static func instantiate() -> Self {
        Self.init(nibName: self.nibName, bundle: Bundle(for: self))
    }

}

extension NibBased where Self: UICollectionReusableView {

    // MARK: Static properties

    static var nib: UINib {
        UINib(nibName: nibName, bundle: nil)
    }

}

extension NibBased where Self: UITableViewHeaderFooterView {

    // MARK: Static properties

    static var nib: UINib {
        UINib(nibName: nibName, bundle: nil)
    }

}

extension NibBased where Self: UITableViewCell {

    // MARK: Static properties

    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }

}

extension UICollectionView {

    // MARK: UICollectionReusableView

    func register<T: UICollectionReusableView & NibBased>(_ headerType: T.Type, nibName: String? = nil, forSupplementaryViewOfKind kind: String) {
        let nib = nibName.flatMap { UINib(nibName: $0, bundle: nil) } ?? T.nib
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView & NibBased>(ofKind kind: String, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }


    // MARK: UICollectionViewCell

    func register<T: UICollectionViewCell & NibBased>(_ cellType: T.Type, nibName: String? = nil) {
        let nib = nibName.flatMap { UINib(nibName: $0, bundle: nil) } ?? T.nib
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell & NibBased>(for indexPath: IndexPath) -> T {
        (dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T)!
    }

}

extension UITableView {
    
    // MARK: UITableViewHeaderFooterView

    func register<T: UITableViewHeaderFooterView & NibBased>(_ headerType: T.Type, nibName: String? = nil) {
        let nib = nibName.flatMap { UINib(nibName: $0, bundle: nil) } ?? T.nib
        register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView & NibBased>() -> T {
        dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }


    // MARK: UITableViewCell

    func register<T: UITableViewCell & NibBased>(_ cellType: T.Type, nibName: String? = nil) {
        let nib = nibName.flatMap { UINib(nibName: $0, bundle: nil) } ?? T.nib
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell & NibBased>(for indexPath: IndexPath) -> T {
        (dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T)!
    }

}

