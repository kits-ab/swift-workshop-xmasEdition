//
//  workshopApp.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

@main
struct workshopApp: App {
    let environment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(container: environment.container))
        }
    }
}
