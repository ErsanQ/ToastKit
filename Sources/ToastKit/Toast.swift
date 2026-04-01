#if canImport(SwiftUI)
import SwiftUI

/// A premium, non-intrusive notification component for displaying status messages.
///
/// `Toast` provides a floating UI element that informs the user about events,
/// errors, or successes without interrupting their current workflow. It supports
/// glassmorphism styling and custom animations.
///
/// ## Usage
/// ```swift
/// let toast = Toast(title: "Success", image: "checkmark.circle", style: .success)
/// ToastPresenter.shared.show(toast)
/// ```
public struct Toast: Identifiable, Sendable {
    /// A unique identifier for each toast instance.
    public let id = UUID()
    /// The localized title of the toast.
    public let title: String
    /// An optional secondary description.
    public let message: String?
    /// An optional SF Symbol name to display as an icon.
    public let image: String?
    /// The visual style of the toast (e.g., `.success`, `.error`).
    public let style: ToastStyle
    /// Configuration defining position and duration.
    public let config: ToastConfiguration
    
    /// Creates a new Toast.
    ///
    /// - Parameters:
    ///   - title: The primary message.
    ///   - message: Optional detailed description.
    ///   - image: Optional SF Symbol name.
    ///   - style: Visual presentation style.
    ///   - config: Custom configuration for the toast.
    public init(
        title: String,
        message: String? = nil,
        image: String? = nil,
        style: ToastStyle = .info,
        config: ToastConfiguration = .default
    ) {
        self.title = title
        self.message = message
        self.image = image
        self.style = style
        self.config = config
    }
}
#endif
