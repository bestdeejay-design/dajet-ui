import SwiftUI

/// Движение интерфейса линейки — пружины браузера Dajet.
///
/// Две пружины и один быстрый отклик закрывают все сценарии. Токены —
/// вычисляемые `Animation?`: при включённом «Уменьшить движение» они
/// отдают nil, и переходы (`.animation`, `withAnimation`, `transition`)
/// становятся мгновенными — интерфейс не прыгает и не скользит. Рецепт
/// снят с браузера Dajet (`Design.swift`): «Уменьшить движение» читается
/// заново при каждом обращении, чтобы смена настройки в Системе действовала
/// без перезапуска приложения.
public enum Motion {
    /// Перемещение больших поверхностей: вкладки, панели, сайдбар.
    /// Nil при «Уменьшить движение».
    public static var glide: Animation? {
        reduced ? nil : .spring(response: 0.34, dampingFraction: 0.82)
    }

    /// Смена состояния: переключатели, выделение, раскрытие.
    /// Nil при «Уменьшить движение».
    public static var settle: Animation? {
        reduced ? nil : .spring(response: 0.30, dampingFraction: 0.86)
    }

    /// Мгновенный отклик: ховер, подсветка, фокус.
    /// Nil при «Уменьшить движение».
    public static var quick: Animation? {
        reduced ? nil : .easeOut(duration: 0.14)
    }

    /// Просила ли Система меньше движения. Приватно, чтобы не сталкиваться
    /// с собственными расширениями `Motion` у потребителей пакета.
    private static var reduced: Bool {
        NSWorkspace.shared.accessibilityDisplayShouldReduceMotion
    }
}
