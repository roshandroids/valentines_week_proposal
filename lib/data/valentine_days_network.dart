import 'valentine_day.dart';

/// Example configuration using network URLs for GIFs
/// This reduces bundle size and improves loading times on web
final List<ValentineDay> valentineDaysNetwork = [
  ValentineDay(
    date: 7,
    title: 'Rose Day',
    message:
        'They say roses are red... but mine came with a receipt. '
        'Just kidding! These virtual roses never wilt, unlike my patience waiting for you. 🌹',
    lottiePath: 'assets/lottie/day1_rose.json',
    // Replace with your actual GIF URLs from GitHub, Imgur, Giphy, etc.
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day1.gif',
    interactionType: 'tap',
  ),
  ValentineDay(
    date: 8,
    title: 'Teddy Day',
    message:
        'I got you a teddy bear because it\'s the only thing '
        'that can handle your bear hugs without complaining. Unlike me. 🧸',
    lottiePath: 'assets/lottie/day2_teddy.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day2.gif',
    interactionType: 'longPress',
  ),
  ValentineDay(
    date: 9,
    title: 'Chocolate Day',
    message:
        'Life is like a box of chocolates... and you stole all the good ones. '
        'But I still love you more than chocolate. That\'s saying something. 🍫',
    lottiePath: 'assets/lottie/day3_chocolate.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day3.gif',
    interactionType: 'counter',
  ),
  ValentineDay(
    date: 10,
    title: 'Propose Day',
    message:
        'I practiced this proposal in front of my mirror 47 times. '
        'The mirror said yes. Your turn now? 💍',
    lottiePath: 'assets/lottie/day4_propose.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day4.gif',
    interactionType: 'checkbox',
  ),
  ValentineDay(
    date: 11,
    title: 'Hug Day',
    message:
        'Hugs are free, calorie-free, and scientifically proven to improve mood. '
        'So basically, I\'m doing you a health favor here. You\'re welcome. 🤗',
    lottiePath: 'assets/lottie/day5_hug.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day5.gif',
    interactionType: 'longPress',
  ),
  ValentineDay(
    date: 12,
    title: 'Kiss Day',
    message:
        'I googled "How to be a better kisser" and the first result was "practice". '
        'So... science says we should practice. A lot. 💋',
    lottiePath: 'assets/lottie/day6_kiss.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day6.gif',
    interactionType: 'counter',
  ),
  ValentineDay(
    date: 13,
    title: 'Promise Day',
    message:
        'I promise to laugh at your jokes (even the bad ones), '
        'share my fries (sometimes), and love you forever (definitely). 💕',
    lottiePath: 'assets/lottie/day7_valentine.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day7.gif',
    interactionType: 'checkbox',
  ),
  ValentineDay(
    date: 14,
    title: 'Valentine\'s Day',
    message:
        'My Dear Love, through all the jokes and sarcasm, here\'s the truth: '
        'You make every day feel like Valentine\'s Day. '
        'Thank you for being you, for being mine, for being us. '
        'I love you more than words can express. Happy Valentine\'s Day, meri maya. ❤️',
    lottiePath: 'assets/lottie/day7_valentine.json',
    gifPath:
        'https://raw.githubusercontent.com/roshandroids/valentines_week_proposal/master/assets/gifs/day7.gif',
    interactionType: 'none',
  ),
];
