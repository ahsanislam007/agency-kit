# Feature docs templates

Copy and fill. Keep voice matching the existing guide (short client/operator tone when an admin-guide already exists).

## Feature slug

Lowercase kebab from the feature name: `cod-fulfil`, `homepage-hero`, `wishlist`.

## User guide section

```markdown
## N. <Feature title>

<One sentence: what the operator can do and why.>

**Where:** <Admin URL / storefront path / CMS>  
**Who:** <role>

### Steps

1. Open **<URL or menu path>**.
2. …
3. …

![<Step 1 caption>](assets/<feature-slug>/01-<action>.png)

![<Step 2 caption>](assets/<feature-slug>/02-<action>.png)

### Tips

- <Optional short tip>

### Troubleshooting

- **Symptom** → fix
```

## README Docs row

```markdown
| [docs/<guide>.md](docs/<guide>.md#<heading-anchor>) | <Feature>: how to <verb> |
```

Or Features bullet:

```markdown
- **<Feature>** — <one line>. See [docs/<guide>.md](docs/<guide>.md#<anchor>).
```

## Screenshot checklist

| File | Shows |
|------|--------|
| `01-entry.png` | Where the feature starts (nav / menu / URL) |
| `02-main.png` | Primary form or screen |
| `03-result.png` | Success / published / saved state |

Add more only if steps are ambiguous without them.

## Packet line

```markdown
- FeatureDocs: yes | guide=docs/admin-guide.md | screenshots=docs/assets/<feature-slug>/ | status=done|todo-screenshots
```

Use `status=todo-screenshots` when the app was not runnable; keep step text accurate anyway.

## Typical paths

| Artifact | Path |
|----------|------|
| README | `README.md` → Docs table |
| User guide | `docs/admin-guide.md` |
| Screenshots | `docs/assets/<feature-slug>/` |
| Ops / commerce deep dives | `docs/ops.md`, `docs/commerce.md` — only if the feature is ops/payment specific; still add a short pointer in admin-guide when the client must use it |
