//
//  HostingController.swift
//  Waterminder WatchKit Extension
//
//  Created by Carlos Corrêa on 19/09/19.
//  Copyright © 2019 Carlos Corrêa. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<WaterView> {
    override var body: WaterView {
        return WaterView()
    }
}
