//
//  HapticFeedbackManager.swift
//  The Met
//
//  Created by Eldar Abdullin on 28.02.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import UIKit

// MARK: - HapticFeedbackManager
final class HapticFeedbackManager {
    
    // MARK: - Static Property (singleton pattern)
    static let shared = HapticFeedbackManager()
    
    // MARK: - Private Initializer (singleton pattern)
    private init() {}
    
    // MARK: - Public Methods
    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}
