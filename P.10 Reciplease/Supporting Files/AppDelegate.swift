//
//  AppDelegate.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 07/11/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureTabBarAppearance()
        
         
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

    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "P_10_Reciplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // Initialise du NSPersistent
    static var persistentContainer: NSPersistentContainer {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    // Initialise du context
    static var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    
    
    
    
    // MARK: - Configure Navigation Bar & Tab bar
    
    private func configureNavigationBarAppearance() {
        if #available(iOS 15.0, *) {
          let navigationBarAppearance = UINavigationBarAppearance()
          navigationBarAppearance.configureWithDefaultBackground()
          UINavigationBar.appearance().standardAppearance = navigationBarAppearance
          UINavigationBar.appearance().compactAppearance = navigationBarAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
      }
      
      private func configureTabBarAppearance() {
        if #available(iOS 15.0, *) {
          let appearance = UITabBarAppearance()
          appearance.configureWithDefaultBackground()
          UITabBar.appearance().standardAppearance = appearance
           UITabBar.appearance().scrollEdgeAppearance = appearance
        }
      }

}

