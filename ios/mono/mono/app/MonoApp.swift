//
//  MonoApp.swift
//  mono
//

import SwiftUI

@main
struct MonoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
