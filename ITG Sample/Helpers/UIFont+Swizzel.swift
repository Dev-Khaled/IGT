//
//  UIFont+Swizzel.swift
//  SadaAlmustaqbal
//
//  Created by Khaled Khaldi on 11/1/19.
//  Copyright © 2019 SaDyKhAlEd. All rights reserved.
//

import UIKit

extension UIFont {
    
    enum FontWight: String {
        case extraLight = "Cairo-ExtraLight"
        case light      = "Cairo-Light"
        case regular    = "Cairo-Regular"
        case semiBold   = "Cairo-SemiBold"
        case bold       = "Cairo-Bold"
        case black      = "Cairo-Black"
    }
    
    static func main(_ wight: UIFont.FontWight, size: CGFloat) -> UIFont {
        return UIFont(name: wight.rawValue, size: size)!
    }
    
}

struct AppFontName {
    static let extraLight = "Cairo-ExtraLight"
    static let light      = "Cairo-Light"
    static let regular    = "Cairo-Regular"
    static let semiBold   = "Cairo-SemiBold"
    static let bold       = "Cairo-Bold"
    static let black      = "Cairo-Black"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func myPreferredFont(forTextStyle style: String) -> UIFont {
        let defaultFont = myPreferredFont(forTextStyle: style)  // will not cause stack overflow - this is now the old, default UIFont.preferredFontForTextStyle
        let newDescriptor = defaultFont.fontDescriptor.withFamily("Cairo")
        return UIFont(descriptor: newDescriptor, size: defaultFont.pointSize)
    }

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    /*
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    */

    /*
     print("fontAttribute: \(fontAttribute)")
     fontAttribute: CTFontUltraLightUsage
     fontAttribute: CTFontThinUsage
     fontAttribute: CTFontLightUsage
     fontAttribute: CTFontRegularUsage
     fontAttribute: CTFontMediumUsage
     fontAttribute: CTFontDemiUsage
     fontAttribute: CTFontBoldUsage
     fontAttribute: CTFontHeavyUsage
     fontAttribute: CTFontBlackUsage
     */
    

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        
        let fontName: String
        
        
        switch fontAttribute {
        case "CTFontUltraLightUsage", "CTFontThinUsage":
            fontName = AppFontName.extraLight
            
        case "CTFontLightUsage":
            fontName = AppFontName.light
            
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
            
        case "CTFontMediumUsage", "CTFontDemiUsage":
            fontName = AppFontName.semiBold
            
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
            
        case "CTFontHeavyUsage", "CTFontBlackUsage":
            fontName = AppFontName.black
            
        default:
            fontName = AppFontName.regular
        }
        
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemPreferredFontMethod = class_getClassMethod(self, #selector(preferredFont(forTextStyle:))),
            let mySystemPreferredFontMethod = class_getClassMethod(self, #selector(myPreferredFont(forTextStyle:))) {
            method_exchangeImplementations(systemPreferredFontMethod, mySystemPreferredFontMethod)
        }

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        /*
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        */
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
