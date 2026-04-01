#if canImport(SwiftUI)
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - ToastStyle

/// The visual style of a toast notification.
///
/// ```swift
/// Toast.show("Saved", style: .success)
/// Toast.show("No connection", style: .error)
/// Toast.show("New message", style: .info)
/// Toast.show("Battery low", style: .warning)
/// Toast.show("Hello!", style: .custom(background: .purple, foreground: .white))
/// ```
public enum ToastStyle: Sendable {

    /// Green — indicates a successful operation.
    case success

    /// Red — indicates an error or failure.
    case error

    /// Blue — neutral informational message.
    case info

    /// Orange — indicates a warning.
    case warning

    /// A custom color combination.
    case custom(background: Color, foreground: Color)
}

// MARK: - Internal Resolved Colors

extension ToastStyle {

    var backgroundColor: Color {
        switch self {
        case .success: return Color(red: 0.13, green: 0.70, blue: 0.35)
        case .error:   return Color(red: 0.95, green: 0.23, blue: 0.19)
        case .info:    return Color(red: 0.0,  green: 0.48, blue: 1.0)
        case .warning: return Color(red: 1.0,  green: 0.58, blue: 0.0)
        case .custom(let bg, _): return bg
        }
    }

    var foregroundColor: Color {
        switch self {
        case .custom(_, let fg): return fg
        default: return Color.white
        }
    }

    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error:   return "xmark.circle.fill"
        case .info:    return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .custom:  return "bell.fill"
        }
    }
}

#if canImport(UIKit)
extension ToastStyle {
    var uiBackgroundColor: UIColor { UIColor(backgroundColor) }
    var uiForegroundColor: UIColor { UIColor(foregroundColor) }
}
#endif
#endif
