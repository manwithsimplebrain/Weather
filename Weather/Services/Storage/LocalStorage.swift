//
//  LocalStorage.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation

protocol LocalStorage {
    func save(fileName: String, data: Data) async
    func load(fileName: String) async -> Data?
}
