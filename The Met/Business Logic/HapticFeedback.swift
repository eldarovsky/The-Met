//
//  HapticFeedback.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 28.02.2024.
//

import UIKit

final class HapticFeedback {
    static let shared = HapticFeedback()

    func enableFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }

    private init() {}
}
