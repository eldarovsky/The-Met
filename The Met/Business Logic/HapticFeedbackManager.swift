//
//  HapticFeedbackManager.swift
//  The Met
//
//  Created by Eldar Abdullin on 28.02.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

final class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()

    private init() {}

    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
