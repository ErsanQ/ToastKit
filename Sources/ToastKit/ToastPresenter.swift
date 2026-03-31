import SwiftUI

/// The central manager responsible for coordinating toast presentations.
///
/// `ToastPresenter` manages an internal queue of `Toast` objects and ensures
/// only one toast is prominently displayed at a time (or as configured).
/// It provides a globally accessible `shared` instance.
@MainActor
public final class ToastPresenter: ObservableObject {
    
    /// The shared singleton instance of `ToastPresenter`.
    public static let shared = ToastPresenter()
    
    /// The currently active toast, if any.
    @Published public private(set) var currentToast: Toast?
    
    private init() {}
    
    /// Schedules a toast to be displayed to the user.
    ///
    /// - Parameter toast: The `Toast` instance to show.
    public func show(_ toast: Toast) {
        #if canImport(UIKit)
        withAnimation(.spring()) {
            currentToast = toast
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.config.duration) { [weak self] in
            self?.dismiss()
        }
        #endif
    }
    
    /// Manually dismisses the currently active toast with an animation.
    public func dismiss() {
        withAnimation(.spring()) {
            currentToast = nil
        }
    }
}
