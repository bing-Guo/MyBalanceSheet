import Foundation

import UIKit

extension UIColor {
    // 以擴展uicolor，以hex方式建立color
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let redValue = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let greenValue = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blueValue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    class var _app_background: UIColor {
        return UIColor(hex: "#eeeeee")
    }
    
    class var _standard_gray: UIColor {
        return UIColor(hex: "#cccccc")
    }
    
    class var _bootstrap_red: UIColor {
        return UIColor(hex: "#E1455E")
    }
    
    class var _bootstrap_yellow: UIColor {
        return UIColor(hex: "#F7C64B")
    }
    
    class var _asset_background_green: UIColor {
        return UIColor(hex: "#36C489")
    }
    
    class var _asset_green: UIColor {
        return UIColor(hex: "#299E6E")
    }
}
