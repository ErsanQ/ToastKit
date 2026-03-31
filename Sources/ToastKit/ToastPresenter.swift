import Foundation

#if canImport(UIKit)
import UIKit
#endif

// MARK: - ToastPresenter

/// Internal engine — manages the queue and animates toasts in/out.
@MainActor
final class ToastPresenter {

    static let shared = ToastPresenter()
    private init() {}

    // MARK: - Queue

    private var queue: [(message: String, style: ToastStyle, config: ToastConfiguration)] = []
    private var isPresenting = false
    #if canImport(UIKit)
    private weak var currentToast: UIView? // Generic UIView for toast
    #endif

    // MARK: - Enqueue

    func enqueue(message: String, style: ToastStyle, config: ToastConfiguration) {
        queue.append((message, style, config))
        if !isPresenting { presentNext() }
    }

    // MARK: - Present

    private func presentNext() {
        guard !queue.isEmpty else { isPresenting = false; return }
        isPresenting = true

        let item = queue.removeFirst()
        
        #if os(iOS)
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
            isPresenting = false
            return
        }

        let toast = ToastView(message: item.message, style: item.style, configuration: item.config)
        toast.translatesAutoresizingMaskIntoConstraints = false
        toast.alpha = 0
        window.addSubview(toast)
        currentToast = toast

        // Layout
        let isTop = item.config.position == .top
        let safeInset: CGFloat = isTop
            ? window.safeAreaInsets.top + 8
            : window.safeAreaInsets.bottom + 8

        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: window.centerXAnchor),
            isTop
                ? toast.topAnchor.constraint(equalTo: window.topAnchor, constant: safeInset)
                : toast.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -safeInset)
        ])

        window.layoutIfNeeded()

        // Slide in
        let offset: CGFloat = isTop ? -80 : 80
        toast.transform = CGAffineTransform(translationX: 0, y: offset)

        UIView.animate(
            withDuration: 0.45,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5
        ) {
            toast.alpha = 1
            toast.transform = .identity
        }

        // Tap to dismiss
        if item.config.tapToDismiss {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            toast.addGestureRecognizer(tap)
            toast.isUserInteractionEnabled = true
        }

        // Auto dismiss
        let duration = item.config.duration
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self, weak toast] in
            guard let toast, toast.superview != nil else { return }
            self?.dismiss(toast: toast, isTop: isTop)
        }
        #else
        // Mock for non-iOS platforms
        isPresenting = false
        #endif
    }

    #if canImport(UIKit)
    // MARK: - Dismiss

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let toast = gesture.view else { return }
        dismiss(toast: toast, isTop: true)
    }

    private func dismiss(toast: UIView, isTop: Bool) {
        #if os(iOS)
        let offset: CGFloat = isTop ? -80 : 80
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            toast.alpha = 0
            toast.transform = CGAffineTransform(translationX: 0, y: offset)
        } completion: { [weak self] _ in
            toast.removeFromSuperview()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                self?.presentNext()
            }
        }
        #endif
    }

    // MARK: - Dismiss Current

    func dismissCurrent() {
        guard let toast = currentToast else { return }
        dismiss(toast: toast, isTop: true)
    }
    #else
    func dismissCurrent() {}
    #endif
}
