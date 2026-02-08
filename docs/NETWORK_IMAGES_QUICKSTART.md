# Quick Start: Network Images

## Switch to Network URLs (3 Steps)

### 1. Upload your GIFs

**Option A: Use GitHub (already done!)**

```
Your GIFs are at: https://github.com/roshandroids/valentines_week_proposal/tree/master/assets/gifs
```

**Option B: Upload to Imgur**

- Go to https://imgur.com/upload
- Upload each GIF
- Copy the direct link

### 2. Update valentine_days.dart

Replace:

```dart
gifPath: 'assets/gifs/day1.gif',
```

With:

```dart
gifPath: 'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif',
```

### 3. Test

```bash
flutter run -d chrome
```

## Your URLs

```dart
// Day 1 - Rose Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif'

// Day 2 - Teddy Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day2.gif'

// Day 3 - Chocolate Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day3.gif'

// Day 4 - Propose Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day4.gif'

// Day 5 - Hug Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day5.gif'

// Day 6 - Kiss Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day6.gif'

// Day 7 - Promise Day & Valentine's Day
'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day7.gif'
```

## Benefits

- ✅ **90% smaller bundle** (~3.5MB → ~300KB)
- ✅ **Faster loading**
- ✅ **Works out of the box** (AdaptiveImage widget already implemented)

## Full Guide

See [NETWORK_IMAGES_GUIDE.md](NETWORK_IMAGES_GUIDE.md) for:

- Alternative hosting options (Imgur, Giphy, Cloudinary)
- Troubleshooting
- Performance comparison
- Best practices
