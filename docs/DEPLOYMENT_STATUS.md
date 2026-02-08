# GitHub Actions CI/CD Setup - Deployment Guide

## ✅ What's Been Implemented

1. **GitHub Actions Workflow Created**
   - File: `.github/workflows/deploy-gh-pages.yml`
   - Triggers: Automatically on push to `main` branch or manual workflow dispatch
   - Action: Builds Flutter web and deploys to GitHub Pages

2. **Flutter Web Build Verified**
   - Successfully built locally: `build/web`
   - Build time: ~44 seconds
   - Optimizations applied: Tree-shaking enabled (99.4% font reduction)

## 🚀 Next Steps (Manual Actions Required)

### 1. Push to GitHub

```bash
git add .github/workflows/deploy-gh-pages.yml
git commit -m "Add GitHub Actions deployment workflow"
git push origin main
```

### 2. Enable GitHub Pages

1. Go to your GitHub repository settings
2. Navigate to **Pages** section (Settings → Pages)
3. Under **Source**, select:
   - Branch: `gh-pages`
   - Folder: `/ (root)`
4. Click **Save**

### 3. Wait for First Deployment

- After pushing, the workflow will run automatically
- Check progress: Repository → Actions tab
- First deployment takes ~2-3 minutes
- `gh-pages` branch will be created automatically

### 4. Access Your Live Site

Once deployed, your site will be available at:

```
https://<your-github-username>.github.io/<repository-name>/
```

Example: `https://roshanshrestha.github.io/valentines_week_proposal/`

## 📋 Workflow Details

**Triggers:**

- Push to `main` branch
- Manual trigger (workflow_dispatch)

**Steps:**

1. Checkout code
2. Setup Flutter (stable channel)
3. Install dependencies (`flutter pub get`)
4. Build web (`flutter build web --release`)
5. Deploy to gh-pages branch

**Permissions:**

- `contents: write` (for pushing to gh-pages branch)

## 🔧 Troubleshooting

### Build Fails

- Check Actions tab for error logs
- Verify all dependencies in `pubspec.yaml` are publicly available
- Check that `flutter build web` works locally

### Page Not Loading

- Ensure GitHub Pages is enabled with `gh-pages` branch
- Check if `base-href` matches your repository name
- Wait 5-10 minutes for DNS propagation

### Assets Not Loading

- Verify assets are listed in `pubspec.yaml`
- Check browser console for 404 errors
- Ensure asset paths are relative, not absolute

## 📝 Configuration Notes

**Base Href:**

- Automatically set to `/${{ github.event.repository.name }}/`
- Matches GitHub Pages URL structure
- No manual configuration needed

**Caching:**

- Flutter SDK cached between builds
- Speeds up subsequent deployments

## 🎯 Future Enhancements

Consider adding:

- Pull request preview deployments
- Build status badges in README
- Multiple environment deployments (staging/production)
- Automated testing before deployment
- Performance monitoring

---

**Status:** ✅ Ready to deploy
**Last Updated:** February 7, 2026
