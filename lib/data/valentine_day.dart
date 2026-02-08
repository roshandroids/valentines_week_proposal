class ValentineDay {
  final int date; // Day of month (7-14)
  final String title; // "Rose Day", "Teddy Day", etc.
  final String message; // Sarcastic/romantic message
  final String lottiePath; // Path to Lottie JSON
  final String gifPath; // Path to GIF
  final String interactionType; // tap, longPress, checkbox, counter, none

  const ValentineDay({
    required this.date,
    required this.title,
    required this.message,
    required this.lottiePath,
    required this.gifPath,
    required this.interactionType,
  });
}
