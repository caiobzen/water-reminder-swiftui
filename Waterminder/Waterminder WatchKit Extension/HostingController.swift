import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<WaterView> {
    override var body: WaterView {
        return WaterView()
    }
}
