import SwiftUI

/// Маленькая капсула, делающая одно дело. По умолчанию контурная на фоне
/// окна; залита акцентом, когда это то, ради чего пришли. Порт пилюли
/// браузера Dajet (`Settings.swift`) на токенах пакета.
public struct Pill: View {
    let title: String
    var filled = false
    /// Цвет текста незалитой пилюли.
    var tint: Color = Palette.ink
    /// Цвет заливки залитой пилюли; текст на ней — `onAccent`.
    var fill: Color = Palette.accent
    let action: () -> Void

    @State private var hovering = false

    public init(
        _ title: String,
        filled: Bool = false,
        tint: Color = Palette.ink,
        fill: Color = Palette.accent,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.filled = filled
        self.tint = tint
        self.fill = fill
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(Typography.control)
                .foregroundStyle(filled ? Palette.onAccent : tint)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(filled ? fill : (hovering ? Palette.hover : Palette.ground), in: Capsule())
                .overlay(Capsule().strokeBorder(filled ? .clear : Palette.hairline, lineWidth: 1))
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .onHover { hovering = $0 }
        .animation(Motion.quick, value: hovering)
    }
}

/// Малое текстовое действие внутри строки — «Показать», «Копировать»,
/// «Убрать». Порт `Quick` браузера Dajet (`Plate.swift`).
public struct Quick: View {
    let title: String
    var tint: Color = Palette.ink
    let act: () -> Void

    public init(_ title: String, tint: Color = Palette.ink, act: @escaping () -> Void) {
        self.title = title
        self.tint = tint
        self.act = act
    }

    public var body: some View {
        Button(action: act) {
            Text(title)
                .font(Typography.control)
                .foregroundStyle(tint)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Palette.wash, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

/// Значение, двигаемый по одному стопу: минус и плюс по бокам, в той же
/// контурной капсуле, что и пилюля. Нажатие на само значение возвращает
/// его домой. Порт `Steps` браузера Dajet (`Settings.swift`).
public struct Steps: View {
    let stops: [Double]
    @Binding var value: Double
    let home: Double
    let label: (Double) -> String

    /// Ближайший стоп в каждую сторону — значение между стопами всё равно
    /// сдвигается к круглому.
    private var below: Double? { stops.last { $0 < value - 0.001 } }
    private var above: Double? { stops.first { $0 > value + 0.001 } }

    public init(
        stops: [Double],
        value: Binding<Double>,
        home: Double,
        label: @escaping (Double) -> String
    ) {
        self.stops = stops
        self._value = value
        self.home = home
        self.label = label
    }

    public var body: some View {
        HStack(spacing: 0) {
            Step(icon: "minus", to: below) { value = $0 }
            Button { value = home } label: {
                Text(label(value))
                    .font(Typography.control)
                    .monospacedDigit()
                    .foregroundStyle(Palette.ink)
                    .frame(minWidth: 36)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .help("Back to \(label(home))")
            Step(icon: "plus", to: above) { value = $0 }
        }
        .padding(.horizontal, 2)
        .frame(height: 24)
        .background(Palette.ground, in: Capsule())
        .overlay(Capsule().strokeBorder(Palette.hairline, lineWidth: 1))
    }

    private struct Step: View {
        let icon: String
        let to: Double?
        let act: (Double) -> Void
        @State private var hovering = false

        var body: some View {
            Button { if let to { act(to) } } label: {
                Image(systemName: icon)
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundStyle(to == nil ? Palette.faint : Palette.ink)
                    .frame(width: 20, height: 20)
                    .background(hovering && to != nil ? Palette.hover : .clear, in: Circle())
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .disabled(to == nil)
            .onHover { hovering = $0 }
            .animation(Motion.quick, value: hovering)
        }
    }
}
