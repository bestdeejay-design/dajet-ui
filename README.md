# DajetUI

Единая нативная UI-база приложений линейки Dajet: браузера, плеера и редактора.
Один пакет — один стиль. Референс дизайна — интерфейс браузера Dajet.

## Принципы

1. **Система-first.** Всё, что даёт система (контролы, тулбары, Settings-сцены,
   материалы Liquid Glass), — берём системой. Пакет не повторяет систему, а
   встраивается в неё.
2. **Минимум видимых компонентов.** Кастомное — только то, чего нет в системе:
   `Door`, `Switch`, `Segmented`, `Pill`, `Plate/Card/Line`, `Hunt`.
3. **Один источник чисел.** Палитра, типографика, скругления, отступы, движение —
   токены пакета, а не магические числа в приложениях.
4. **Терракота — единственный цветовой акцент** (`#C1542B` light / `#E8AE8C`
   dark, из brand-пакета). Всё остальное — ахроматическая шкала браузера.

## Состав (этап 1 — токены)

| Токен | Что | Где |
| --- | --- | --- |
| `Palette` | парные цвета light/dark: ground, ink, muted, faint, hairline, wash, hover, accent, onAccent, positive, caution | `Sources/DajetUI/Palette.swift` |
| `Typography` | шкала: display 17 · body 13 · bodyMuted 12 · label 11 · caption 10 · mono 11 | `Sources/DajetUI/Typography.swift` |
| `Radius` | chip 4 · control 8 · field 10 · item 12 · panel 16 | `Sources/DajetUI/Metrics.swift` |
| `Spacing` | 2…16 шагом от xxs до xxxl | `Sources/DajetUI/Metrics.swift` |
| `Metrics` | хром линейки: strip 52, door/row 26, side 232 (176–440), tab 186 | `Sources/DajetUI/Metrics.swift` |
| `Motion` | пружины glide 0.34/0.82, settle 0.30/0.86, quick 0.14 | `Sources/DajetUI/Motion.swift` |

## Демо (живой гайд)

```bash
swift run DajetUIDemo
```

Окно в стиле линейки показывает все токены. Тёмная тема подхватывается
системой автоматически.

## Дорожная карта

- Этап 1 — токены (этот коммит)
- Этап 2 — компоненты-минимум: Door, Switch, Segmented, Pill, Plate/Card/Line, Hunt
- Этап 3 — рецепты: окно + системный тулбар (uniform, macOS 27), Settings-сцена, appearance
- Этап 4+ — миграции: плеер → редактор → браузер

Доска проекта: https://github.com/users/bestdeejay-design/projects/4
