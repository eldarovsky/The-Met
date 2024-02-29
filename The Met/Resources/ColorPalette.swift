//
//  ColorPalette.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - Custom colors
extension UIColor {
    static let customRed = UIColor(red: 236/255, green: 1/255, blue: 42/255, alpha: 1)
    static let customGray = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    static let customGrayLight = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1).withAlphaComponent(0.5)
    static let customGreen = UIColor(red: 159/255, green: 166/255, blue: 151/255, alpha: 1)
    static let customGreenLight = UIColor(red: 180/255, green: 187/255, blue: 171/255, alpha: 1)
}

extension CGColor {
    static let shadow = UIColor(red: 49/255, green: 52/255, blue: 49/255, alpha: 1)
}
