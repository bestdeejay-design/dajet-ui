import SwiftUI

/// Ряд выборов на серой подложке, один из них поднят белым. Белое
/// переезжает к выбранному, а не появляется там. Порт сегмента браузера
/// Dajet (`Settings.swift`) на токенах пакета.
public struct Segmented<Option: Hashable>: View {
    let options: [(Option, String)]
    @Binding var selection: Option
    /// True, когда контролу отдана вся ширина: выборы делят её поровну,
    /// а не берут по длине слова.
    var wide = false

    @Namespace private var slide

    public init(
        _ options: [(Option, String)],
        selection: Binding<Option>,
        wide: Bool = false
    ) {
        self.options = options
        self._selection = selection
        self.wide = wide
    }

    public var body: some View {
        HStack(spacing: 2) {
            ForEach(options, id: \.0) { option, title in
                Text(title)
                    .font(.system(size: 11.5, weight: option == selection ? .medium : .regular))
                    .foregroundStyle(option == selection ? Palette.ink : Palette.muted)
                    .lineLimit(1)
                    .fixedSize(horizontal: !wide, vertical: false)
                    .frame(maxWidth: wide ? .infinity : nil)
                    .padding(.horizontal, wide ? 4 : 10)
                    .padding(.vertical, 5)
                    .background {
                        if option == selection {
                            RoundedRectangle(cornerRadius: 7, style: .continuous)
                                .fill(Palette.ground)
                                .shadow(color: .black.opacity(0.08), radius: 3, y: 1)
                                .matchedGeometryEffect(id: "chosen", in: slide)
                        }
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    .onTapGesture {
                        withAnimation(Motion.settle) { selection = option }
                    }
            }
        }
        .padding(2)
        .background(Palette.wash, in: RoundedRectangle(cornerRadius: 9, style: .continuous))
        .animation(Motion.settle, value: selection)
    }
}
