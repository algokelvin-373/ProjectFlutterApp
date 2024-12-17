class Localization {
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return "🇺🇸";
      case 'id':
      default:
        return "🇮🇩";
    }
  }
}
