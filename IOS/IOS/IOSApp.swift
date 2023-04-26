//
//  IOSApp.swift
//  IOS
//
//  Created by Janne van Seggelen on 24/04/2023.
//

import SwiftUI
import PopupView

@main
struct IOSApp: App {
    var body: some Scene {
            WindowGroup(content: ContentView().implementPopupView)
    }
}
