//
//  HapticFeedbackManager.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 28.02.2024.
//

import UIKit

final class HapticFeedbackManager {
    static let shared = HapticFeedbackManager()

    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }

    private init() {}
}
