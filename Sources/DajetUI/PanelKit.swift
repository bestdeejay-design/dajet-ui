import SwiftUI

// Куски, из которых собирается каждая панель линейки, — чтобы настройки,
// история, загрузки и списки читались как одна порода: одна плита, один
// заголовок с крестом, одни волосяные карточки с линейками между строк,
// одно поле поиска. Порт панельного набора браузера Dajet (`Plate.swift`)
// на токенах пакета.

/// Плита: скруглённая карточка с заголовком, крестом, содержимым панели
/// и — когда есть — футом под волосяной линией.
public struct Plate<Content: View, Foot: View>: View {
    let title: String
    var width: CGFloat = 560
    let close: () -> Void
    @ViewBuilder let content: () -> Content
    @ViewBuilder let foot: () -> Foot

    public init(
        _ title: String,
        width: CGFloat = 560,
        close: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder foot: @escaping () -> Foot
    ) {
        self.title = title
        self.width = width
        self.close = close
        self.content = content
        self.foot = foot
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                Text(title)
                    .font(Typography.display)
                    .foregroundStyle(Palette.ink)
                Spacer(minLength: 0)
                Door("xmark", help: "Готово   esc", act: close)
            }
            .padding(.horizontal, 22)
            .padding(.top, 18)
            .padding(.bottom, 14)

            content()
                .padding(.horizontal, 22)

            if Foot.self != EmptyView.self {
                Rectangle().fill(Palette.hairline).frame(height: 1)
                    .padding(.top, 18)
                foot()
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
            } else {
                Color.clear.frame(height: 20)
            }
        }
        .frame(width: width, alignment: .leading)
        .background(Palette.ground, in: RoundedRectangle(cornerRadius: Radius.panel, style: .continuous))
        .clipShape(RoundedRectangle(cornerRadius: Radius.panel, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: Radius.panel, style: .continuous)
                .strokeBorder(Palette.hairline, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.16), radius: 34, y: 12)
    }
}

extension Plate where Foot == EmptyView {
    public init(
        _ title: String,
        width: CGFloat = 560,
        close: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(title, width: width, close: close, content: content, foot: { EmptyView() })
    }
}

/// Группа строк в одной волосяной коробке.
public struct Card<Content: View>: View {
    @ViewBuilder let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) { content() }
            .background(Palette.ground)
            .clipShape(RoundedRectangle(cornerRadius: Radius.item, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.item, style: .continuous)
                    .strokeBorder(Palette.hairline, lineWidth: 1)
            )
    }
}

/// Волосковая линия между строками карточки, с отступом как у текста.
public struct Rule: View {
    var inset: CGFloat = 14

    public init(inset: CGFloat = 14) {
        self.inset = inset
    }

    public var body: some View {
        Rectangle().fill(Palette.hairline).frame(height: 1).padding(.leading, inset)
    }
}

/// Одна настройка или действие: слева — что это, справа — контрол.
public struct Line<Control: View>: View {
    let title: String
    let detail: String?
    @ViewBuilder let control: () -> Control

    public init(
        _ title: String,
        _ detail: String? = nil,
        @ViewBuilder control: @escaping () -> Control
    ) {
        self.title = title
        self.detail = detail
        self.control = control
    }

    public var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(Typography.body)
                    .foregroundStyle(Palette.ink)
                if let detail {
                    Text(detail)
                        .font(Typography.control)
                        .foregroundStyle(Palette.muted)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer(minLength: 8)
            control()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
    }
}

/// Малый заголовок над карточкой — когда в панели их несколько.
public struct Caption: View {
    let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(Typography.control.weight(.medium))
            .foregroundStyle(Palette.muted)
            .padding(.leading, 2)
    }
}

/// Что панель говорит, когда список пуст.
public struct Nothing: View {
    let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .font(Typography.body)
            .foregroundStyle(Palette.muted)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 14)
            .padding(.vertical, 18)
    }
}

/// Поле для сужения списка: подложка, стекло, каретка. Порт `Hunt`
/// браузера Dajet (`Plate.swift`).
public struct Hunt: View {
    @Binding var text: String
    var prompt = "Поиск"
    var focus: FocusState<Bool>.Binding

    public init(
        text: Binding<String>,
        prompt: String = "Поиск",
        focus: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.prompt = prompt
        self.focus = focus
    }

    public var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(Typography.label)
                .foregroundStyle(Palette.muted)
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(prompt).foregroundStyle(Palette.muted.opacity(0.7))
                }
                TextField("", text: $text)
                    .textFieldStyle(.plain)
                    .foregroundStyle(Palette.ink)
                    .focused(focus)
            }
            .font(Typography.body)
            if !text.isEmpty {
                Button { text = "" } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 11))
                        .foregroundStyle(Palette.faint)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Palette.wash, in: RoundedRectangle(cornerRadius: Radius.field, style: .continuous))
    }
}
