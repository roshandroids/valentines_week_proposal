import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

import 'day_unlock_service.dart';
import 'lottie_cache_helper.dart';
import 'widgets/flip_countdown_timer.dart';
import 'theme/app_theme.dart';

class CountdownLockWidget extends StatefulWidget {
  final int targetDate;

  const CountdownLockWidget({super.key, required this.targetDate});

  @override
  State<CountdownLockWidget> createState() => _CountdownLockWidgetState();
}

class _CountdownLockWidgetState extends State<CountdownLockWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    setState(() {
      _remaining = DayUnlockService.getTimeRemaining(widget.targetDate);
    });

    // Auto-unlock when time reaches zero
    if (_remaining.isNegative || _remaining.inSeconds == 0) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUnlocked = _remaining.isNegative || _remaining.inSeconds == 0;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundGradient(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),

                  // Lock Icon/Animation
                  SizedBox(
                    height: size.height * 0.3,
                    child:
                        LottieCacheHelper.isCached(
                              'assets/lottie/countdown.json',
                            )
                            ? Lottie(
                              composition: LottieCacheHelper.getCached(
                                'assets/lottie/countdown.json',
                              ),
                              fit: BoxFit.contain,
                              repeat: true,
                              animate: true,
                              frameRate: FrameRate.max,
                              options: LottieOptions(enableMergePaths: true),
                            )
                            : Lottie.asset(
                              'assets/lottie/countdown.json',
                              fit: BoxFit.contain,
                              repeat: true,
                              animate: true,
                              frameRate: FrameRate.max,
                              options: LottieOptions(enableMergePaths: true),
                            ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  Text(
                    isUnlocked ? 'Surprise Unlocked!' : 'Patience, My Love',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // Message
                  Text(
                    isUnlocked
                        ? 'The wait is over! Your surprise is ready. 🎉'
                        : 'Good things come to those who wait.\n'
                            'And you, my dear, are worth the wait.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Countdown Timer
                  if (!isUnlocked) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.overlayLight,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.overlayMedium),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'UNLOCKS IN',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FlipCountdownTimer(duration: _remaining),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Action Button
                  ElevatedButton(
                    onPressed:
                        isUnlocked
                            ? () {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go('/home');
                              }
                            }
                            : null,
                    child: Text(
                      isUnlocked ? 'Open Surprise 🎉' : 'I will wait 😏',
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Back button
                  TextButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/home');
                      }
                    },
                    child: Text(
                      'Back to Calendar',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
