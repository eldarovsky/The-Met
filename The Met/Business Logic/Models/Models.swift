//
//  Models.swift
//  The Met
//
//  Created by Эльдар Абдуллин on 01.01.2024.
//

import Foundation

struct Objects: Decodable {
    /// Массив id всех произведений
    let objectIDs: [Int]
}

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

struct Departments: Decodable {
    /// номера департаментов
    let departments: [Department]
}

struct Department: Decodable {
    /// id департамента
    let departmentId: Int
    /// название департамента
    let displayName: String
}
