//
//  CustomButton.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

final class CustomButton: UIButton {

    init(
        title: String,
        titleNormalColor: UIColor = .customGrey,
        titleHighlightColor: UIColor = .customGreyLight,
        tintColor: UIColor = .customGrey,
        font: UIFont = .systemFont(ofSize: 21),
        backgroundColor: UIColor = .clear,
        width: CGFloat,
        height: CGFloat
    ) {
        super.init(frame: .zero)

        setupButton(
            title: title,
            titleNormalColor: titleNormalColor,
            titleHighlightColor: titleHighlightColor,
            tintColor: tintColor,
            font: font,
            backgroundColor: backgroundColor,
            width: width,
            height: height
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomButton {
    func setupButton(
        title: String,
        titleNormalColor: UIColor,
        titleHighlightColor: UIColor,
        tintColor: UIColor,
        font: UIFont,
        backgroundColor: UIColor,
        width: CGFloat,
        height: CGFloat
    ) {
        setTitle(title, for: .normal)
        setTitleColor(titleNormalColor, for: .normal)
        setTitleColor(titleHighlightColor, for: .highlighted)
        self.tintColor = tintColor
        titleLabel?.font = font
        self.backgroundColor = backgroundColor
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
