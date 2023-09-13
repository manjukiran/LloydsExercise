//
//  Theme.swift
//
//  Copyright © 2023 Manju Kiran. All rights reserved.
//

import UIKit

class LETheme {

    private enum Constants {
        /// Theme Color
        static let themeColorHex = "087038"
        /// Color to indicate that UI element is tappable
        static let actionItemColor = "CC66CC" // Inverse of themeColorHex ^^
    }

    static let shared = LETheme()
    private init() {}

    lazy private(set) var themeColor: UIColor = {
        UIColor(hexString: Constants.themeColorHex)
    }()

    lazy private(set) var actionItemColor: UIColor = {
        UIColor(hexString: Constants.actionItemColor)
    }()

    /// Apply app themes to common elements based on colors so that this does not need to be setup separately for all UI Elements
    static func applyTheme() {
        LETheme.shared.applyNavigationBarTheme()
    }

    /// Retrieve scaled font for accessibility reasons
    /// - Parameter style: text style for the TEXT to be displayed
    func font(for style: UIFont.TextStyle) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        return fontMetrics.scaledFont(for: UIFont.font(for: style))
    }

    func fontColor(for style: UIFont.TextStyle) -> UIColor {
        UIFont.fontColor(for: style)
    }

    /// Applies Theme colors to all nav bars
    private func applyNavigationBarTheme() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.tintColor = UIColor.black
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = LETheme.shared.themeColor
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.prefersLargeTitles = false

        navigationBarAppearance.standardAppearance = standardAppearance
        navigationBarAppearance.scrollEdgeAppearance = standardAppearance

    }

}
