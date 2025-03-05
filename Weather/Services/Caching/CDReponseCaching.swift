//
//  CDReponseCaching.swift
//  Weather
//
//  Created by Dat Doan on 5/3/25.
//

import Foundation
import Networking
import CoreData

actor CDReponseCaching: CacheManager {
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Caching")
        container.loadPersistentStores { desc, error in
            print("Loading caching database error: \(error?.localizedDescription ?? "No error")")
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save(_ data: Data, for key: String) async {
        let cachedResponse = CDCachedResponse(context: context)
        cachedResponse.key = key
        cachedResponse.data = data
        cachedResponse.timestamp = Date()
        
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        do {
            try context.save()
        } catch {
            print("Save response in cache error: \(error.localizedDescription)")
        }
    }

    func get(for key: String) async -> Data? {
        let request = NSFetchRequest<CDCachedResponse>(entityName: "CDCachedResponse")
        request.predicate = NSPredicate(format: "key == %@", key)
        
        if let cachedResponse = try? context.fetch(request).first {
            return cachedResponse.data
        }
        return nil
    }
}
