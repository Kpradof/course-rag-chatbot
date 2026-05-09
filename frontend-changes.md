# Frontend Quality Tools — Changes

## What was added

### Tooling configuration

| File | Purpose |
|------|---------|
| `package.json` | npm project manifest with dev dependencies and quality scripts |
| `.prettierrc` | Prettier formatting rules (2-space indent, single quotes, LF line endings) |
| `eslint.config.js` | ESLint flat config — recommended rules + strict extras for browser JS |
| `scripts/check-frontend.sh` | Shell script that runs all quality checks in one command |

### npm scripts

| Script | What it does |
|--------|-------------|
| `npm run format` | Auto-format HTML, JS, and CSS with Prettier |
| `npm run format:check` | Check formatting without writing (CI-safe) |
| `npm run lint` | Lint `frontend/script.js` with ESLint |
| `npm run lint:fix` | Auto-fix ESLint violations |
| `npm run quality` | Run `format:check` + `lint` (full read-only check) |
| `npm run quality:fix` | Run `format` + `lint:fix` (auto-fix everything) |

## Formatting changes applied to frontend files

### `frontend/script.js`
- Indentation normalized from 4 spaces to 2 spaces throughout
- Single-statement `if` bodies wrapped in curly braces (ESLint `curly` rule)

### `frontend/style.css`
- Indentation normalized from 4 spaces to 2 spaces throughout
- Comma-separated selectors (`*, *::before, *::after`) split to one per line (Prettier standard)

### `frontend/index.html`
- No significant formatting changes (was already consistent)

## ESLint rules enforced

- `no-unused-vars` — warns on unused variables (args prefixed `_` are exempt)
- `no-console` — allows `log`, `warn`, `error`; flags other console calls
- `eqeqeq` — requires `===` over `==`
- `no-var` — disallows `var` (prefer `let`/`const`)
- `prefer-const` — requires `const` for variables that are never reassigned
- `curly` — requires braces around all control flow bodies

## How to run quality checks

```bash
# One-shot check (use in CI or before committing)
bash scripts/check-frontend.sh

# Or via npm
npm run quality

# Auto-fix all issues
npm run quality:fix
```
