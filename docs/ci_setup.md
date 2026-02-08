# Cursor Plan: Implement GitHub Actions Deploy (Flutter Web → GitHub Pages)

## Goal

Automatically build and deploy the Flutter **web** version to **GitHub Pages** whenever we push to the `main` branch.

Output:

- A workflow file at: `.github/workflows/deploy-gh-pages.yml`
- A `gh-pages` branch created/managed by the action
- Live site at: `https://<github-username>.github.io/<repo-name>/`

---

## Preconditions

1. Repo exists on GitHub and our code is pushed to `main`.
2. Flutter project builds locally.
3. Flutter web is enabled.

---

## Step 1 — Ensure Flutter Web is enabled

In project root:

- Check if `web/` folder exists
  - If not, run:
    - `flutter config --enable-web`
    - `flutter create .`

Acceptance:

- `web/` directory exists
- `flutter build web` works locally

---

## Step 2 — Add GitHub Actions workflow

Create file:

- `.github/workflows/deploy-gh-pages.yml`

Paste this workflow (update base-href rule stays dynamic by repo name):

```yaml
name: Deploy Flutter Web to GitHub Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: write

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Install deps
        run: flutter pub get

      - name: Build web
        run: flutter build web --release --base-href "/${{ github.event.repository.name }}/"

      - name: Deploy to gh-pages
        uses: peaceiris/actions-gh-pages@v4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: build/web
```
