import XCTest
@testable import ToastKit

final class ToastKitTests: XCTestCase {

    // MARK: - ToastStyle

    func test_style_success_hasGreenBackground() {
        let color = ToastStyle.success.backgroundColor
        var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        XCTAssertGreaterThan(g, r) // green > red
    }

    func test_style_error_hasRedBackground() {
        let color = ToastStyle.error.backgroundColor
        var r: CGFloat = 0; var g: CGFloat = 0; var b: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        XCTAssertGreaterThan(r, g) // red > green
    }

    func test_style_allCases_haveIcons() {
        let styles: [ToastStyle] = [.success, .error, .info, .warning]
        styles.forEach { XCTAssertFalse($0.iconName.isEmpty) }
    }

    func test_style_custom_usesProvidedColors() {
        let style = ToastStyle.custom(background: .purple, foreground: .yellow)
        XCTAssertEqual(style.backgroundColor, .purple)
        XCTAssertEqual(style.foregroundColor, .yellow)
    }

    // MARK: - ToastConfiguration

    func test_defaultConfig_duration() {
        XCTAssertEqual(ToastConfiguration.default.duration, 2.5)
    }

    func test_defaultConfig_positionIsTop() {
        if case .top = ToastConfiguration.default.position {} else {
            XCTFail("Expected .top position")
        }
    }

    func test_defaultConfig_showsIcon() {
        XCTAssertTrue(ToastConfiguration.default.showIcon)
    }

    func test_defaultConfig_tapToDismiss() {
        XCTAssertTrue(ToastConfiguration.default.tapToDismiss)
    }

    func test_customConfig_bottomPosition() {
        let config = ToastConfiguration(position: .bottom)
        if case .bottom = config.position {} else {
            XCTFail("Expected .bottom position")
        }
    }

    func test_customConfig_customDuration() {
        let config = ToastConfiguration(duration: 5.0)
        XCTAssertEqual(config.duration, 5.0)
    }

    // MARK: - Sendable

    func test_style_isSendable() {
        let _: any Sendable = ToastStyle.success
    }

    func test_config_isSendable() {
        let _: any Sendable = ToastConfiguration.default
    }

    func test_position_isSendable() {
        let _: any Sendable = ToastPosition.top
    }
}
