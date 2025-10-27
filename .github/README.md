# Framer CI/CD Documentation

This directory contains comprehensive documentation for setting up and using CI/CD pipelines with Fastlane for the Framer Flutter application.

## 📚 Documentation Index

### Getting Started

1. **[Quick Start](QUICK_START.md)** - Fast setup guide (start here!)
2. **[Fastlane Quick Start - Android](FASTLANE_QUICKSTART.md)** - Quick reference for Android Fastlane
3. **[Fastlane Quick Start - iOS](IOS_FASTLANE_QUICKSTART.md)** - Quick reference for iOS Fastlane

### Setup Guides

3. **[CI/CD Setup Guide](CICD_SETUP.md)** - Complete CI/CD configuration (Android & iOS)
4. **[Google Play Console Setup](GOOGLE_PLAY_CONSOLE_SETUP.md)** ⭐ - 2025 updated setup instructions (Android)
5. **[iOS Setup Guide](IOS_SETUP.md)** ⭐ - Complete iOS setup with TestFlight & App Store
6. **[Android Signing Setup](ANDROID_SIGNING_SETUP.md)** - Keystore configuration
7. **[Keys Generation Guide](KEYS_GENERATION_GUIDE.md)** - Generate signing keys

### Reference

8. **[Migration Guide](MIGRATION_TO_FASTLANE.md)** - What changed with Fastlane
9. **[Secrets Template](SECRETS_TEMPLATE.md)** - GitHub secrets reference
10. **[Pull Request Template](PULL_REQUEST_TEMPLATE.md)** - PR guidelines

## 🚀 Quick Links by Task

### I want to...

#### Set up CI/CD for the first time

**Android:**
→ Read: [Quick Start](QUICK_START.md) → [Google Play Console Setup](GOOGLE_PLAY_CONSOLE_SETUP.md) → [CI/CD Setup](CICD_SETUP.md)

**iOS:**
→ Read: [iOS Setup Guide](IOS_SETUP.md) → [CI/CD Setup](CICD_SETUP.md)

#### Deploy a new version

**Android:**
→ Read: [Fastlane Quick Start - Android](FASTLANE_QUICKSTART.md)

```bash
# Update version in pubspec.yaml, then:
git tag v1.0.0
git push origin v1.0.0  # Deploys to Play Store (production)
```

**iOS:**
→ Read: [Fastlane Quick Start - iOS](IOS_FASTLANE_QUICKSTART.md)

```bash
# Update version in pubspec.yaml, then:
git tag v1.0.0
git push origin v1.0.0  # Deploys to TestFlight
```

#### Test deployment locally

**Android:**
```bash
bundle install
cd android
export PLAY_STORE_JSON_KEY='<your-json-key>'
bundle exec fastlane release_internal
```

**iOS:**
```bash
bundle install
cd ios
export APP_STORE_CONNECT_API_KEY_PATH='/path/to/AuthKey.p8'
bundle exec fastlane release_testflight
```

#### Deploy to internal/beta track

**Android:**
→ GitHub → Actions → Android Release → Run workflow → Choose track (internal/beta/production)

**iOS:**
→ GitHub → Actions → iOS Release → Run workflow → Choose distribution (testflight/testflight_external/appstore)

#### Troubleshoot deployment issues
→ Read: [CI/CD Setup - Troubleshooting](CICD_SETUP.md#troubleshooting)
→ Read: [Google Play Console Setup - Troubleshooting](GOOGLE_PLAY_CONSOLE_SETUP.md#troubleshooting)

#### Understand what changed with Fastlane
→ Read: [Migration Guide](MIGRATION_TO_FASTLANE.md)

## 🏗️ Architecture Overview

### Android Workflow

```
┌─────────────────────────────────────────────────┐
│  Developer                                       │
│  • Updates code                                  │
│  • Creates git tag (v1.0.0)                     │
│  • Pushes to GitHub                             │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  GitHub Actions Workflow                         │
│  .github/workflows/android-release.yml          │
│                                                  │
│  1. Setup environment (Ruby, Java, Flutter)     │
│  2. Install Fastlane via Bundler                │
│  3. Decode keystore from secrets                │
│  4. Build app bundle with Flutter               │
│  5. Run Fastlane deployment                     │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  Fastlane                                        │
│  android/fastlane/Fastfile                      │
│                                                  │
│  • Signs app bundle with keystore               │
│  • Authenticates with service account           │
│  • Uploads to chosen track                      │
│    - internal (instant, no review)              │
│    - beta (minimal review)                      │
│    - production (full review, gradual rollout)  │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  Google Play Console                             │
│  • Receives signed AAB                          │
│  • Processes build                              │
│  • Distributes to users                         │
└─────────────────────────────────────────────────┘
```

### iOS Workflow

```
┌─────────────────────────────────────────────────┐
│  Developer                                       │
│  • Updates code                                  │
│  • Creates git tag (v1.0.0)                     │
│  • Pushes to GitHub                             │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  GitHub Actions Workflow                         │
│  .github/workflows/ios-release.yml              │
│                                                  │
│  1. Setup environment (Ruby, Xcode, Flutter)    │
│  2. Install Fastlane via Bundler                │
│  3. Install certificates & provisioning         │
│  4. Build IPA with Flutter                      │
│  5. Run Fastlane upload                         │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  Fastlane                                        │
│  ios/fastlane/Fastfile                          │
│                                                  │
│  • Signs IPA with certificate                   │
│  • Authenticates with App Store Connect API     │
│  • Uploads to chosen destination                │
│    - TestFlight internal (instant)              │
│    - TestFlight external (beta review)          │
│    - App Store (full review)                    │
└────────────────┬────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────┐
│  App Store Connect                               │
│  • Processes IPA                                │
│  • Distributes to TestFlight or App Store       │
│  • Makes available to testers/users             │
└─────────────────────────────────────────────────┘
```

### Key Components

| Component | Purpose | Location |
|-----------|---------|----------|
| **Gemfile** | Fastlane dependencies | Project root |
| **Fastfile (Android)** | Android deployment workflows | `android/fastlane/` |
| **Fastfile (iOS)** | iOS deployment workflows | `ios/fastlane/` |
| **Appfile** | App configuration | `android/fastlane/` & `ios/fastlane/` |
| **Workflows** | GitHub Actions config | `.github/workflows/` |
| **Keystore** | Android app signing | `android/app/` (git-ignored) |
| **key.properties** | Android signing config | `android/` (git-ignored) |
| **Certificate (.p12)** | iOS signing certificate | Keychain (git-ignored) |
| **Provisioning Profile** | iOS provisioning | `~/Library/...` (git-ignored) |
| **Service Account (Android)** | Play Store auth | GitHub Secrets |
| **API Key (iOS)** | App Store Connect auth | GitHub Secrets |

## ⚙️ Configuration Files

### Fastlane Configuration

**Android:**
```ruby
# android/fastlane/Fastfile
lane :release_internal    # Upload to internal testing
lane :release_beta        # Upload to beta track
lane :release_production  # Upload to production (10% rollout)
```

**iOS:**
```ruby
# ios/fastlane/Fastfile
lane :release_testflight           # Upload to TestFlight (internal)
lane :release_testflight_external  # Upload to TestFlight (external)
lane :release_appstore             # Submit to App Store for review
lane :release_appstore_draft       # Upload without submitting
```

### GitHub Actions Workflows

**Android:**
```yaml
# .github/workflows/android-release.yml
# Triggers:
#   - Push tag: v* → production track
#   - Manual: Choose track (internal/beta/production)
```

**iOS:**
```yaml
# .github/workflows/ios-release.yml
# Triggers:
#   - Push tag: v* → TestFlight
#   - Manual: Choose distribution (testflight/testflight_external/appstore/appstore_draft)
```

### Environment Variables (GitHub Secrets)

**Android Secrets:**

| Secret | Description |
|--------|-------------|
| `PLAY_STORE_SERVICE_ACCOUNT_JSON` | Google Play API credentials |
| `KEYSTORE_BASE64` | Base64-encoded keystore |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_ALIAS` | Key alias name |
| `KEY_PASSWORD` | Key password |

**iOS Secrets:**

| Secret | Description |
|--------|-------------|
| `APPLE_CERTIFICATE_BASE64` | Base64-encoded P12 certificate |
| `APPLE_CERTIFICATE_PASSWORD` | P12 password |
| `PROVISIONING_PROFILE_BASE64` | Base64-encoded provisioning profile |
| `PROVISIONING_PROFILE_SPECIFIER` | Profile name from Apple Developer |
| `APP_STORE_CONNECT_API_KEY` | App Store Connect API key (.p8) |
| `APP_STORE_CONNECT_KEY_ID` | API Key ID |
| `APP_STORE_CONNECT_ISSUER_ID` | Issuer ID |
| `APPLE_ID` | Apple Developer email |
| `APPLE_TEAM_ID` | Team ID |
| `APP_STORE_CONNECT_TEAM_ID` | App Store Connect Team ID |

## 🔄 Deployment Workflows

### Automatic Deployment (Tag Push)

```bash
# 1. Update version
vim pubspec.yaml  # version: 1.0.1+2

# 2. Commit changes
git add pubspec.yaml
git commit -m "Bump version to 1.0.1"

# 3. Create and push tag
git tag v1.0.1
git push origin main
git push origin v1.0.1

# 4. GitHub Actions automatically:
#    - Builds AAB
#    - Deploys to production (10% rollout)
#    - Creates GitHub release
```

### Manual Deployment (Workflow Dispatch)

```
1. GitHub → Actions → Android Release
2. Click "Run workflow"
3. Select branch: main
4. Select track: internal / beta / production
5. Click "Run workflow"
6. Monitor progress in Actions tab
```

### Local Testing Deployment

```bash
# Install dependencies
bundle install

# Set environment variable
export PLAY_STORE_JSON_KEY='<paste JSON key contents>'

# Deploy to internal track
cd android
bundle exec fastlane release_internal

# Check Play Console → Internal testing
```

## 📊 Release Tracks

### Android (Google Play)

| Track | Review Time | Rollout | Use Case |
|-------|-------------|---------|----------|
| **Internal** | None (instant) | 100% to testers | QA, internal testing |
| **Beta** | Minimal (hours) | 100% to beta users | Public beta, feedback |
| **Production** | 2-7 days | Gradual (10%+) | Stable release |

### iOS (App Store)

| Distribution | Review Time | Rollout | Use Case |
|--------------|-------------|---------|----------|
| **TestFlight (Internal)** | None (instant) | 100% to testers (max 100) | Team testing |
| **TestFlight (External)** | 24-48 hours (beta review) | 100% to beta users (max 10,000) | Public beta |
| **App Store** | 2-7 days (full review) | Phased (7-day) or immediate | Production release |

## 🛡️ Security Best Practices

✅ **Do:**
- Store keystore in secure location + GitHub Secrets
- Use GitHub Secrets for all credentials
- Rotate service account keys annually
- Enable 2FA on all accounts
- Keep backups of keystores in secure vault

❌ **Don't:**
- Commit keystores to git
- Share service account JSON publicly
- Use same keystore for debug and release
- Skip manual first upload (required)

## 🔍 Troubleshooting

### Common Issues

| Error | Solution |
|-------|----------|
| "Permission denied" | Check service account permissions in Play Console |
| "Package not found" | Upload first build manually |
| "Version already exists" | Increment version in pubspec.yaml |
| "bundler not found" | Install: `gem install bundler` |

See full troubleshooting:
- [CI/CD Setup - Troubleshooting](CICD_SETUP.md#troubleshooting)
- [Google Play Console - Troubleshooting](GOOGLE_PLAY_CONSOLE_SETUP.md#troubleshooting)

## 📈 Monitoring & Analytics

### Where to Check Deployment Status

1. **GitHub Actions**: Real-time build logs
   - Repository → Actions → Select workflow run

2. **Google Play Console**: Build processing status
   - App → Release → [Track] → View releases

3. **Fastlane Output**: Detailed deployment info
   - GitHub Actions logs → "Build and Deploy" step

### Key Metrics to Monitor

- Build success rate
- Deploy time
- Crash-free rate after rollout
- User ratings after release

## 🔄 Updating Fastlane

```bash
# Update to latest version
bundle update fastlane

# Commit lock file
git add Gemfile.lock
git commit -m "Update Fastlane"
```

## 📚 External Resources

- [Fastlane Documentation](https://docs.fastlane.tools/)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [Flutter Deployment Guide](https://docs.flutter.dev/deployment/android)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## 🤝 Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for contribution guidelines.

## 📝 License

See [LICENSE](../LICENSE) for license information.

---

**Last Updated**: January 2025
**Maintainer**: Framer Team
**CI/CD Stack**: Flutter + Fastlane + GitHub Actions
