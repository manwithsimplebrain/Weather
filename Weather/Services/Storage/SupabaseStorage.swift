//
//  SupabaseStorage.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation
import Supabase
import UIKit

class SupabaseStorage {
    private let supabase: SupabaseClient
    let localStorage: LocalStorage

    init(localStorage: LocalStorage) {
        self.supabase = SupabaseClient(
          supabaseURL: URL(string: "https://kdolczcfdiaufkxbhesi.supabase.co")!,
          supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtkb2xjemNmZGlhdWZreGJoZXNpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE1OTQ2MjEsImV4cCI6MjA1NzE3MDYyMX0.DiWQqy23SbaIdNECkDG9qvXeD4S7LAajLsVWNXUSd8M"
        )
        self.localStorage = localStorage
    }
    
    func getImageURL(imageName: String) -> URL? {
        let bucket = supabase.storage.from("background_images")

        do {
            let url = try bucket.getPublicURL(path: "\(imageName)")
            return url
        } catch {
            print("Lỗi khi lấy URL: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchImage(_ name: String) async -> UIImage? {
        // fetch from local storage first
        let hasExt = !(name as NSString).pathExtension.isEmpty
        let name = hasExt ? name : "\(name).jpg"
        
        if let data = await localStorage.load(fileName: name) {
            return UIImage(data: data)
        }
        
        // fetch from remote storage
        guard let url = getImageURL(imageName: name) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            await localStorage.save(fileName: name, data: data)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}

