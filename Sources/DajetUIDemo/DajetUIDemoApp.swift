import SwiftUI
import DajetUI

@main
struct DajetUIDemoApp: App {
    var body: some Scene {
        Window("DajetUI — токены", id: "styleguide") {
            StyleGuideWindow()
        }
        .windowStyle(.hiddenTitleBar)
        .defaultSize(width: 760, height: 720)
    }
}

/// Одевает окно как окна линейки: прозрачный тайтлбар, контент на всю высоту.
private struct WindowDress: NSViewRepresentable {
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
        window.isMovableByWindowBackground = true
    }
}

private struct StyleGuideWindow: View {
    var body: some View {
        VStack(spacing: 0) {
            TopStrip()
            Rectangle()
                .fill(Palette.hairline)
                .frame(height: 1)
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    GuideSection("Палитра") {
                        PaletteGrid()
                    }
                    GuideSection("Типографика") {
                        TypeRows()
                    }
                    GuideSection("Скругления") {
                        RadiusRow()
                    }
                    GuideSection("Движение") {
                        MotionDemo()
                    }
                    GuideSection("Метрики хрома") {
                        Text("strip 52 · door 26 · row 26 · side 232 (176–440) · tab 186")
                            .font(Typography.mono)
                            .foregroundStyle(Palette.muted)
                    }
                    Text("Этап 1 — токены. Далее: компоненты-минимум и рецепты окна.")
                        .font(Typography.caption)
                        .foregroundStyle(Palette.faint)
                        .padding(.top, 4)
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Palette.ground)
        .background(WindowDress())
    }
}

private struct TopStrip: View {
    var body: some View {
        HStack(spacing: 12) {
            Text("DAJET UI")
                .font(Typography.label)
                .tracking(1.2)
                .foregroundStyle(Palette.muted)
            Spacer()
            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .font(Typography.bodyMuted)
                    .foregroundStyle(Palette.muted)
                Text("Поиск по базе…")
                    .font(Typography.bodyMuted)
                    .foregroundStyle(Palette.faint)
            }
            .padding(.horizontal, 10)
            .frame(width: 240, height: 30, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: Radius.field)
                    .fill(Palette.wash)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Radius.field)
                    .strokeBorder(Palette.hairline, lineWidth: 1)
            )
        }
        .padding(.horizontal, 16)
        .frame(height: Metrics.strip)
    }
}

private struct GuideSection<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(Typography.label)
                .tracking(0.8)
                .foregroundStyle(Palette.muted)
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct PaletteGrid: View {
    private static let tokens: [(String, Color, String)] = [
        ("ground", Palette.ground, "#FFFFFF · #1C1C1C"),
        ("ink", Palette.ink, "#171717 · #EDEDED"),
        ("muted", Palette.muted, "#8C8C8C · #949494"),
        ("faint", Palette.faint, "#D4D4D4 · #525252"),
        ("hairline", Palette.hairline, "#E8E8E8 · #333333"),
        ("wash", Palette.wash, "#EFEFEF · #2D2D2D"),
        ("hover", Palette.hover, "#F6F6F6 · #262626"),
        ("accent", Palette.accent, "#C1542B · #E8AE8C"),
        ("onAccent", Palette.onAccent, "#FFFFFF · #0E0F11"),
        ("positive", Palette.positive, "#14803D · #4ADE80"),
        ("caution", Palette.caution, "#B5540A · #FABF24"),
    ]

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible())], spacing: 8) {
            ForEach(Self.tokens, id: \.0) { token in
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: Radius.control)
                        .fill(token.1)
                        .frame(width: 26, height: 26)
                        .overlay(
                            RoundedRectangle(cornerRadius: Radius.control)
                                .strokeBorder(Palette.hairline, lineWidth: 1)
                        )
                    Text(token.0)
                        .font(Typography.body)
                        .foregroundStyle(Palette.ink)
                    Spacer()
                    Text(token.2)
                        .font(Typography.mono)
                        .foregroundStyle(Palette.muted)
                }
                .padding(.vertical, 2)
            }
        }
    }
}

private struct TypeRows: View {
    private static let rows: [(String, Font, String)] = [
        ("display", Typography.display, "Заголовок панели"),
        ("body", Typography.body, "Основной текст интерфейса"),
        ("bodyMuted", Typography.bodyMuted, "Пояснение под контролем"),
        ("label", Typography.label, "СЕКЦИЯ · МЕТКА"),
        ("caption", Typography.caption, "Бейдж и мелкие подписи"),
        ("mono", Typography.mono, "03:45 · 128 kbps"),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Self.rows, id: \.0) { row in
                HStack(alignment: .firstTextBaseline) {
                    Text(row.2)
                        .font(row.1)
                        .foregroundStyle(Palette.ink)
                    Spacer()
                    Text(row.0)
                        .font(Typography.mono)
                        .foregroundStyle(Palette.muted)
                }
            }
        }
    }
}

private struct RadiusRow: View {
    private static let radii: [(String, CGFloat)] = [
        ("chip", Radius.chip),
        ("control", Radius.control),
        ("field", Radius.field),
        ("item", Radius.item),
        ("panel", Radius.panel),
    ]

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(Self.radii, id: \.0) { entry in
                VStack(spacing: 6) {
                    RoundedRectangle(cornerRadius: entry.1)
                        .fill(Palette.wash)
                        .frame(width: 56, height: 56)
                        .overlay(
                            RoundedRectangle(cornerRadius: entry.1)
                                .strokeBorder(Palette.hairline, lineWidth: 1)
                        )
                    Text("\(entry.0) \(Int(entry.1))")
                        .font(Typography.caption)
                        .foregroundStyle(Palette.muted)
                }
            }
        }
    }
}

private struct MotionDemo: View {
    @State private var settled = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                Button(settled ? "Вернуть" : "Поехали") {
                    withAnimation(Motion.settle) { settled.toggle() }
                }
                .buttonStyle(.plain)
                .font(Typography.body)
                .foregroundStyle(Palette.accent)
                Spacer()
                Circle()
                    .fill(Palette.accent)
                    .frame(width: 14, height: 14)
                    .offset(x: settled ? 120 : 0)
            }
            .frame(maxWidth: .infinity)
            Text("settle 0.30/0.86 · glide 0.34/0.82 · quick 0.14")
                .font(Typography.mono)
                .foregroundStyle(Palette.muted)
        }
    }
}
