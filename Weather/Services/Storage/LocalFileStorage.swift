//
//  LocalFileStorage.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation

class LocalFileStorage: LocalStorage {
    private let fileManager = FileManager.default
    
    init() {}
    
    private var documentsDirectory: URL? {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func save(fileName: String, data: Data) async {
        await Task.detached {[weak self] in
            guard let documentsDirectory = self?.documentsDirectory else { return }
            let url = documentsDirectory.appendingPathComponent(fileName)
            do {
                try data.write(to: url, options: .atomic)
                print("Save image at: \(url)")
            } catch {
                print("Save image error: \(error.localizedDescription)")
            }
        }.value
    }

    func load(fileName: String) async -> Data? {
        return await Task {
            guard let documentsDirectory else { return nil }
            let url = documentsDirectory.appendingPathComponent(fileName)
            do {
                return try Data(contentsOf: url)
            } catch {
                print("Load image error: \(error.localizedDescription)")
                return nil
            }
        }.value
    }
}
