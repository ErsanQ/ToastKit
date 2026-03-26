#if canImport(UIKit)
import UIKit

// MARK: - Toast

/// A clean static API for showing toast notifications anywhere in your app.
///
/// ## Basic usage
/// ```swift
/// Toast.show("Saved successfully")
/// Toast.show("No internet connection", style: .error)
/// Toast.show("New message from Alex", style: .info, duration: 4)
/// ```
///
/// ## All styles
/// ```swift
/// Toast.success("Profile updated")
/// Toast.error("Upload failed")
/// Toast.warning("Low storage")
/// Toast.info("Sync complete")
/// ```
///
/// ## Custom configuration
/// ```swift
/// Toast.show(
///     "Order placed!",
///     style: .success,
///     configuration: ToastConfiguration(
///         duration: 4,
///         position: .bottom
///     )
/// )
/// ```
@MainActor
public enum Toast {

    // MARK: - Primary API

    /// Shows a toast with the given message and style.
    ///
    /// - Parameters:
    ///   - message: The text displayed in the toast.
    ///   - style: Visual style. Defaults to `.info`.
    ///   - configuration: Appearance and behavior settings.
    public static func show(
        _ message: String,
        style: ToastStyle = .info,
        configuration: ToastConfiguration = .default
    ) {
        ToastPresenter.shared.enqueue(message: message, style: style, config: configuration)
    }

    /// Shows a toast with a custom duration.
    ///
    /// ```swift
    /// Toast.show("Welcome back!", style: .success, duration: 3)
    /// ```
    public static func show(
        _ message: String,
        style: ToastStyle = .info,
        duration: TimeInterval
    ) {
        var config = ToastConfiguration.default
        config.duration = duration
        ToastPresenter.shared.enqueue(message: message, style: style, config: config)
    }

    // MARK: - Convenience

    /// Shows a green success toast.
    public static func success(_ message: String, duration: TimeInterval = 2.5) {
        show(message, style: .success, duration: duration)
    }

    /// Shows a red error toast.
    public static func error(_ message: String, duration: TimeInterval = 2.5) {
        show(message, style: .error, duration: duration)
    }

    /// Shows an orange warning toast.
    public static func warning(_ message: String, duration: TimeInterval = 2.5) {
        show(message, style: .warning, duration: duration)
    }

    /// Shows a blue info toast.
    public static func info(_ message: String, duration: TimeInterval = 2.5) {
        show(message, style: .info, duration: duration)
    }

    // MARK: - Dismiss

    /// Immediately dismisses the currently visible toast.
    public static func dismiss() {
        ToastPresenter.shared.dismissCurrent()
    }
}
#endif
