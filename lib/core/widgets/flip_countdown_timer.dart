import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dart:math' as math;

class FlipCountdownTimer extends StatefulWidget {
  final Duration duration;

  const FlipCountdownTimer({super.key, required this.duration});

  @override
  State<FlipCountdownTimer> createState() => _FlipCountdownTimerState();
}

class _FlipCountdownTimerState extends State<FlipCountdownTimer> {
  @override
  Widget build(BuildContext context) {
    final days = widget.duration.inDays;
    final hours = widget.duration.inHours.remainder(24);
    final minutes = widget.duration.inMinutes.remainder(60);
    final seconds = widget.duration.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (days > 0) ...[
          _TimeUnit(value: days, label: 'DAYS'),
          const SizedBox(width: 8),
          _Separator(),
          const SizedBox(width: 8),
        ],
        _TimeUnit(value: hours, label: 'HRS'),
        const SizedBox(width: 8),
        _Separator(),
        const SizedBox(width: 8),
        _TimeUnit(value: minutes, label: 'MIN'),
        const SizedBox(width: 8),
        _Separator(),
        const SizedBox(width: 8),
        _TimeUnit(value: seconds, label: 'SEC'),
      ],
    );
  }
}

class _TimeUnit extends StatelessWidget {
  final int value;
  final String label;

  const _TimeUnit({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final digits = value.toString().padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _FlipCard(digit: digits[0]),
            const SizedBox(width: 4),
            _FlipCard(digit: digits[1]),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _FlipCard extends StatefulWidget {
  final String digit;

  const _FlipCard({required this.digit});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _previousDigit = '0';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _previousDigit = widget.digit;
  }

  @override
  void didUpdateWidget(_FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.digit != widget.digit) {
      _previousDigit = oldWidget.digit;
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 60,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFirstHalf = _animation.value < 0.5;
          final currentDigit = isFirstHalf ? _previousDigit : widget.digit;
          final angle =
              isFirstHalf
                  ? -_animation.value * math.pi
                  : -(0.5 + (1 - _animation.value) * 0.5) * math.pi;

          return Stack(
            children: [
              // Bottom card (next digit)
              Positioned.fill(
                child: _DigitCard(digit: widget.digit, isTop: false),
              ),
              // Flipping card
              if (_animation.value > 0)
                Transform(
                  alignment: Alignment.center,
                  transform:
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(angle),
                  child: _DigitCard(digit: currentDigit, isTop: isFirstHalf),
                ),
              // Top card (current digit) - when not animating
              if (_animation.value == 0)
                Positioned.fill(
                  child: _DigitCard(digit: _previousDigit, isTop: true),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _DigitCard extends StatelessWidget {
  final String digit;
  final bool isTop;

  const _DigitCard({required this.digit, required this.isTop});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: isTop ? Alignment.topCenter : Alignment.bottomCenter,
        heightFactor: 0.5,
        child: Container(
          width: 40,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor.withValues(alpha: 0.9),
                AppTheme.primaryColor.withValues(alpha: 0.7),
              ],
            ),
            borderRadius:
                isTop
                    ? const BorderRadius.vertical(top: Radius.circular(8))
                    : const BorderRadius.vertical(bottom: Radius.circular(8)),
            border: Border.all(color: AppTheme.overlayMedium, width: 1),
            boxShadow: [
              BoxShadow(
                color: AppTheme.backgroundColor.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              digit,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(height: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: AppTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
