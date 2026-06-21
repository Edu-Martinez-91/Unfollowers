<div align="center">

<img src="docs/logo.svg" alt="Unfollowers" width="120" height="120">

# IG Unfollowers

**Find out who doesn't follow you back on Instagram — a single HTML file, no frameworks, no build, no npm, no server.**

[![Made with vanilla JS](https://img.shields.io/badge/Vanilla-JS-f7df1e?logo=javascript&logoColor=black)](https://developer.mozilla.org/docs/Web/JavaScript)
[![Deploy: Netlify](https://img.shields.io/badge/Deploy-Netlify-00c7b7?logo=netlify&logoColor=white)](https://www.netlify.com)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](#license)
[![Single file](https://img.shields.io/badge/Single--file-HTML-orange)]()
[![Privacy: 100% local](https://img.shields.io/badge/Privacy-100%25%20local-success)]()

*Open `index.html` in any browser — no install, no account, no data ever leaves your device.*

🇬🇧 **English** · [🇪🇸 Español](README.md)

</div>

---

## What is this?

**Unfollowers** compares the two JSON files Instagram gives you when you export your activity (`following.json` and `followers_*.json`) and computes, entirely inside your own browser, who you follow that doesn't follow you back. No username or password required, no OAuth, no bot scraping that could get your account flagged — just the files Instagram already hands you officially.

The whole app fits in a single `index.html`. No backend, no build step, no npm dependencies. Processing is 100% client-side, and your state (accounts marked as VIP, "already unfollowed", or "unavailable") is saved in your browser's `localStorage`.

---

## Why Unfollowers?

There are dozens of third-party apps and "services" that promise to tell you who unfollowed you on Instagram. Most of them ask you to log in with your Instagram credentials or grant OAuth permissions to a third-party app — which violates Instagram's terms of service and risks getting your account flagged, on top of exposing your data to someone else's server.

1. **Zero risk to your account.** You never log in anywhere. You only use the official data export Instagram provides from its own settings — the same mechanism you'd use for a backup or a GDPR data request.
2. **Zero data leakage.** All the computation — JSON parsing, list comparison, persisting your tags — happens in the browser. No file is ever uploaded to any server; there's no backend to receive it.
3. **Actual triage workflow, not just a cold list.** The list of non-followers can be tagged account by account as **VIP** (people or brands you follow on purpose even if they don't follow back, e.g. media or celebrities), **unfollowed** (accounts you've already manually unfollowed in the Instagram app), or **unavailable** (account blocked, deleted, or suspended). These tags persist across sessions and survive reloading newer exports.
4. **Handles Instagram's real export format, split across multiple files.** Instagram splits your followers into `followers_1.json`, `followers_2.json`, etc. when you have a lot of them. The app lets you select all of them at once and merges them automatically, deduplicating by username.
5. **Fast auditing with sort and search.** A sortable list (most recent or oldest follows first) with a live search box, so you can review hundreds of accounts without losing track.

---

## How to use it

1. In Instagram: **Settings → Your activity → Download your information**.
2. Choose **JSON** format and request the download (Instagram emails you when it's ready, usually within minutes).
3. Unzip the file you receive and go into `connections/followers_and_following/`.
4. Upload `following.json` in the first box, and every `followers_X.json` file that exists in the second one (you can select them all at once).
5. The app instantly computes who you follow that doesn't follow you back.

---

## Features

- **Instant comparison** between `following.json` and one or more `followers_*.json` files, deduplicating usernames across files.
- **Drag & drop or file picker**, with load detection and a warning when Instagram split your followers into multiple files.
- **Three manual tags per account** — VIP / unfollowed / unavailable — each with its own counter and `localStorage` persistence.
- **Stale-tag auto-cleanup.** If you reload a newer export and an account is no longer a non-follower (because they started following you, or you unfollowed them), its tag is automatically dropped so it doesn't pile up.
- **Live search** by username across all four sections (normal, VIP, unfollowed, unavailable).
- **Sort by follow date**, ascending or descending, with a single button.
- **Collapsible accordions** per section, with live count badges.
- **Direct link to each profile** straight from the card (opens Instagram in a new tab).
- **Automatic light/dark mode** based on system preference (`prefers-color-scheme`).
- **Purge buttons** to clear saved VIPs, unfollowed, or unavailable tags if you want a clean slate.
- **Confirmation toast** on every action, no intrusive dialogs.

---

## Stack

| Layer | Technology |
|------|------------|
| **Frontend** | A single HTML file with inline `<style>` and `<script>`. Vanilla JS, no frameworks or external libraries. |
| **Persistence** | Browser `localStorage` — no database, no backend, no user accounts. |
| **Hosting** | [Netlify](https://www.netlify.com), `index.html` at the root. Continuous deployment from `main`. |
| **Typography** | Space Mono (UI) + Syne (headings), via Google Fonts. |
| **Privacy** | Zero network calls except loading fonts. Instagram's JSON files are processed entirely in the browser and never leave the device. |

---

## Privacy

This tool has no backend. No server ever receives your `following.json` or `followers_*.json` files: the browser's `FileReader` API reads them directly in memory, and the only persistent storage is your own browser's `localStorage`, which never leaves your device. You can verify this by opening dev tools → the Network tab while using the app: you won't find a single outgoing request carrying your data.

---

## Local development

No installation required. Just open `index.html` directly in your browser, or serve it with any static file server:

```bash
python3 -m http.server 8000
# or
npx serve .
```

---

## License

Distributed under the **GPLv3** license. See [LICENSE](LICENSE) for details.
