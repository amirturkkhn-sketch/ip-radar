# IP Radar (Kotlin) — اسکنر IP / SOCKS5 / HTTP

## English
1. Create a **private** GitHub repo (the signing keystore is bundled).
2. Upload ALL extracted files (keep the `.github` folder). Push to `main`.
3. Open **Actions → Build APK** (or press *Run workflow*). Wait ~5 min.
4. Download the APK from the run's **Artifacts**, or from **Releases**.
Universal APK, Android 5.0+. No sound. UI language: English / فارسی.

## فارسی
۱. یک مخزن **خصوصی** در گیت‌هاب بسازید.
۲. همه فایل‌ها را آپلود کنید (پوشه `.github` حتماً باشد) روی شاخه `main`.
۳. از تب **Actions** گزینه **Build APK** را اجرا کنید (حدود ۵ دقیقه).
۴. فایل APK را از **Artifacts** یا **Releases** دانلود کنید.

---
## Install warning / تحذیر نصب
- **EN:** The APK is signed (v1+v2+v3) and is not sideloaded from a store, so Google Play Protect may show *"unknown developer"*. Tap **More details → Install anyway**. This cannot be removed from inside an app. Each build has a higher version number, so new builds install over old ones.
- **Better key (recommended):** make your own key once and add 4 repo **Secrets** (Settings → Secrets and variables → Actions): `KEYSTORE_BASE64` (base64 of your .jks), `KEYSTORE_PASSWORD`, `KEY_ALIAS`, `KEY_PASSWORD`. The workflow uses them automatically; otherwise the bundled key is used (keep the repo private).
- **FA:** برنامه امضا شده است ولی از فروشگاه نصب نمی‌شود؛ ممکن است Play Protect هشدار «توسعه‌دهنده ناشناس» بدهد: **جزئیات بیشتر ← به هر حال نصب کن**. هر بیلد شماره‌ی نسخه‌ی بالاتری دارد، پس روی نسخه‌ی قبلی نصب می‌شود. برای امنیت بیشتر کلید خودتان را در Secrets بگذارید (۴ مقدار بالا).

## IP ranges / رنج آی‌پی
Source tab **IP ranges**: one per line — `104.16.0.0/20`, `172.64.0.1-172.64.0.200`, `1.1.1.1`. «Cloudflare ranges» fills the official list. A random sample of N addresses is tested for real.
