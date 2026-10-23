import SwiftUI

/// Движение интерфейса линейки — пружины браузера Dajet.
///
/// Две пружины и один быстрый отклик закрывают все сценарии; при
/// «Уменьшить движение» приложение само подменяет их мгновенными
/// переходами (рецепт — в гайде пакета).
public enum Motion {
    /// Перемещение больших поверхностей: вкладки, панели, сайдбар.
    public static let glide = Animation.spring(response: 0.34, dampingFraction: 0.82)
    /// Смена состояния: переключатели, выделение, раскрытие.
    public static let settle = Animation.spring(response: 0.30, dampingFraction: 0.86)
    /// Мгновенный отклик: ховер, подсветка, фокус.
    public static let quick = Animation.easeOut(duration: 0.14)
}
