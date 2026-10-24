import SwiftUI

/// Вкл или выкл — в ink, а не в системный синий. Порт переключателя
/// браузера Dajet (`Settings.swift`) на токенах пакета. Имя `InkSwitch`,
/// чтобы не сталкиваться с `SwiftUI.Switch` у потребителей пакета.
/// Голосoверу тумблер представляется кнопкой с двумя состояниями; строки
/// состояний (`valueOn`/`valueOff`) прикладывает потребитель — пакет своих
/// слов не держит. Лейбл тоже ставит потребитель
/// (`.accessibilityLabel("…")`) — сам тумблер нем.
public struct InkSwitch: View {
    @Binding var on: Bool
    var valueOn: String
    var valueOff: String

    public init(
        on: Binding<Bool>,
        valueOn: String = "On",
        valueOff: String = "Off"
    ) {
        self._on = on
        self.valueOn = valueOn
        self.valueOff = valueOff
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
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isButton)
            .accessibilityValue(on ? valueOn : valueOff)
            .accessibilityAdjustableAction { direction in
                guard case .increment = direction else {
                    withAnimation(Motion.settle) { on = false }
                    return
                }
                withAnimation(Motion.settle) { on = true }
            }
    }
}
