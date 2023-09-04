//
//  chatting_appApp.swift
//  chatting-app
//
//  Created by Imran Abdullah on 29/08/23.
//

import SwiftUI

@main
struct chatting_appApp: App {
    @StateObject private var authStatus = AuthStatus()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authStatus)
        }
    }
}
