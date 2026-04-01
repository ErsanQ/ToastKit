#if canImport(UIKit)
import UIKit

// MARK: - ToastView

/// The pill-shaped UIView that renders the toast notification.
final class ToastView: UIView {

    // MARK: - UI

    private let iconView   = UIImageView()
    private let messageLabel = UILabel()
    private let stack      = UIStackView()

    // MARK: - Init

    init(message: String, style: ToastStyle, configuration: ToastConfiguration) {
        super.init(frame: .zero)
        setup(message: message, style: style, configuration: configuration)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup(message: String, style: ToastStyle, configuration: ToastConfiguration) {
        backgroundColor = style.uiBackgroundColor
        layer.cornerRadius = configuration.cornerRadius
        layer.cornerCurve = .continuous

        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 12
        layer.shadowOffset = CGSize(width: 0, height: 4)

        // Icon
        if configuration.showIcon {
            let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
            iconView.image = UIImage(systemName: style.iconName, withConfiguration: config)
            iconView.tintColor = style.uiForegroundColor
            iconView.contentMode = .scaleAspectFit
            iconView.setContentHuggingPriority(.required, for: .horizontal)
        }

        // Label
        messageLabel.text = message
        messageLabel.textColor = style.uiForegroundColor
        messageLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        messageLabel.numberOfLines = 2
        messageLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        // Stack
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false

        if configuration.showIcon { stack.addArrangedSubview(iconView) }
        stack.addArrangedSubview(messageLabel)

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            widthAnchor.constraint(lessThanOrEqualToConstant: 320)
        ])
    }
}
#endif
