import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<WaterView> {
    let viewModel = WaterViewModel()
    override var body: WaterView {
        WaterView(viewModel: viewModel)
    }
}
