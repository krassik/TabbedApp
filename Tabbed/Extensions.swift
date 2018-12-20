import Foundation
import UIKit

extension UITabBarController {
    @IBInspectable var selected_index: Int {
        get {
            return selectedIndex
        }
        set(index) {
            selectedIndex = index
        }
    }
}
