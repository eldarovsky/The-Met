//
//  ImageSaver.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import UIKit

// MARK: - ImageSaver
final class ImageSaver: NSObject {

    // MARK: - Public Methods
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    // MARK: - Private Methods
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    }
}
