//
//  AppDelegate.swift
//  Weather
//
//  Created by Dat Doan on 10/3/25.
//

import Foundation
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
