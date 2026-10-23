import SwiftUI

/// Маленький квадрат под один символ; подсвечен, когда открыто то, куда он ведёт.
/// Порт «двери» браузера Dajet (`Side.swift`) на токенах пакета.
public struct Door: View {
    let icon: String
    var on = false
    var help = ""
    let act: () -> Void

    @State private var hovering = false

    public init(
        _ icon: String,
        on: Bool = false,
        help: String = "",
        act: @escaping () -> Void
    ) {
        self.icon = icon
        self.on = on
        self.help = help
        self.act = act
    }

    public var body: some View {
        Button(action: act) {
            Image(systemName: icon)
                .font(Typography.label)
                .foregroundStyle(on ? Palette.ink : (hovering ? Palette.ink.opacity(0.7) : Palette.muted))
                .frame(width: Metrics.door, height: Metrics.door)
                .background(
                    RoundedRectangle(cornerRadius: Radius.control, style: .continuous)
                        .fill(on ? Palette.wash : (hovering ? Palette.hover : .clear))
                )
                .contentShape(RoundedRectangle(cornerRadius: Radius.control, style: .continuous))
        }
        .buttonStyle(.plain)
        .onHover { hovering = $0 }
        .help(help)
        .animation(Motion.quick, value: hovering)
        .animation(Motion.quick, value: on)
    }
}
