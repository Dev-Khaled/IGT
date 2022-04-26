//
//  Extensions.swift
//  QuranSingle
//
//  Created by Khaled Khaldi on 18/12/2021.
//

import UIKit

class NoDataLabel: UILabel {
    init(text: String = "NoDataAvailableHere".localized) {
        super.init(frame: .zero)
        commonInit(text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func commonInit(text: String = "NoDataAvailableHere".localized) {
        textAlignment = .center
        textColor = UIColor.textLightColor
        font = UIFont.systemFont(ofSize: 12)
        self.text = text
    }
}

extension UIImage {
    static let placeholder = UIImage(named: "Placeholder")
    static let userPlaceholder = UIImage(named: "ProfilePlaceholder")
    static let organizationPlaceholder = UIImage(named: "OrganizationPlaceholder")
}

func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    
    #if DEBUG
    
    var idx = items.startIndex
    let endIdx = items.endIndex
    
    repeat {
        Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
        idx += 1
    }
        while idx < endIdx
    
    #endif
}

extension MutableCollection {
    subscript (safe index: Index) -> Iterator.Element? {
        get {
            guard startIndex <= index, index < endIndex else { return nil }
            return self[index]
        }
        set(newValue) {
            guard startIndex <= index, index < endIndex else { print("Index out of range."); return }
            guard let newValue = newValue else { print("Cannot remove out of bounds items"); return }
            self[index] = newValue
        }
    }
}

extension Data {
    func prettyPrint() {
        if let json = try? JSONSerialization.jsonObject(with: self, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
    }

}

extension NumberFormatter {
    static let floatFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Numeric {
    var formattedString: String {
        NumberFormatter.floatFormatter.string(for: self) ?? "\(self)"
    }
    var planeString: String {
        "\(self)"
    }
}

// extension Int {
//     var formattedString: String {
//         NumberFormatter.floatFormatter.string(for: self) ?? "\(self)"
//     }
// }
//
// extension Float {
//     var formattedString: String {
//         NumberFormatter.floatFormatter.string(for: self) ?? "\(self)"
//     }
// }
//
// extension CGFloat {
//     var formattedString: String {
//         NumberFormatter.floatFormatter.string(for: self) ?? "\(self)"
//     }
// }

extension String {
    var withCurrency: String {
        self + " " + "SAR".localized
    }
}

// MARK: - String

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
        // return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized( _ args: CVarArg...) -> String {
        // return String.localizedStringWithFormat(self.localized, args)
        return String(format: self.localized, locale: Locale.current, arguments: args)
    }
    
}

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

extension String {
    var withPlaceholder: String {
        self.isEmpty ? "-" : self
    }
}

extension Optional where Wrapped == String {
    var withPlaceholder: String {
        self.isNilOrEmpty ? "-" : self!
    }

}

extension Optional where Wrapped == NSAttributedString {
    var withPlaceholder: NSAttributedString {
        if let string = self, string.length > 0 {
            return string
        }
        return NSAttributedString(string: "-")
    }
}


extension NSMutableAttributedString {
    convenience init(
        text1: String, attributes1: [NSAttributedString.Key: Any]?,
        text2: String, attributes2: [NSAttributedString.Key: Any]?
    ) {
        self.init()
        let attributed1 = NSAttributedString(
            string: text1,
            attributes: attributes1
        )
        append(attributed1)

        let attributed2 = NSAttributedString(
            string: text2,
            attributes: attributes2
        )
        append(attributed2)

    }
    
}

extension String {
    var url: URL? {
        var url: URL? = nil
        url = URL(string: self)
        if url == nil {
            let encodeString =  self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let encodeString = encodeString {
                url = URL(string: encodeString)
            }
        }
        
        if let _url = url, _url.scheme == nil {
            var components = URLComponents(url: _url, resolvingAgainstBaseURL: false)
            components?.scheme = "https"
            url = components?.url
        }
        
        return url
    }
    
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}

extension String {
    func changeToEnglish() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en")
        if let engNumber = numberFormatter.number(from: self) {
            return "\(engNumber)"
        }
        return nil
    }
}


// MARK: - UIView

extension UIView {
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        return contentView
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


extension UINavigationController {
    /*
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    */

    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
}

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.children[safe: selectedIndex]
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.children[safe: selectedIndex]
    }
}

extension UISplitViewController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.children.first
    }

    open override var childForStatusBarHidden: UIViewController? {
        return self.children.first
    }
}


extension CACornerMask {
    
    fileprivate static var isLTR: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
    }
    
    static var leadingTop: CACornerMask {
        return isLTR ? .layerMinXMinYCorner : .layerMaxXMinYCorner
    }
    static var trailingTop: CACornerMask {
        return isLTR ? .layerMaxXMinYCorner : .layerMinXMinYCorner
    }
    
    static var leadingBottom: CACornerMask {
        return isLTR ? .layerMinXMaxYCorner : .layerMaxXMaxYCorner
    }
    static var trailingBottom: CACornerMask {
        return isLTR ? .layerMaxXMaxYCorner : .layerMinXMaxYCorner
    }
    
}

extension UIView {
    
    @IBInspectable var _cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            // layer.masksToBounds = newValue > 0
        }
    }
    
    // MARK: - Border
    
    @IBInspectable var _borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
        
    }
    
    @IBInspectable var _borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    // MARK: - Shadow
    
    @IBInspectable var _shadowColor: UIColor? {
        get {
            guard let cgColor = layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var _shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    @IBInspectable var _shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var _shadowBlur: CGFloat {
        get {
            return layer.shadowRadius * 2.0
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable var _shadowSpread: CGFloat {
        get {
            return 0
        }
        set {
            let spread = newValue
            guard spread != 0 else {
                layer.shadowPath = nil
                return
            }
            let dx = -spread
            let rect = layer.bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    @IBInspectable var _shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
}




// MARK: - UIViewController+Presentation

extension UIViewController {
    
    @IBAction func popOrDismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        if isPresentedModally() {
            dismiss(animated: animated, completion: completion)
            
        } else {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController?.popViewController(animated: animated)
            CATransaction.commit()
        }
        
    }
    
    func isPresentedModally() -> Bool {
        if let navigationController = self.navigationController,
            navigationController.viewControllers.first != self {
            return false
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
        
    }
}


extension UIViewController {
    func hideViews() {
        view.subviews.forEach { view in
            guard view.tag == 0 else { return }
            view.isHidden = true
        }
    }
    
    func showViews() {
        view.subviews.forEach { view in
            guard view.tag == 0 else { return }
            view.isHidden = false
        }
    }
}


extension Bundle {
    func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data

        guard let file = self.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

}

import AudioToolbox

extension UIDevice {
    func vibrate() {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
}
