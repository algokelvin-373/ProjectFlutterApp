class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? quoteId;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        quoteId = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        quoteId = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        quoteId = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        quoteId = null;

  PageConfiguration.detailQuote(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        quoteId = id;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        quoteId = null;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      quoteId == null;

  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      quoteId == null;

  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      quoteId == null;

  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      quoteId == null;

  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      quoteId != null;

  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      quoteId == null;
}
