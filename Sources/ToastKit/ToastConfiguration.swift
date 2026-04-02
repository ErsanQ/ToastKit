#if canImport(SwiftUI)
import SwiftUI

/// Defines where a toast appears on screen and how long it stays visible.
public struct ToastConfiguration: Sendable {
    /// The screen position for toast delivery.
    public enum Position: Sendable {
        /// Top of the screen.
        case top
        /// Bottom of the screen.
        case bottom
        /// Center of the screen.
        case center
    }
    
    /// Where the toast is presented.
    public let position: Position
    /// Seconds before the toast automatically dismisses.
    public let duration: Double
    /// If true, the user can dismiss the toast by tapping it.
    public let isDismissible: Bool
    /// Corner radius of the toast pill shape.
    public let cornerRadius: CGFloat
    /// If true, a style-matched SF Symbol icon is shown alongside the message.
    public let showIcon: Bool

    /// Creates a new toast configuration.
    public init(
        position: Position = .top,
        duration: Double = 3.0,
        isDismissible: Bool = true,
        cornerRadius: CGFloat = 20,
        showIcon: Bool = true
    ) {
        self.position = position
        self.duration = duration
        self.isDismissible = isDismissible
        self.cornerRadius = cornerRadius
        self.showIcon = showIcon
    }
    
    /// The standard ErsanQ toast configuration.
    public static let `default` = ToastConfiguration()
}
#endif
