import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import '../../data/valentine_day.dart';
import '../../core/theme/app_theme.dart';
import '../../core/lottie_cache_helper.dart';
import 'day_interaction.dart';

class DayScreen extends StatefulWidget {
  final ValentineDay day;

  const DayScreen({super.key, required this.day});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: AppTheme.backgroundGradient(context),
              );
            },
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isWide ? 48.0 : 24.0),
                child: Column(
                  children: [
                    // Header with back button
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppTheme.textPrimary,
                          ),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.day.title,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 48), // Balance back button
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Lottie Animation
                    Container(
                      height: size.height * (isWide ? 0.3 : 0.25),
                      constraints: const BoxConstraints(maxWidth: 400),
                      child:
                          LottieCacheHelper.isCached(widget.day.lottiePath)
                              ? Lottie(
                                composition: LottieCacheHelper.getCached(
                                  widget.day.lottiePath,
                                ),
                                fit: BoxFit.contain,
                                repeat: true,
                                animate: true,
                                frameRate: FrameRate.max,
                                options: LottieOptions(enableMergePaths: true),
                              )
                              : Lottie.asset(
                                widget.day.lottiePath,
                                fit: BoxFit.contain,
                                repeat: true,
                                animate: true,
                                frameRate: FrameRate.max,
                                options: LottieOptions(enableMergePaths: true),
                              ),
                    ),

                    const SizedBox(height: 32),

                    // Message Card
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      padding: const EdgeInsets.all(24),
                      decoration: AppTheme.cardDecoration(context),
                      child: Text(
                        widget.day.message,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.6),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // GIF
                    Container(
                      height: size.height * 0.2,
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.overlayMedium),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.day.gifPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppTheme.overlayLight,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  color: AppTheme.textSecondary,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Interaction Section
                    DayInteraction(
                      interactionType: widget.day.interactionType,
                      date: widget.day.date,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
