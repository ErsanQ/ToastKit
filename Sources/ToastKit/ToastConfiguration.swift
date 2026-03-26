#if canImport(UIKit)
import UIKit

// MARK: - ToastPosition

/// Where the toast appears on screen.
public enum ToastPosition: Sendable {
    /// Slides down from the top (below the status bar). Default.
    case top
    /// Slides up from the bottom (above the home indicator).
    case bottom
}

// MARK: - ToastConfiguration

/// Controls the appearance and behavior of a toast.
///
/// ```swift
/// let config = ToastConfiguration(
///     duration: 3.0,
///     position: .bottom,
///     showIcon: false
/// )
/// Toast.show("Done", style: .success, configuration: config)
/// ```
public struct ToastConfiguration: Sendable {

    /// Seconds the toast stays visible before auto-dismissing. Defaults to `2.5`.
    public var duration: TimeInterval

    /// Where the toast appears. Defaults to `.top`.
    public var position: ToastPosition

    /// Whether to show the leading SF Symbol icon. Defaults to `true`.
    public var showIcon: Bool

    /// Corner radius of the toast pill. Defaults to `14`.
    public var cornerRadius: CGFloat

    /// Whether tapping the toast dismisses it immediately. Defaults to `true`.
    public var tapToDismiss: Bool

    public init(
        duration: TimeInterval = 2.5,
        position: ToastPosition = .top,
        showIcon: Bool = true,
        cornerRadius: CGFloat = 14,
        tapToDismiss: Bool = true
    ) {
        self.duration = duration
        self.position = position
        self.showIcon = showIcon
        self.cornerRadius = cornerRadius
        self.tapToDismiss = tapToDismiss
    }

    /// The default configuration.
    public static var `default`: ToastConfiguration { ToastConfiguration() }
}
#endif
