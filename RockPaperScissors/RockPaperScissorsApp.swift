//
//  RockPaperScissorsApp.swift
//  RockPaperScissors
//
//  Created by Daniel Pape on 13/04/2021.
//

import SwiftUI

@main
struct RockPaperScissorsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(randomPick: 0, shouldWin: true)
        }
    }
}
