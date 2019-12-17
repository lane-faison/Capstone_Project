import UIKit

extension UIColor {
    /// Initializes a UIColor using the given hex value
    ///
    /// - Parameter hex: Hex code for the color you want to initialize
    public convenience init(hex: String, alpha: CGFloat? = 1.0) {
        var cString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[index...])
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(red: (rgbValue >> 16) & 0xff, green: (rgbValue >> 8) & 0xff, blue: rgbValue & 0xff, alpha: alpha ?? 1.0)
    }

    /// Convenience initializer to create a color with Unsigned 32bit Ints for RGB values
    ///
    /// - Parameters:
    ///   - red: Red value (out of 255)
    ///   - green: Green value (out of 255)
    ///   - blue: Blue value (out of 255)
    private convenience init(red: UInt32, green: UInt32, blue: UInt32, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// App Colors
    public class var darkPrimaryColor: UIColor { return UIColor(hex: "303F9F") }
    public class var primaryColor: UIColor { return UIColor(hex: "3F51B5") }
    public class var lightPrimaryColor: UIColor { return UIColor(hex: "C5CAE9") }
    public class var textPrimaryColor: UIColor { return UIColor(hex: "FFFFFF") }
    public class var accentColor: UIColor { return UIColor(hex: "FFEB3B") }
    public class var primaryTextColor: UIColor { return UIColor(hex: "212121") }
    public class var secondaryTextColor: UIColor { return UIColor(hex: "757575") }
    public class var dividerColor: UIColor { return UIColor(hex: "BDBDBD") }
}
