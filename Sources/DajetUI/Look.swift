import AppKit
import SwiftUI

/// Какое из трёх лиц носит приложение — светлый, тёмный или то, что
/// назначила Система. Ставится на приложение целиком (`NSApp.appearance`),
/// а не на отдельное окно, чтобы каждая панель, алерт и лист соглашались
/// с окном, из которого открыты. Рецепт — `Theme` плеера Dajet
/// (`Design.swift`), а до него `Look.apply()` браузера, дословно.
public enum Look: String, CaseIterable {
    /// Как у Mac: приложение следует Системе и меняется вместе с ней.
    case system
    /// Светлое лицо.
    case light
    /// Тёмное лицо.
    case dark

    /// Ключ, под которым выбор помнится в UserDefaults.
    static let key = "look"

    /// Что написано на сегменте пикера.
    public var title: String {
        switch self {
        case .system: return "Системная"
        case .light: return "Светлая"
        case .dark: return "Тёмная"
        }
    }

    /// Выбранный в прошлый раз вид; если выбора не было — системный,
    /// с него начинается свежая копия любого приложения линейки.
    public static var current: Look {
        Look(rawValue: UserDefaults.standard.string(forKey: key) ?? "") ?? .system
    }

    /// Запомнить выбор на будущее.
    public static func remember(_ look: Look) {
        UserDefaults.standard.set(look.rawValue, forKey: key)
    }

    /// Что сказать приложению. Для `system` — ничего: приложение тогда
    /// следует за Mac и меняется вместе с ним.
    public var appearance: NSAppearance? {
        switch self {
        case .system: return nil
        case .light: return NSAppearance(named: .aqua)
        case .dark: return NSAppearance(named: .darkAqua)
        }
    }

    /// Надеть лицо на всё приложение. Не изнутри анимации, в которой
    /// попросили: перекрасить каждое окно посреди перехода — верный способ
    /// получить слой, что ловит щелчки и ничего не показывает; следующего
    /// оборота петли событий достаточно.
    public func apply() {
        let wanted = appearance
        DispatchQueue.main.async {
            guard NSApp.appearance !== wanted, NSApp.appearance?.name != wanted?.name else { return }
            NSApp.appearance = wanted
        }
    }
}

/// Сегмент из трёх лиц приложения: меняет всю app живьём и помнит выбор
/// между запусками. «Системная» возвращает решение Mac.
public struct LookPicker: View {
    @State private var look = Look.current

    public init() {}

    public var body: some View {
        Segmented(Look.allCases.map { ($0, $0.title) }, selection: $look)
            .frame(width: 260)
            .onChange(of: look) {
                Look.remember(look)
                look.apply()
            }
    }
}
