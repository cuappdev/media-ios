//
//  AppDelegate.swift
//  Volume
//
//  Created by Yana Sang on 10/6/20.
//  Copyright © 2020 Cornell AppDev. All rights reserved.
//

import AppDevAnalytics
import AppDevAnnouncements
import Firebase
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Setup Firebase
        FirebaseApp.configure()
        
        // Setup AppDevAnnouncements
        AnnouncementNetworking.setupConfig(
            scheme: Secrets.announcementsScheme,
            host: Secrets.announcementsHost,
            commonPath: Secrets.announcementsCommonPath,
            announcementPath: Secrets.announcementsPath
        )
        
        // Setup push notifications
        UIApplication.shared.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
        subscribeToNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be
        // called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they
        // will not return.
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        self.forwardTokenToServer(token: deviceToken)
    }
    
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("Remote notification is unavailable: \(error.localizedDescription)")
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        AppDevAnalytics.log(VolumeEvent.notificationOpened.toEvent(.general, navigationSource: .notification))
        if let userInfo = response.notification.request.content.userInfo as? [String: Any] {
            handleNotification(userInfo: userInfo)
        }
        
        completionHandler()
    }
    
    func forwardTokenToServer(token: Data) {
        let tokenComponents = token.map { data in String(format: "%02.2hhx", data) }
        let deviceTokenString = tokenComponents.joined()
        
        // TODO: make POST to backend
        print("Device Token: \(deviceTokenString)")
    }
    
    private func subscribeToNotifications() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(
            options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
    }
    
    private func handleNotification(userInfo: [String: Any]) {
        // TODO: open app in correct screen, display weekly debrief, etc
    }
}
