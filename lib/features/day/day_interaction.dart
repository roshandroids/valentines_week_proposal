import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class DayInteraction extends StatefulWidget {
  final String interactionType;
  final int date;

  const DayInteraction({
    super.key,
    required this.interactionType,
    required this.date,
  });

  @override
  State<DayInteraction> createState() => _DayInteractionState();
}

class _DayInteractionState extends State<DayInteraction>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isPressed = false;
  final List<bool> _checklist = [false, false, false, false];
  late AnimationController _heartAnimationController;
  final List<_FloatingHeart> _floatingHearts = [];

  @override
  void initState() {
    super.initState();
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _addFloatingHeart() {
    final random = DateTime.now().millisecondsSinceEpoch % 100 / 100;
    final heart = _FloatingHeart(
      key: UniqueKey(),
      startX: 0.3 + random * 0.4, // Random position between 0.3 and 0.7
    );

    setState(() {
      _floatingHearts.add(heart);
    });

    // Reset and start animation
    _heartAnimationController.reset();
    _heartAnimationController.forward().then((_) {
      setState(() {
        _floatingHearts.remove(heart);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.interactionType) {
      case 'tap':
        return _buildTapInteraction();
      case 'longPress':
        return _buildLongPressInteraction();
      case 'counter':
        return _buildCounterInteraction();
      case 'checkbox':
        return _buildCheckboxInteraction();
      default:
        return const SizedBox();
    }
  }

  Widget _buildTapInteraction() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isPressed = !_isPressed;
            });
            if (_isPressed) {
              _addFloatingHeart();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color:
                  _isPressed
                      ? AppTheme.primaryOverlayLight
                      : AppTheme.overlayLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: _isPressed ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isPressed ? Icons.favorite : Icons.favorite_border,
                    color: AppTheme.textPrimary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  _isPressed ? 'You tapped my heart! 💕' : 'Tap to send love',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
        // Floating hearts animation
        ..._floatingHearts.map(
          (heart) => _FloatingHeartWidget(
            key: heart.key,
            startX: heart.startX,
            animationController: _heartAnimationController,
          ),
        ),
      ],
    );
  }

  Widget _buildLongPressInteraction() {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color:
              _isPressed
                  ? AppTheme.primaryOverlayMedium
                  : AppTheme.overlayLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              Icons.favorite,
              color: AppTheme.textPrimary,
              size: _isPressed ? 64 : 48,
            ),
            const SizedBox(height: 16),
            Text(
              _isPressed ? 'Feeling the love! 🤗' : 'Hold to hug',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterInteraction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        children: [
          Text(
            widget.date == 9 ? 'Chocolates Collected' : 'Kisses Collected',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text('$_counter', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: Text(
              widget.date == 9 ? 'Grab Chocolate 🍫' : 'Send Kiss 💋',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxInteraction() {
    final promises =
        widget.date == 13
            ? [
              'Always laugh at your jokes 😄',
              'Share my snacks (sometimes) 🍿',
              'Give unlimited hugs 🤗',
              'Love you forever ❤️',
            ]
            : [
              'Make you smile every day 😊',
              'Be your biggest supporter 💪',
              'Always be honest 🤝',
              'Love you unconditionally ❤️',
            ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Promises to You:',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          ...List.generate(promises.length, (index) {
            return CheckboxListTile(
              title: Text(
                promises[index],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              value: _checklist[index],
              onChanged: (value) {
                setState(() {
                  _checklist[index] = value ?? false;
                });
              },
              activeColor: AppTheme.primaryColor,
              checkColor: AppTheme.textPrimary,
            );
          }),
        ],
      ),
    );
  }
}

// Helper classes for floating hearts animation
class _FloatingHeart {
  final Key key;
  final double startX;

  _FloatingHeart({required this.key, required this.startX});
}

class _FloatingHeartWidget extends StatelessWidget {
  final double startX;
  final AnimationController animationController;

  const _FloatingHeartWidget({
    super.key,
    required this.startX,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final progress = animationController.value;
        final yOffset = -progress * 150; // Float up 150 pixels
        final opacity = 1.0 - progress; // Fade out
        final scale = 1.0 + progress * 0.5; // Grow slightly

        return Positioned(
          left: MediaQuery.of(context).size.width * startX,
          bottom: 100 + yOffset,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: const Icon(
                Icons.favorite,
                color: AppTheme.primaryColor,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
