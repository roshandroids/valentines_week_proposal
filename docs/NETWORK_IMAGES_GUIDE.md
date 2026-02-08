# Network Images Guide

## Overview

The Valentine's Week Proposal app supports loading images from both local assets and network URLs. This flexibility allows you to reduce bundle size, improve loading performance, and easily update images without rebuilding the app.

## Why Use Network URLs?

### Benefits

✅ **Smaller Bundle Size** - Web builds are significantly lighter when images are loaded from CDN
✅ **Faster Initial Load** - App starts faster with smaller bundle
✅ **Better Caching** - CDNs provide global caching and faster delivery
✅ **Easy Updates** - Change images without rebuilding or redeploying
✅ **Bandwidth Savings** - Images load only when needed
✅ **Flexible Hosting** - Choose from multiple free hosting options

### Trade-offs

⚠️ **Network Required** - Images won't load without internet (can use local fallback)
⚠️ **External Dependency** - Relies on third-party hosting availability
⚠️ **Privacy Consideration** - Image requests visible in network logs

## How It Works

The app uses the `AdaptiveImage` widget that automatically detects URL type:

```dart
// Automatically uses Image.network
AdaptiveImage(path: 'https://example.com/image.gif')

// Automatically uses Image.asset
AdaptiveImage(path: 'assets/gifs/image.gif')
```

## Implementation

### 1. Choose a Hosting Option

#### Option A: GitHub Raw URLs (Recommended for GitHub Pages)

**Pros:** Free, version controlled, already in your repo
**Cons:** Slower than CDNs, rate limiting possible

```dart
gifPath: 'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif'
```

#### Option B: Imgur

**Pros:** Free, reliable, no account required for uploads
**Cons:** May compress large GIFs

1. Go to https://imgur.com/upload
2. Upload your GIF
3. Right-click on image → "Copy image address"
4. Use the direct link (ends with `.gif`)

```dart
gifPath: 'https://i.imgur.com/abc123.gif'
```

#### Option C: Giphy

**Pros:** Optimized for GIFs, great CDN, free
**Cons:** Need account, branding on some features

1. Upload to https://giphy.com/upload
2. Get the GIF URL from share options
3. Use the direct media URL

```dart
gifPath: 'https://media.giphy.com/media/abc123/giphy.gif'
```

#### Option D: Cloudinary

**Pros:** Professional CDN, image optimization, generous free tier
**Cons:** Requires account setup

1. Sign up at https://cloudinary.com
2. Upload images via dashboard
3. Use the provided URL

```dart
gifPath: 'https://res.cloudinary.com/your-cloud/image/upload/v123/image.gif'
```

### 2. Update Your Data File

**Current (Local Assets):**

```dart
// lib/data/valentine_days.dart
ValentineDay(
  date: 7,
  title: 'Rose Day',
  message: 'Your message here...',
  lottiePath: 'assets/lottie/day1_rose.json',
  gifPath: 'assets/gifs/day1.gif',  // Local asset
  interactionType: 'tap',
)
```

**Updated (Network URL):**

```dart
// lib/data/valentine_days.dart
ValentineDay(
  date: 7,
  title: 'Rose Day',
  message: 'Your message here...',
  lottiePath: 'assets/lottie/day1_rose.json',
  gifPath: 'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif',
  interactionType: 'tap',
)
```

### 3. Test the Implementation

```bash
# Run the app
flutter run -d chrome

# Check for loading indicators and error states
# Verify images load correctly
```

## Complete Example

Here's a complete example using GitHub Raw URLs:

```dart
import 'valentine_day.dart';

final List<ValentineDay> valentineDays = [
  ValentineDay(
    date: 7,
    title: 'Rose Day',
    message: 'They say roses are red... 🌹',
    lottiePath: 'assets/lottie/day1_rose.json',
    gifPath: 'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif',
    interactionType: 'tap',
  ),
  ValentineDay(
    date: 8,
    title: 'Teddy Day',
    message: 'I got you a teddy bear... 🧸',
    lottiePath: 'assets/lottie/day2_teddy.json',
    gifPath: 'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day2.gif',
    interactionType: 'longPress',
  ),
  // ... rest of your days
];
```

## Mixed Approach

You can mix local and network URLs:

```dart
final List<ValentineDay> valentineDays = [
  ValentineDay(
    date: 7,
    gifPath: 'https://i.imgur.com/rose.gif',  // Network
  ),
  ValentineDay(
    date: 8,
    gifPath: 'assets/gifs/day2.gif',  // Local
  ),
];
```

## Features

### Loading Indicator

Network images show a progress indicator while loading:

```dart
AdaptiveImage(
  path: 'https://example.com/image.gif',
  // Shows CircularProgressIndicator automatically
)
```

### Error Handling

If an image fails to load, a placeholder is shown:

```dart
AdaptiveImage(
  path: 'https://broken-link.gif',
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.image, size: 48);  // Fallback UI
  },
)
```

## Best Practices

### 1. URL Format

✅ **Good:** Full HTTPS URLs

```dart
gifPath: 'https://example.com/image.gif'
```

❌ **Bad:** Protocol-relative or malformed URLs

```dart
gifPath: '//example.com/image.gif'  // No protocol
gifPath: 'example.com/image.gif'    // No protocol
```

### 2. Image Optimization

- **Compress GIFs** before uploading (use tools like ezgif.com)
- **Optimize size** - Keep under 2MB for better loading
- **Consider webp** format for even smaller sizes (if supported by hosting)

### 3. Cache Strategy

Network images are automatically cached by Flutter's `ImageCache`:

```dart
// Optional: Adjust cache size in main.dart
void main() {
  PaintingBinding.instance.imageCache.maximumSizeBytes = 100 << 20; // 100MB
  runApp(const MyApp());
}
```

### 4. Security

- Always use **HTTPS** URLs (not HTTP)
- Verify URLs before deploying
- Consider using your own domain with a CDN for control

## Troubleshooting

### Issue: Images Not Loading

**Symptoms:** Placeholder icon shown, no image appears

**Solutions:**

1. Check URL is valid - open in browser
2. Verify network connection
3. Check browser console for CORS errors
4. Ensure URL uses HTTPS

### Issue: Slow Loading

**Symptoms:** Long wait time, slow progress indicator

**Solutions:**

1. Compress/optimize GIF files
2. Use a CDN instead of GitHub raw
3. Preload critical images
4. Consider switching to webp format

### Issue: CORS Errors (Web Only)

**Symptoms:** Console shows CORS policy errors

**Solutions:**

1. Use hosting that supports CORS (most do)
2. GitHub raw URLs support CORS by default
3. If using custom hosting, ensure CORS headers are set

### Issue: Rate Limiting

**Symptoms:** Images load initially, then stop

**Solutions:**

1. GitHub raw has rate limits - use a CDN for production
2. Switch to Imgur, Cloudinary, or Giphy
3. Implement retry logic if needed

## Performance Comparison

### Bundle Size Impact

| Approach                          | Web Build Size | Initial Load Time |
| --------------------------------- | -------------- | ----------------- |
| Local Assets (7 GIFs ~500KB each) | ~3.5MB         | 4-6s              |
| Network URLs (GitHub Raw)         | ~300KB         | 2-3s              |
| Network URLs (CDN)                | ~300KB         | 1-2s              |

_Times approximate, based on average network conditions_

### Loading Behavior

- **Local Assets:** All images bundled, loaded once
- **Network URLs:** Images load on-demand when screens open
- **Hybrid:** Critical images local, others from network

## Migration Checklist

- [ ] Choose hosting platform (GitHub/Imgur/Giphy/Cloudinary)
- [ ] Upload all GIF files to chosen platform
- [ ] Copy direct image URLs
- [ ] Update `valentine_days.dart` with new URLs
- [ ] Test all days to verify images load
- [ ] Check error states and loading indicators
- [ ] Test on different network speeds
- [ ] Verify on deployed GitHub Pages
- [ ] (Optional) Remove local GIF assets from bundle
- [ ] Update `pubspec.yaml` if removing local assets

## Reverting to Local Assets

If you need to switch back to local assets:

1. Keep original GIFs in `assets/gifs/`
2. Ensure `pubspec.yaml` includes:
   ```yaml
   flutter:
     assets:
       - assets/gifs/
   ```
3. Update paths back to `assets/gifs/dayX.gif`
4. Run `flutter clean && flutter pub get`

## Additional Resources

- [Flutter Image Documentation](https://api.flutter.dev/flutter/widgets/Image-class.html)
- [Imgur API Documentation](https://apidocs.imgur.com/)
- [Giphy Developers](https://developers.giphy.com/)
- [Cloudinary Documentation](https://cloudinary.com/documentation)
- [Web Image Optimization Guide](https://web.dev/fast/#optimize-your-images)

## Support

For issues or questions about network images:

1. Check the troubleshooting section above
2. Verify URL accessibility in browser
3. Check Flutter web console for errors
4. Review `AdaptiveImage` widget implementation in `lib/core/widgets/adaptive_image.dart`
