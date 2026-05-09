# UI Feature — Dark/Light Theme Toggle

## What was added

### New files

| File | Purpose |
|------|---------|
| `frontend/index.html` | Chat UI markup including the theme toggle button |
| `frontend/style.css` | All styles, CSS variables for both themes, toggle button CSS |
| `frontend/script.js` | Chat logic plus theme management functions |

---

## Feature: Dark / Light Theme Toggle

### Toggle button (`frontend/index.html`)

A `<button id="themeToggle">` is placed as a direct child of `<body>`, outside the `.container`, so it floats over all content. It contains two inline SVG icons:

- `.icon-sun` — shown when the page is in **dark mode** (click to switch to light)
- `.icon-moon` — shown when the page is in **light mode** (click to switch to dark)

The button has `aria-label="Toggle light/dark theme"` and both SVGs carry `aria-hidden="true"` so screen readers announce only the label.

### CSS variables (`frontend/style.css`)

Two theme layers:

```css
/* Dark (default) */
:root {
  --background: #0f172a;
  --surface: #1e293b;
  --text-primary: #f1f5f9;
  ...
}

/* Light override — applied when <html data-theme="light"> */
[data-theme='light'] {
  --background: #f8fafc;
  --surface: #ffffff;
  --text-primary: #0f172a;
  ...
}
```

Every component already uses these variables, so swapping the attribute instantly recolors the whole UI.

### Transition animation (`frontend/style.css`)

Key structural elements share a transition rule so the swap is smooth (0.3 s):

```css
body,
.sidebar,
.chat-main,
/* … */
#chatInput,
#sendButton {
  transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease;
}
```

The toggle button icons themselves cross-fade and spin using `opacity` + `transform` transitions (0.25 s).

### JavaScript (`frontend/script.js`)

Two functions handle theme state:

```js
function applyTheme(theme) {
  if (theme === 'light') {
    document.documentElement.setAttribute('data-theme', 'light');
  } else {
    document.documentElement.removeAttribute('data-theme');
  }
  localStorage.setItem('theme', theme);
}

function toggleTheme() {
  const current = document.documentElement.getAttribute('data-theme');
  applyTheme(current === 'light' ? 'dark' : 'light');
}
```

On `DOMContentLoaded`, the saved preference is read from `localStorage` (defaulting to `'dark'`) and applied before the first paint, preventing a flash of the wrong theme.

### Accessibility

- Button is keyboard-focusable (standard `<button>` element).
- Focus ring: `box-shadow: 0 0 0 3px var(--focus-ring)` on `:focus`.
- Ring suppressed on mouse click via `:focus:not(:focus-visible)` to avoid visual noise.
- `aria-label` describes the action; SVG icons are hidden from the accessibility tree.
- Color contrast meets WCAG AA in both themes (dark text on light background, light text on dark background).
