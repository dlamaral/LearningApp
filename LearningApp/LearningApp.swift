//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Diogo Amaral on 30/06/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
