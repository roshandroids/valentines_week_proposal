import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/painters/petal_painter.dart';
import '../../core/painters/confetti_painter.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

class ProposalScreen extends StatefulWidget {
  const ProposalScreen({super.key});

  @override
  State<ProposalScreen> createState() => _ProposalScreenState();
}

class _ProposalScreenState extends State<ProposalScreen>
    with TickerProviderStateMixin {
  final Random _rand = Random();
  late final AnimationController _petalController;
  late final AnimationController _bobController;
  late final AnimationController _celebrationController;

  late final List<Petal> _petals;
  late final List<ConfettiPiece> _confetti;

  Timer? _jokeTimer;
  int _jokeIndex = 0;
  int _noDodges = 0;
  bool _accepted = false;
  Offset _noOffset = const Offset(0.65, 0.58);
  DateTime _lastDodge = DateTime.fromMillisecondsSinceEpoch(0);

  List<String> get _jokes => [
    'The "No" button is clearly shy. Just like me when I first met you.',
    'Come on, even the button knows it should be a "Yes"!',
    'That button is practicing social distancing. Unlike my heart from you.',
    'The button said: "I run away, but you should stay!" 😏',
    'My code works better than my pick-up lines. Please say yes?',
  ];

  @override
  void initState() {
    super.initState();

    _petalController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _petals = List.generate(36, (index) {
      return Petal(
        x: _rand.nextDouble(),
        y: _rand.nextDouble(),
        size: _rand.nextDouble() * 10 + 8,
        speed: _rand.nextDouble() * 0.6 + 0.2,
        sway: _rand.nextDouble() * 0.04 + 0.01,
        phase: _rand.nextDouble() * 2 * pi,
        color:
            Color.lerp(
              const Color(0xFFFFB6C1),
              const Color(0xFFFF6FA5),
              _rand.nextDouble(),
            ) ??
            const Color(0xFFFFB6C1),
      );
    });

    _confetti = List.generate(80, (index) {
      final angle = _rand.nextDouble() * pi * 2;
      return ConfettiPiece(
        angle: angle,
        speed: _rand.nextDouble() * 280 + 160,
        size: _rand.nextDouble() * 6 + 4,
        spin: _rand.nextDouble() * 6 - 3,
        color:
            Color.lerp(
              const Color(0xFFFFC1CC),
              const Color(0xFFFFF2B3),
              _rand.nextDouble(),
            ) ??
            const Color(0xFFFFC1CC),
      );
    });

    _jokeTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || _accepted) return;
      setState(() {
        _jokeIndex = (_jokeIndex + 1) % _jokes.length;
      });
    });
  }

  @override
  void dispose() {
    _petalController.dispose();
    _bobController.dispose();
    _celebrationController.dispose();
    _jokeTimer?.cancel();
    super.dispose();
  }

  void _moveNoButton() {
    final now = DateTime.now();
    if (now.difference(_lastDodge).inMilliseconds < 180) {
      return;
    }
    _lastDodge = now;
    setState(() {
      _noDodges++;
      _noOffset = Offset(
        0.1 + _rand.nextDouble() * 0.7,
        0.3 + _rand.nextDouble() * 0.5,
      );
    });
  }

  void _accept() {
    if (_accepted) return;
    setState(() {
      _accepted = true;
    });
    _celebrationController.forward(from: 0);

    // Navigate to home screen after celebration
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_petalController, _bobController]),
        builder: (context, _) {
          final media = MediaQuery.of(context);
          return Stack(
            children: [
              // Background gradient
              Container(decoration: AppTheme.backgroundGradient(context)),

              // Petals animation
              CustomPaint(
                size: media.size,
                painter: PetalPainter(
                  time: _petalController.value,
                  petals: _petals,
                ),
              ),

              // Main card
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _MainCard(
                    bobValue: _bobController.value,
                    noOffset: _noOffset,
                    noDodges: _noDodges,
                    joke: _jokes[_jokeIndex],
                    onYes: _accept,
                    onNoHover: _moveNoButton,
                    onNoTap: _moveNoButton,
                  ),
                ),
              ),

              // Celebration overlay
              if (_accepted)
                _CelebrationOverlay(
                  controller: _celebrationController,
                  confetti: _confetti,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MainCard extends StatelessWidget {
  const _MainCard({
    required this.bobValue,
    required this.noOffset,
    required this.noDodges,
    required this.joke,
    required this.onYes,
    required this.onNoHover,
    required this.onNoTap,
  });

  final double bobValue;
  final Offset noOffset;
  final int noDodges;
  final String joke;
  final VoidCallback onYes;
  final VoidCallback onNoHover;
  final VoidCallback onNoTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = min(620.0, size.width - 32);
    final cardHeight = min(400.0, size.height * 0.55);

    return Transform.translate(
      offset: Offset(0, -20 - bobValue * 8),
      child: Center(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: AppTheme.overlayLight,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppTheme.overlayMedium),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Heart animation
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: const Icon(
                          Icons.favorite,
                          color: AppTheme.primaryColor,
                          size: 64,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'My Dear Love,',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppLocalizations.of(context)!.proposalQuestion,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      joke,
                      key: ValueKey(joke),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const Spacer(),

                  // Buttons
                  SizedBox(
                    height: 120,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final area = constraints.biggest;
                        final yesOffset = Offset(
                          area.width * 0.08,
                          area.height * 0.58,
                        );
                        final noOffsetPx = Offset(
                          area.width * noOffset.dx,
                          area.height * noOffset.dy,
                        );

                        return Stack(
                          children: [
                            Positioned(
                              left: yesOffset.dx,
                              top: yesOffset.dy,
                              child: ElevatedButton(
                                onPressed: onYes,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: AppTheme.textPrimary,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 14,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Text('Yes! 💕'),
                              ),
                            ),
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              left: noOffsetPx.dx,
                              top: noOffsetPx.dy,
                              child: MouseRegion(
                                onEnter: (_) => onNoHover(),
                                onHover: (_) => onNoHover(),
                                child: GestureDetector(
                                  onTapDown: (_) => onNoTap(),
                                  child: OutlinedButton(
                                    onPressed: onNoTap,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppTheme.textSecondary,
                                      side: BorderSide(
                                        color: AppTheme.overlayMedium,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 14,
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text('No ($noDodges)'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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

class _CelebrationOverlay extends StatelessWidget {
  const _CelebrationOverlay({required this.controller, required this.confetti});

  final AnimationController controller;
  final List<ConfettiPiece> confetti;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = Curves.easeOut.transform(controller.value);
        return Positioned.fill(
          child: AbsorbPointer(
            absorbing: true,
            child: Stack(
              children: [
                Container(
                  color: AppTheme.backgroundColor.withValues(alpha: 0.45 * t),
                ),
                CustomPaint(
                  painter: ConfettiPainter(progress: t, confetti: confetti),
                ),
                Center(
                  child: Transform.scale(
                    scale: 0.85 + 0.2 * t,
                    child: Opacity(
                      opacity: t,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: AppTheme.primaryColor,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'You\'ve made me the happiest! 🎉',
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(color: AppTheme.primaryColor),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'I have some special surprises waiting for you...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: const Color(0xFF4A1B2A)),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Taking you to the calendar...',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
