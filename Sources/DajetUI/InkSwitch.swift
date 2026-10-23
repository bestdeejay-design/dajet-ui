import SwiftUI

/// Вкл или выкл — в ink, а не в системный синий. Порт переключателя
/// браузера Dajet (`Settings.swift`) на токенах пакета. Имя `InkSwitch`,
/// чтобы не сталкиваться с `SwiftUI.Switch` у потребителей пакета.
public struct InkSwitch: View {
    @Binding var on: Bool

    public init(on: Binding<Bool>) {
        self._on = on
    }

    public var body: some View {
        Capsule()
            .fill(on ? Palette.ink : Palette.faint)
            .frame(width: 30, height: 18)
            .overlay(alignment: on ? .trailing : .leading) {
                Circle()
                    .fill(Palette.ground)
                    .shadow(color: .black.opacity(0.18), radius: 1.5, y: 1)
                    .padding(2)
            }
            .contentShape(Capsule())
            .onTapGesture { withAnimation(Motion.settle) { on.toggle() } }
            .animation(Motion.settle, value: on)
    }
}
