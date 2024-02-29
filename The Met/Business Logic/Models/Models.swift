//
//  Models.swift
//  The Met
//
//  Created by Eldar Abdullin on 01.01.2024.
//  Copyright © 2024 Eldar Abdullin. All rights reserved.
//

import Foundation

// MARK: - Objects model
struct Objects: Decodable {
    /// Массив id всех произведений
    let objectIDs: [Int]
}

// MARK: - Object model
struct Object: Decodable {
    /// id  произведения
    let objectID: Int
    /// показатель публичного доступа
    let isPublicDomain: Bool
    /// оригинальное изображение
    let primaryImage: String
    /// уменьшенное изображение
    let primaryImageSmall: String
    /// автор произведения
    let artistDisplayName: String
    /// заголовок произведения
    let title: String
    /// дата создания произведения
    let objectDate: String
    /// материал произведения
    let medium: String
    
    /// сводная информация по произведению
    var description: String {
        """
        AUTHOR: \(artistDisplayName != "" ? artistDisplayName : "Unknown")
        TITLE: \"\(title != "" ? title : "\"Unknown\"")\"
        
        DATE: \(objectDate != "" ? objectDate : "Unknown")
        MATERIALS: \(medium != "" ? medium : "Unknown")
        """
    }
}

// MARK: - Departments model
struct Departments: Decodable {
    /// номера департаментов
    let departments: [Department]
}

// MARK: - Department model
struct Department: Decodable {
    /// id департамента
    let departmentId: Int
    /// название департамента
    let displayName: String
}
