//
//  AppDelegate.swift
//  Word Game
//
//  Created by Asad on 03/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepareRootViewController()
        return true
    }
    
    // Prepare initial viewcontroller
    
    private func prepareRootViewController(){
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let localRepository = LocalRepository.init()
        let wordListViewModel = WordListViewModel(localRepository)
        let wordListViewController = WordListViewController.init(viewModel: wordListViewModel)
        let navigationController = UINavigationController.init(rootViewController: wordListViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

