//
//  TappableTextApp.swift
//  TappableText
//
//  Created by Aleksei Kudriashov on 2/15/24.
//

import SwiftUI

@main
struct TappableTextApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
