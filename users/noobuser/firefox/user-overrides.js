// https://arkenfox.github.io/gui

user_pref("browser.startup.page", 3); // 0102
user_pref("browser.startup.homepage", "about:home"); // 0103
user_pref("browser.newtabpage.enabled", true); // 0104

user_pref("intl.accept_languages", "ja, en-US, en"); // 0210
user_pref("javascript.use_us_english_locale", false); // 0211

// My own risk...
user_pref("browser.safebrowsing.malware.enabled", false); // 0401
user_pref("browser.safebrowsing.phishing.enabled", false); // 0401
user_pref("browser.safebrowsing.downloads.enabled", false); // 0402

user_pref("keyword.enabled", true); // 0801
user_pref("browser.search.suggest.enabled", true); // 0804
user_pref("browser.urlbar.suggest.searches", true); // 0804

user_pref("layout.css.font-visibility.private", 1); // 1402
user_pref("layout.css.font-visibility.standard", 1); // 1402
user_pref("layout.css.font-visibility.trackingprotection", 1); // 1402

user_pref("privacy.sanitize.sanitizeOnShutdown", false); // 2810

user_pref("privacy.resistFingerprinting.letterboxing", false); // 4504
