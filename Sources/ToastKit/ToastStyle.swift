#if canImport(UIKit)
import UIKit

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
    case custom(background: UIColor, foreground: UIColor)
}

// MARK: - Internal Resolved Colors

extension ToastStyle {

    var backgroundColor: UIColor {
        switch self {
        case .success: return UIColor(red: 0.13, green: 0.70, blue: 0.35, alpha: 1)
        case .error:   return UIColor(red: 0.95, green: 0.23, blue: 0.19, alpha: 1)
        case .info:    return UIColor(red: 0.0,  green: 0.48, blue: 1.0,  alpha: 1)
        case .warning: return UIColor(red: 1.0,  green: 0.58, blue: 0.0,  alpha: 1)
        case .custom(let bg, _): return bg
        }
    }

    var foregroundColor: UIColor {
        switch self {
        case .custom(_, let fg): return fg
        default: return .white
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
#endif
