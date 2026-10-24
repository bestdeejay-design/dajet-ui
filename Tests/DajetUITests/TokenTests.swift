import XCTest
import AppKit
@testable import DajetUI

/// Пины эталона: значения базы — числа, снятые с браузера Dajet. Любая правка
/// токенов теперь обязана пройти через эти строки — дрейф ловится тестом,
/// а не глазом владельца на демо.
final class TokenTests: XCTestCase {
    // Динамический NSColor разрешается под конкретным обликом.
    private func rgb(_ color: NSColor, dark: Bool) -> (UInt64, UInt64, UInt64) {
        let appearance = NSAppearance(named: dark ? .darkAqua : .aqua)!
        var resolved = color
        appearance.performAsCurrentDrawingAppearance {
            resolved = color.usingColorSpace(.sRGB) ?? color
        }
        return (
            UInt64((resolved.redComponent * 255).rounded()),
            UInt64((resolved.greenComponent * 255).rounded()),
            UInt64((resolved.blueComponent * 255).rounded())
        )
    }

    private func assertHex(_ color: NSColor, _ light: UInt64, _ dark: UInt64,
                           _ name: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(rgb(color, dark: false).0, (light >> 16) & 0xFF, "\(name) light R", file: file, line: line)
        XCTAssertEqual(rgb(color, dark: false).1, (light >> 8) & 0xFF, "\(name) light G", file: file, line: line)
        XCTAssertEqual(rgb(color, dark: false).2, light & 0xFF, "\(name) light B", file: file, line: line)
        XCTAssertEqual(rgb(color, dark: true).0, (dark >> 16) & 0xFF, "\(name) dark R", file: file, line: line)
        XCTAssertEqual(rgb(color, dark: true).1, (dark >> 8) & 0xFF, "\(name) dark G", file: file, line: line)
        XCTAssertEqual(rgb(color, dark: true).2, dark & 0xFF, "\(name) dark B", file: file, line: line)
    }

    func testPalettePairs() {
        assertHex(Palette.NS.ground, 0xFFFFFF, 0x1C1C1C, "ground")
        assertHex(Palette.NS.ink, 0x171717, 0xEDEDED, "ink")
        assertHex(Palette.NS.muted, 0x8C8C8C, 0x949494, "muted")
        assertHex(Palette.NS.faint, 0xD4D4D4, 0x525252, "faint")
        assertHex(Palette.NS.hairline, 0xE8E8E8, 0x333333, "hairline")
        assertHex(Palette.NS.wash, 0xEFEFEF, 0x2D2D2D, "wash")
        assertHex(Palette.NS.hover, 0xF6F6F6, 0x262626, "hover")
        assertHex(Palette.NS.pinLive, 0xE6E6E6, 0x363636, "pinLive")
        assertHex(Palette.NS.resting, 0xCCCCCC, 0x4D4D4D, "resting")
        assertHex(Palette.NS.accent, 0xC1542B, 0xE8AE8C, "accent")
        assertHex(Palette.NS.onAccent, 0xFFFFFF, 0x0E0F11, "onAccent")
        assertHex(Palette.NS.positive, 0x14803D, 0x4ADE80, "positive")
        assertHex(Palette.NS.caution, 0xB5540A, 0xFABF24, "caution")
    }

    func testMetrics() {
        XCTAssertEqual(Metrics.strip, 52)
        XCTAssertEqual(Metrics.lights, 100)
        // 3 двери + 2 зазора + поле: 3·26 + 2·2 + 8.
        XCTAssertEqual(Metrics.helm, 3 * 26 + 2 * 2 + 8)
        XCTAssertEqual(Metrics.bare, 34)
        XCTAssertEqual(Metrics.tabWidth, 186)
        XCTAssertEqual(Metrics.tabMinWidth, 36)
        XCTAssertEqual(Metrics.tabGap, 2)
        XCTAssertEqual(Metrics.fieldWidth, 560)
        XCTAssertEqual(Metrics.door, 26)
        XCTAssertEqual(Metrics.row, 26)
        XCTAssertEqual(Metrics.side, 232)
        XCTAssertEqual(Metrics.sideMin, 176)
        XCTAssertEqual(Metrics.sideMax, 440)
    }

    func testScales() {
        XCTAssertEqual(Radius.chip, 4)
        XCTAssertEqual(Radius.control, 8)
        XCTAssertEqual(Radius.field, 10)
        XCTAssertEqual(Radius.item, 11)
        XCTAssertEqual(Radius.panel, 16)
        XCTAssertEqual(Spacing.xxs, 2)
        XCTAssertEqual(Spacing.xs, 4)
        XCTAssertEqual(Spacing.s, 6)
        XCTAssertEqual(Spacing.m, 8)
        XCTAssertEqual(Spacing.l, 10)
        XCTAssertEqual(Spacing.xl, 12)
        XCTAssertEqual(Spacing.xxl, 14)
        XCTAssertEqual(Spacing.xxxl, 16)
    }

    func testLookRoundTrip() {
        XCTAssertEqual(Look(rawValue: "light"), .light)
        XCTAssertEqual(Look(rawValue: "dark"), .dark)
        XCTAssertEqual(Look(rawValue: "system"), .system)
        XCTAssertNil(Look(rawValue: "sepia"))
    }
}
