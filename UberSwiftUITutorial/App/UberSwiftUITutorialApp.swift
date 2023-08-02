//
//  UberSwiftUITutorialApp.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 01.08.2023.
//

import SwiftUI

@main
struct UberSwiftUITutorialApp: App {
    @StateObject var locationViewModel=LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
