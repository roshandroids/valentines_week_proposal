import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ne.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ne'),
  ];

  /// The application title
  ///
  /// In en, this message translates to:
  /// **'Valentine Week Surprise'**
  String get appTitle;

  /// Proposal screen question
  ///
  /// In en, this message translates to:
  /// **'Will you be my Valentine? 💖'**
  String get proposalQuestion;

  /// Proposal screen subtitle
  ///
  /// In en, this message translates to:
  /// **'I promise to make every day as magical as today...'**
  String get proposalSubtitle;

  /// Yes button text
  ///
  /// In en, this message translates to:
  /// **'Yes! 💕'**
  String get yesButton;

  /// No button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get noButton;

  /// First sarcastic message
  ///
  /// In en, this message translates to:
  /// **'Really? Try again! 😏'**
  String get sarcasticMessage1;

  /// Second sarcastic message
  ///
  /// In en, this message translates to:
  /// **'Come on, you know you want to! 😉'**
  String get sarcasticMessage2;

  /// Third sarcastic message
  ///
  /// In en, this message translates to:
  /// **'The \'No\' button is broken, try \'Yes\'! 😄'**
  String get sarcasticMessage3;

  /// Fourth sarcastic message
  ///
  /// In en, this message translates to:
  /// **'I\'ll keep moving it! Just say yes! 😂'**
  String get sarcasticMessage4;

  /// Fifth sarcastic message
  ///
  /// In en, this message translates to:
  /// **'You\'re making this harder than it needs to be! 💝'**
  String get sarcasticMessage5;

  /// Happy message when yes is clicked
  ///
  /// In en, this message translates to:
  /// **'You\'ve made me the happiest! 🎉'**
  String get happyMessage;

  /// Message about surprises
  ///
  /// In en, this message translates to:
  /// **'I have some special surprises waiting for you...'**
  String get surprisesMessage;

  /// Calendar screen title
  ///
  /// In en, this message translates to:
  /// **'Valentine Week 2026'**
  String get calendarTitle;

  /// Calendar screen subtitle
  ///
  /// In en, this message translates to:
  /// **'A Week of Love & Surprises'**
  String get calendarSubtitle;

  /// Countdown label
  ///
  /// In en, this message translates to:
  /// **'Unlocks in:'**
  String get unlocksIn;

  /// Days label in countdown
  ///
  /// In en, this message translates to:
  /// **'DAYS'**
  String get days;

  /// Hours label in countdown
  ///
  /// In en, this message translates to:
  /// **'HRS'**
  String get hours;

  /// Minutes label in countdown
  ///
  /// In en, this message translates to:
  /// **'MIN'**
  String get minutes;

  /// Seconds label in countdown
  ///
  /// In en, this message translates to:
  /// **'SEC'**
  String get seconds;

  /// Title for Rose Day
  ///
  /// In en, this message translates to:
  /// **'Rose Day'**
  String get roseDay;

  /// Message for Rose Day
  ///
  /// In en, this message translates to:
  /// **'They say roses are red... but mine came with a receipt. Just kidding! These virtual roses never wilt, unlike my patience waiting for you. 🌹'**
  String get roseDayMessage;

  /// Title for Teddy Day
  ///
  /// In en, this message translates to:
  /// **'Teddy Day'**
  String get teddyDay;

  /// Message for Teddy Day
  ///
  /// In en, this message translates to:
  /// **'I got you a teddy bear because it\'s the only thing that can handle your bear hugs without complaining. Unlike me. 🧸'**
  String get teddyDayMessage;

  /// Title for Chocolate Day
  ///
  /// In en, this message translates to:
  /// **'Chocolate Day'**
  String get chocolateDay;

  /// Message for Chocolate Day
  ///
  /// In en, this message translates to:
  /// **'Life is like a box of chocolates... and you stole all the good ones. But I still love you more than chocolate. That\'s saying something. 🍫'**
  String get chocolateDayMessage;

  /// Title for Propose Day
  ///
  /// In en, this message translates to:
  /// **'Propose Day'**
  String get proposeDay;

  /// Message for Propose Day
  ///
  /// In en, this message translates to:
  /// **'I practiced this proposal in front of my mirror 47 times. The mirror said yes. Your turn now? 💍'**
  String get proposeDayMessage;

  /// Title for Hug Day
  ///
  /// In en, this message translates to:
  /// **'Hug Day'**
  String get hugDay;

  /// Message for Hug Day
  ///
  /// In en, this message translates to:
  /// **'Hugs are free, calorie-free, and scientifically proven to improve mood. So basically, I\'m doing you a health favor here. You\'re welcome. 🤗'**
  String get hugDayMessage;

  /// Title for Kiss Day
  ///
  /// In en, this message translates to:
  /// **'Kiss Day'**
  String get kissDay;

  /// Message for Kiss Day
  ///
  /// In en, this message translates to:
  /// **'I googled \"How to be a better kisser\" and the first result was \"practice\". So... science says we should practice. A lot. 💋'**
  String get kissDayMessage;

  /// Title for Promise Day
  ///
  /// In en, this message translates to:
  /// **'Promise Day'**
  String get promiseDay;

  /// Message for Promise Day
  ///
  /// In en, this message translates to:
  /// **'I promise to laugh at your jokes (even the bad ones), share my fries (sometimes), and love you forever (definitely). 💕'**
  String get promiseDayMessage;

  /// Title for Valentine's Day
  ///
  /// In en, this message translates to:
  /// **'Valentine\'s Day'**
  String get valentineDay;

  /// Message for Valentine's Day
  ///
  /// In en, this message translates to:
  /// **'My Dear Love, through all the jokes and sarcasm, here\'s the truth: You make every day feel like Valentine\'s Day. Thank you for being you, for being mine, for being us. I love you more than words can express. Happy Valentine\'s Day, meri maya. ❤️'**
  String get valentineDayMessage;

  /// Tap interaction prompt
  ///
  /// In en, this message translates to:
  /// **'Tap to send love'**
  String get tapToSendLove;

  /// Message after tap
  ///
  /// In en, this message translates to:
  /// **'You tapped my heart! 💕'**
  String get heartTapped;

  /// Long press interaction prompt
  ///
  /// In en, this message translates to:
  /// **'Hold to hug'**
  String get holdToHug;

  /// Message during long press
  ///
  /// In en, this message translates to:
  /// **'Feeling the love! 🤗'**
  String get feelingLove;

  /// Counter label for chocolate day
  ///
  /// In en, this message translates to:
  /// **'Chocolates Collected'**
  String get chocolatesCollected;

  /// Counter label for kiss day
  ///
  /// In en, this message translates to:
  /// **'Kisses Collected'**
  String get kissesCollected;

  /// Button to collect chocolate
  ///
  /// In en, this message translates to:
  /// **'Grab Chocolate 🍫'**
  String get grabChocolate;

  /// Button to send kiss
  ///
  /// In en, this message translates to:
  /// **'Send Kiss 💋'**
  String get sendKiss;

  /// Promises header
  ///
  /// In en, this message translates to:
  /// **'My Promises to You:'**
  String get myPromises;

  /// First promise for Promise Day
  ///
  /// In en, this message translates to:
  /// **'Always laugh at your jokes 😄'**
  String get promise1;

  /// Second promise for Promise Day
  ///
  /// In en, this message translates to:
  /// **'Share my snacks (sometimes) 🍿'**
  String get promise2;

  /// Third promise for Promise Day
  ///
  /// In en, this message translates to:
  /// **'Give unlimited hugs 🤗'**
  String get promise3;

  /// Fourth promise for Promise Day
  ///
  /// In en, this message translates to:
  /// **'Love you forever ❤️'**
  String get promise4;

  /// First promise for Propose Day
  ///
  /// In en, this message translates to:
  /// **'Make you smile every day 😊'**
  String get proposePromise1;

  /// Second promise for Propose Day
  ///
  /// In en, this message translates to:
  /// **'Be your biggest supporter 💪'**
  String get proposePromise2;

  /// Third promise for Propose Day
  ///
  /// In en, this message translates to:
  /// **'Always be honest 🤝'**
  String get proposePromise3;

  /// Fourth promise for Propose Day
  ///
  /// In en, this message translates to:
  /// **'Love you unconditionally ❤️'**
  String get proposePromise4;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ne'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ne':
      return AppLocalizationsNe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
