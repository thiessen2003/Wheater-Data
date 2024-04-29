//
//  HWCIS1951App.swift
//  HWCIS1951
//
//  Created by Gabriel Thiessen on 4/11/24.
//

import SwiftUI

@main
struct HWCIS1951App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
