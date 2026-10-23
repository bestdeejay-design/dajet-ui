import SwiftUI

/// Типографическая шкала линейки.
///
/// Заменяет разрозненные размеры интерфейса браузера (240 вызовов
/// `.font(.system(size:))` с 12 разными значениями) пятью именованными
/// стилями. Всё — системный шрифт: масштабируется с настройками системы,
/// поддерживает any-size text.
public enum Typography {
    /// Заголовки панелей и модальных карточек.
    public static let display = Font.system(size: 17, weight: .semibold)
    /// Основной текст и контролы.
    public static let body = Font.system(size: 13)
    /// Вторичный текст, пояснения под контролами.
    public static let bodyMuted = Font.system(size: 12)
    /// Метки-надписи, капс-заголовки секций.
    public static let label = Font.system(size: 11, weight: .medium)
    /// Мелкие подписи, бейджи, тайминги.
    public static let caption = Font.system(size: 10)
    /// Моноширинный: таймкоды, счётчики, числа в интерфейсе.
    public static let mono = Font.system(size: 11, design: .monospaced)
}
