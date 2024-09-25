//
//  HapticManager.swift
//  Waterminder WatchKit Extension
//
//  Created by MacBook AIR on 14/09/2024.
//  Copyright © 2024 Carlos Corrêa. All rights reserved.
//

import Foundation
import UIKit
import WatchKit

final class HapticManager {
    static let shared = HapticManager()

    private init() {}

    public func vibrateForSelection() {
        DispatchQueue.main.async {
            WKInterfaceDevice.current().play(.click)
        }
    }

    public func vibrate(for type: WKHapticType) {
        WKInterfaceDevice.current().play(type)
    }
}
