import CoreGraphics

/// Размеры хрома, общие для линейки (сняты с Metrics браузера Dajet).
public enum Metrics {
    /// Высота верхней полосы окна (таб-полоса браузера, тулбар).
    public static let strip: CGFloat = 52
    /// Квадратная иконочная кнопка («дверь»).
    public static let door: CGFloat = 26
    /// Строка списка.
    public static let row: CGFloat = 26
    /// Идеальная ширина сайдбара.
    public static let side: CGFloat = 232
    /// Минимальная ширина сайдбара.
    public static let sideMin: CGFloat = 176
    /// Максимальная ширина сайдбара.
    public static let sideMax: CGFloat = 440
    /// Ширина вкладки браузера.
    public static let tabWidth: CGFloat = 186
}

/// Шкала скруглений: в браузере сейчас 12 разных значений (3…18),
/// здесь — пять именованных. Старые значения при миграции округляются
/// до ближайшей ступени.
public enum Radius {
    /// Бейджи, мини-метки.
    public static let chip: CGFloat = 4
    /// Кнопки и иконочные кнопки.
    public static let control: CGFloat = 8
    /// Поля ввода.
    public static let field: CGFloat = 10
    /// Карточки-строки, группы в панелях.
    public static let item: CGFloat = 12
    /// Модальные панели и крупные карточки.
    public static let panel: CGFloat = 16
}

/// Шкала отступов.
public enum Spacing {
    public static let xxs: CGFloat = 2
    public static let xs: CGFloat = 4
    public static let s: CGFloat = 6
    public static let m: CGFloat = 8
    public static let l: CGFloat = 10
    public static let xl: CGFloat = 12
    public static let xxl: CGFloat = 14
    public static let xxxl: CGFloat = 16
}
