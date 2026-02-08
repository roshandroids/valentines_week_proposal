import 'package:lottie/lottie.dart';

/// Helper class to preload and cache Lottie animations for better performance
class LottieCacheHelper {
  static final Map<String, LottieComposition> _cache = {};

  /// Preload a Lottie animation into cache
  static Future<void> preloadAnimation(String assetPath) async {
    if (_cache.containsKey(assetPath)) return;

    try {
      final composition = await AssetLottie(assetPath).load();
      _cache[assetPath] = composition;
    } catch (e) {
      // Silently fail if animation cannot be loaded
      return;
    }
  }

  /// Preload multiple animations at once
  static Future<void> preloadAnimations(List<String> assetPaths) async {
    await Future.wait(assetPaths.map((path) => preloadAnimation(path)));
  }

  /// Get a cached composition or null if not cached
  static LottieComposition? getCached(String assetPath) {
    return _cache[assetPath];
  }

  /// Clear all cached animations
  static void clearCache() {
    _cache.clear();
  }

  /// Clear a specific animation from cache
  static void clearAnimation(String assetPath) {
    _cache.remove(assetPath);
  }

  /// Check if an animation is cached
  static bool isCached(String assetPath) {
    return _cache.containsKey(assetPath);
  }

  /// Get the number of cached animations
  static int get cacheSize => _cache.length;
}
