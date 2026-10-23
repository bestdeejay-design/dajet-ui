import SwiftUI

// Рецепты окна: как одеть окно приложения линейки — плитой без тайтлбара
// или с системным тулбаром. Это не токены и не компоненты, а пара
// модификаторов, повторяющих одну и ту же настройку NSWindow/SwiftUI
// в каждом приложении линейки; собраны здесь, чтобы она не расползалась.

/// AppKit-исполнение рецепта плиты: попадает в `NSWindow` через
/// представление-приманку, потому что SwiftUI отдаёт окно только тому,
/// кто в нём живёт.
private struct PlateWindowDress: NSViewRepresentable {
    let movableByBackground: Bool

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.window.map(dress)
        return view
    }

    func updateNSView(_ view: NSView, context: Context) {
        view.window.map(dress)
    }

    private func dress(_ window: NSWindow) {
        window.titlebarAppearsTransparent = true
        window.titleVisibility = .hidden
        window.styleMask.insert(.fullSizeContentView)
        window.isMovableByWindowBackground = movableByBackground
        window.backgroundColor = NSColor(Palette.ground)
    }
}

public extension View {
    /// Одевает окно плитой линейки: прозрачный тайтлбар без заголовка,
    /// контент на всю высоту окна, фон окна — `Palette.ground`
    /// (динамический: светлый и тёмный меняются с Системой сами).
    ///
    /// `movableByBackground` разрешает тащить окно за любое место
    /// контента — для плит без хрома это единственный способ; у окна
    /// со своим тулбаром оставьте выключенным. Вешается на корневой
    /// контент окна:
    ///
    ///     Window("Плита", id: "plate") {
    ///         ContentView()
    ///             .dajetPlateWindow(movableByBackground: true)
    ///     }
    func dajetPlateWindow(movableByBackground: Bool = false) -> some View {
        background(PlateWindowDress(movableByBackground: movableByBackground))
    }

    /// Вторая половина рецепта тулбара — на корневой контент окна:
    /// фон тулбара решает Система (`.automatic` — с материалом или без,
    /// как требует контекст окна и Системные настройки).
    @ViewBuilder
    func dajetToolbarWindow() -> some View {
        if #available(macOS 15.0, *) {
            toolbarBackground(.automatic, for: .windowToolbar)
        } else {
            self
        }
    }
}

public extension Scene {
    /// Первая половина рецепта тулбара — на сцену окна: единый тулбар
    /// без заголовка, системный вид macOS. SwiftUI делит рецепт между
    /// двумя сущностями, поэтому и модификаторов с этим именем два —
    /// этот на `Window`, второй (выше, на View) на корневой контент:
    ///
    ///     Window("Тулбар", id: "toolbar") {
    ///         ContentView()
    ///             .dajetToolbarWindow()
    ///             .toolbar { ToolbarItem { … } }
    ///     }
    ///     .dajetToolbarWindow()
    func dajetToolbarWindow() -> some Scene {
        self.windowToolbarStyle(.unified(showsTitle: false))
    }
}
