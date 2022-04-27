//
//  Appearance.swift
//  Snack
//
//  Created by Khaled Khaldi on 25/02/2022.
//

import UIKit


private typealias Attributes = [NSAttributedString.Key: Any]


/// Configure app appearance (Fonts, Colors)
class Appearance {
    
    /// Configure app appearance (Fonts, Colors)
    static func configure() {
        UIFont.overrideInitialize()
        
        UIView.appearance().overrideUserInterfaceStyle = .light
        
        UINavigationBar.appearance().standardAppearance = darkAppearance
        DarkTintNavigationBar.appearance().standardAppearance = darkAppearance
        LightTintNavigationBar.appearance().standardAppearance = lightAppearance
        // AccountNavigationBar.appearance().compactAppearance    = navAppearance
        // AccountNavigationBar.appearance().scrollEdgeAppearance = navAppearance // transNavBarAppearance

        
        setupAppearanceForAlertController()
        setupTabBarAppearance()
    }
    
    static let lightAppearance: UINavigationBarAppearance = appearance(
        titleColor: .white,
        buttonsColor: .accentColor,
        backButtonImage: nil
    )
    
    static let darkAppearance: UINavigationBarAppearance = appearance(
        titleColor: .textColor,
        buttonsColor: .accentColor,
        backButtonImage: nil
    )

    
    /// Get UINavigationBarAppearance for attributes
    /// - Parameters:
    ///   - barColor: Navigation Bar Color
    ///   - titleColor: Navigation Title Color
    ///   - buttonsColor: Navigation Button Colors
    ///   - backButtonImage: Back Button Image, default is NULL
    /// - Returns: UINavigationBarAppearance instance
    static func appearance(withBarColor barColor: UIColor? = nil,
                           titleColor: UIColor,
                           buttonsColor: UIColor,
                           backButtonImage: UIImage? = nil) -> UINavigationBarAppearance {
        // NavBar buttons
        let titleTextAttributes: Attributes = [
            .foregroundColor: titleColor,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        let largeTitleTextAttributes: Attributes = [
            .foregroundColor: titleColor,
            .font: UIFont.boldSystemFont(ofSize: 23)
        ]

        let backImage = backButtonImage?
            .imageFlippedForRightToLeftLayoutDirection()

        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithDefaultBackground()
        
        if let barColor = barColor {
            navAppearance.backgroundColor = barColor
        }
        navAppearance.titleTextAttributes = titleTextAttributes
        navAppearance.largeTitleTextAttributes = largeTitleTextAttributes
        
        navAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        /*
         let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
         buttonAppearance.normal.titleTextAttributes = barBtnItemTitleEnabled
         buttonAppearance.disabled.titleTextAttributes = barBtnItemTitleDisabled
         
         let doneButtonAppearance = UIBarButtonItemAppearance(style: .done)
         doneButtonAppearance.normal.titleTextAttributes = barBtnItemTitleEnabled
         doneButtonAppearance.disabled.titleTextAttributes = barBtnItemTitleDisabled
         
         navAppearance.buttonAppearance = buttonAppearance
         navAppearance.doneButtonAppearance = doneButtonAppearance
         */
        
        // navAppearance.shadowImage = nil
        // navAppearance.shadowColor = nil
        
        // New Bar button appearance code
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: buttonsColor
        ]
        //buttonAppearance.disabled.backgroundImage = nil
        navAppearance.buttonAppearance = buttonAppearance
        //navAppearance.doneButtonAppearance = buttonAppearance
        //navAppearance.backButtonAppearance = buttonAppearance

        return navAppearance
        
        // // Bar Button Image Color
        // let barButton = UIBarButtonItem.appearance(
        //     whenContainedInInstancesOf: [navigationBarType.self]
        // )
        // barButton.tintColor = buttonsColor

    }
    
    
    /// Setup Appearance for UIAlertController
    private static func setupAppearanceForAlertController() {
        let view = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self])
        view.tintColor = .accentColor
    }
    
    
    /// Setup UITabBar Appearance
    private static func setupTabBarAppearance() {
        let tabBarItem = UITabBarItem.appearance()
        let attributes: Attributes = [
            .font: UIFont.systemFont(ofSize: 11),
        ]
        tabBarItem.setTitleTextAttributes(attributes, for: .normal)
    }

}


/// NavigationController with light, dark UINavigationBar base on navigationBar class (LightTintNavigationBar, DarkTintNavigationBar)
class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if navigationBar is LightTintNavigationBar {
            return .lightContent
        } else {
            return .darkContent
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonDisplayMode = .minimal
    }
    
}


/// NavigationController with light, dark UINavigationBar automatic switching based on preferredStatusBarStyle
class AutomaticNavigationController: UINavigationController, UINavigationControllerDelegate {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .default
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
                
        if viewController.preferredStatusBarStyle == .lightContent {
            //navigationItem.standardAppearance = Appearance.lightAppearance
            navigationBar.standardAppearance = Appearance.lightAppearance
        } else {
            //navigationItem.standardAppearance = Appearance.darkAppearance
            navigationBar.standardAppearance = Appearance.darkAppearance
        }

        viewController.navigationItem.backButtonDisplayMode = .minimal

    }
    
}

class AutomaticTintNavigationBar: UINavigationBar {
    
}
class LightTintNavigationBar: UINavigationBar {
    
}
class DarkTintNavigationBar: UINavigationBar {
    
}
