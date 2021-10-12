//
//  AppDelegate.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 10.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "firstLaunch") == true {
            print("повторный запуск приложения")
            CoreDataManager.shared.load()
        } else {
            print("первый запуск приложения")
            defaults.set(true, forKey: "firstLaunch")
            CoreDataManager.shared.load()
            let note = CoreDataManager.shared.createNote()
            note.text = "Тестовая заметка при первом запуске \nНажмите на заметку для изменения текста"
            CoreDataManager.shared.save()

        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

