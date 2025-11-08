//
//  AppDelegate.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 4.12.23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var storageService: IStorageService = StorageService()
    private lazy var interactor: NotificationsInteractor = DefaultNotificationsInteractor(repo: CoreDataNotificationsRepository())
    private lazy var migrationManager = MigrationManager(storage: storageService, interactor: interactor)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        migrationManager.migrateIfNeeded { result in
            switch result {
            case .success:
                print("Migration completed or already done")
            case .failure(let error):
                print("Migration failed: \(error)")
            }
        }

        return true
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // noop
    }
}


