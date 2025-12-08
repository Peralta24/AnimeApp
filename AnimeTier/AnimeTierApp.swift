//
//  AnimeTierApp.swift
//  AnimeTier
//
//  Created by Jose Rafael Peralta Martinez  on 02/12/25.
//

import SwiftUI
import SwiftData
@main
struct AnimeTierApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: AnimeEntry.self)
    }
}
