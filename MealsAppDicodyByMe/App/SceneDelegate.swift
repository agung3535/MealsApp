//
//  SceneDelegate.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    print("masuk scene")
    let homeUseCase = Injection.init().provideHome()

    let homePresenter = HomePresenter(homeUseCase: homeUseCase)

    let contentView = ContentView().environmentObject(homePresenter)

    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
        print("window scene tidak nil")
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }else {
        print("window scene nil")
    }
  }
  
}

