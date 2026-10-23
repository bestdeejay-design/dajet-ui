import SwiftUI

/// Рецепт настроек линейки: обёртка системной Settings-сцены с табами и
/// фоном пакета. ⌘, открывает их — за это отвечает сама `Settings`,
/// обёртка лишь одевает: `TabView` вкладок-`SettingsTab`, идеальный
/// размер 660×500 (окно настроек нерастяжимо и берёт идеал контента),
/// фон — `Palette.ground`.
///
///     DajetSettings {
///         SettingsTab(title: "Общие", icon: "gear") { … }
///         SettingsTab(title: "Внешний вид", icon: "paintbrush") { … }
///     }
public struct DajetSettings<Content: View>: Scene {
    @ViewBuilder let tabs: () -> Content

    public init(@ViewBuilder tabs: @escaping () -> Content) {
        self.tabs = tabs
    }

    public var body: some Scene {
        Settings {
            TabView { tabs() }
                .frame(idealWidth: 660, idealHeight: 500)
                .background(Palette.ground)
        }
    }
}

/// Одна вкладка настроек: скролл со своими секциями — капс-заголовок
/// `Caption` над каждой, под ним `Card` из `Line`, разделённых `Rule`.
/// Сама вкладка — только рама: фон, прокрутка и подпись в колонке табов.
public struct SettingsTab<Pane: View>: View {
    let title: String
    let icon: String?
    @ViewBuilder let pane: () -> Pane

    /// - Parameters:
    ///   - title: подпись вкладки в колонке/табах окна настроек.
    ///   - icon: SF Symbol рядом с подписью; nil — только текст.
    ///   - pane: содержимое: секции из `Caption` + `Card { Line… Rule… }`.
    public init(
        title: String,
        icon: String? = nil,
        @ViewBuilder pane: @escaping () -> Pane
    ) {
        self.title = title
        self.icon = icon
        self.pane = pane
    }

    public var body: some View {
        ScrollView {
            pane()
                .padding(20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Palette.ground)
        .tabItem {
            if let icon {
                Label(title, systemImage: icon)
            } else {
                Text(title)
            }
        }
    }
}
