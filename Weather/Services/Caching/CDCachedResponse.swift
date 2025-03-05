//
//  CDCachedResponse.swift
//  Weather
//
//  Created by Dat Doan on 5/3/25.
//

import Foundation
import CoreData

class CDCachedResponse: NSManagedObject {
    @NSManaged var key: String
    @NSManaged var data: Data
    @NSManaged var timestamp: Date
}
