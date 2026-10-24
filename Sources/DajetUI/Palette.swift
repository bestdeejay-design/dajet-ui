import SwiftUI

/// Единая палитра Dajet — основа интерфейса всех приложений линейки.
///
/// Ахроматические пары сняты с браузера Dajet (эталонный интерфейс владельца,
/// `Design.swift`), акцент — фирменная терракота из brand-пакета, как у плеера
/// и редактора. Каждый токен — пара светлой и тёмной темы через dynamic
/// provider, поэтому смена light/dark происходит системой автоматически.
public enum Palette {
    /// Фон окна.
    public static let ground = pair(0xFFFFFF, 0x1C1C1C)
    /// Основной текст.
    public static let ink = pair(0x171717, 0xEDEDED)
    /// Вторичный текст.
    public static let muted = pair(0x8C8C8C, 0x949494)
    /// Подложки-призраки, выключенные контролы.
    public static let faint = pair(0xD4D4D4, 0x525252)
    /// Волосяные линии и обводки.
    public static let hairline = pair(0xE8E8E8, 0x333333)
    /// Заливка полей ввода и «мыльных» поверхностей.
    public static let wash = pair(0xEFEFEF, 0x2D2D2D)
    /// Состояние наведения.
    public static let hover = pair(0xF6F6F6, 0x262626)
    /// «Живой» пин на полосе (вкладка закреплена, приложение активно).
    public static let pinLive = pair(0xE6E6E6, 0x363636)
    /// Покой полосы: приложение неактивно, хром притухает.
    public static let resting = pair(0xCCCCCC, 0x4D4D4D)
    /// Терракота — единственный цветовой акцент линейки (brand).
    public static let accent = pair(0xC1542B, 0xE8AE8C)
    /// Текст и глифы на залитой акцентом поверхности.
    public static let onAccent = pair(0xFFFFFF, 0x0E0F11)
    /// Успех, «безопасно».
    public static let positive = pair(0x14803D, 0x4ADE80)
    /// Внимание, «осторожно».
    public static let caution = pair(0xB5540A, 0xFABF24)

    /// Парный цвет light/dark на основе hex-значений.
    public static func pair(_ light: UInt64, _ dark: UInt64) -> Color {
        Color(nsColor: nsPair(light, dark))
    }

    /// Динамический NSColor, переключающийся темой системы.
    static func nsPair(_ light: UInt64, _ dark: UInt64) -> NSColor {
        NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.darkAqua, .vibrantDark]) != nil
            return NSColor(hex: isDark ? dark : light)
        }
    }
}

public extension Palette {
    /// NSColor-варианты токенов для AppKit-приложений линейки (редактор).
    /// Значения — те же пары, что и у SwiftUI-вариантов.
    enum NS {
        /// Фон окна.
        public static let ground = Palette.nsPair(0xFFFFFF, 0x1C1C1C)
        /// Основной текст.
        public static let ink = Palette.nsPair(0x171717, 0xEDEDED)
        /// Вторичный текст.
        public static let muted = Palette.nsPair(0x8C8C8C, 0x949494)
        /// Подложки-призраки, выключенные контролы.
        public static let faint = Palette.nsPair(0xD4D4D4, 0x525252)
        /// Волосяные линии и обводки.
        public static let hairline = Palette.nsPair(0xE8E8E8, 0x333333)
        /// Заливка полей ввода.
        public static let wash = Palette.nsPair(0xEFEFEF, 0x2D2D2D)
        /// Состояние наведения.
        public static let hover = Palette.nsPair(0xF6F6F6, 0x262626)
        /// Терракота — единственный цветовой акцент линейки.
        public static let accent = Palette.nsPair(0xC1542B, 0xE8AE8C)
        /// Текст и глифы на акценте.
        public static let onAccent = Palette.nsPair(0xFFFFFF, 0x0E0F11)
        /// Успех.
        public static let positive = Palette.nsPair(0x14803D, 0x4ADE80)
        /// Внимание.
        public static let caution = Palette.nsPair(0xB5540A, 0xFABF24)
    }
}

extension NSColor {
    convenience init(hex: UInt64) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255,
            green: CGFloat((hex >> 8) & 0xFF) / 255,
            blue: CGFloat(hex & 0xFF) / 255,
            alpha: 1
        )
    }
}
