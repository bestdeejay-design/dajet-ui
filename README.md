# DajetUI

Единая нативная UI-база приложений линейки Dajet: браузера, плеера и редактора.
Один пакет — один стиль. Референс дизайна — интерфейс браузера Dajet.

## Принципы

1. **Система-first.** Всё, что даёт система (контролы, тулбары, Settings-сцены,
   материалы Liquid Glass), — берём системой. Пакет не повторяет систему, а
   встраивается в неё.
2. **Минимум видимых компонентов.** Кастомное — только то, чего нет в системе.
3. **Один источник чисел.** Палитра, типографика, скругления, отступы, движение —
   токены пакета, а не магические числа в приложениях.
4. **Терракота — единственный цветовой акцент** (`#C1542B` light / `#E8AE8C`
   dark, из brand-пакета). Дефолт залитой пилюли — ink, терракота — параметром.
   Всё остальное — ахроматическая шкала браузера.

## Подключение

Локальная path-зависимость: пакет должен лежать рядом, в `../ui` от репозитория
приложения (`apps/dajet/ui`). Свежий клон одного приложения без `dajet-ui` не
соберётся — клонируйте оба рядом, как в `apps/`:

```swift
dependencies: [.package(path: "../ui")]
// и в таргете: .product(name: "DajetUI", package: "ui")
```

## Состав

**Токены** (`Sources/DajetUI/`):

| Токен | Значения | Файл |
| --- | --- | --- |
| `Palette` (+ `Palette.NS` для AppKit) | ground, ink, muted, faint, hairline, wash, hover, pinLive, resting, accent, onAccent, positive, caution — пары light/dark, 13/13 бит-в-бит с браузером | `Palette.swift` |
| `Typography` | display 17 · body 13 · bodyMuted 12 · control 11.5 · label 11 · caption 10 · mono 11 | `Typography.swift` |
| `Radius` | chip 4 · control 8 · field 10 · item 11 · panel 16 | `Metrics.swift` |
| `Spacing` | 2…16 шагом от xxs до xxxl | `Metrics.swift` |
| `Metrics` | strip 52 · door/row 26 · side 232 (176–440) · tabWidth 186 · tabMinWidth 36 · tabGap 2 · lights 100 · helm 90 · bare 34 · fieldWidth 560 | `Metrics.swift` |
| `Motion` | glide 0.34/0.82 · settle 0.30/0.86 · quick 0.14 — вычисляемые `Animation?`, nil при «Уменьшить движение»; `Motion.reduced` публичен | `Motion.swift` |
| `Look` | system/light/dark, ключ UserDefaults `"look"`, `apply()`/`remember`/`current` | `Look.swift` |

**Компоненты-минимум**: `Door`, `InkSwitch` (имя обходит `SwiftUI.Switch`),
`Segmented`, `Pill` (`tint`/`fill` разведены), `Quick`, `Steps`, панельный набор
`Plate`/`Card`/`Rule`/`Line`/`Caption`/`Nothing`/`Hunt` (`Pill.swift`,
`PanelKit.swift`).

**Рецепты** (`Look.swift`, `WindowRecipe.swift`, `SettingsRecipe.swift`):
`.dajetPlateWindow` / `.dajetToolbarWindow`, Settings-сцена `DajetSettings`,
`LookPicker`. Потребляются пока только демо — adoption приложениями по плану.

## Демо (живой гайд)

```bash
swift run DajetUIDemo
```

Окно в стиле линейки показывает токены и компоненты; ⌘, — настройки; тема
переключается секцией «Внешний вид».

## Дорожная карта

- Этап 1 — токены · Этап 2 — компоненты · Этап 3 — рецепты (✅ в main)
- Дальше: рецепт материалов/стекла **по паттернам Apple** (системное стекло в
  системном хроме, NSGlassEffectView для кастомного UI — самодельное не переносим),
  перевод 226 хардкод-размеров браузера на `Typography`, Theme/Appearance → Look

Доска проекта: https://github.com/users/bestdeejay-design/projects/4
Аудит SZ: https://github.com/bestdeejay-design/dajet-ui/issues/1
