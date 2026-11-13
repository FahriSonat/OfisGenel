class AppRoutes {
  AppRoutes._();

  static const String initialRoute = '/space/mentor';

  static const String spaceRole = '/space/:role';
  static const String aiChat = '/space/:role/ai-chat';
  static const String files = '/space/:role/files';
  static const String chat = '/space/:role/chat';
  static const String meetings = '/space/:role/meetings';
  static const String booking = '/space/:role/booking/:serviceType';
  static const String programDetail = '/programs/:slug';
  static const String startups = '/startups';
  static const String investorStartups = '/space/investor/startups';

  static String spacePath(String role) => '/space/$role';
  static String aiChatPath(String role) => '/space/$role/ai-chat';
  static String filesPath(String role) => '/space/$role/files';
  static String chatPath(String role) => '/space/$role/chat';
  static String meetingsPath(String role) => '/space/$role/meetings';
  static String bookingPath(String role, String serviceType) =>
      '/space/$role/booking/$serviceType';
  static String programDetailPath(String slug) => '/programs/$slug';
  static String startupsPath() => '/startups';
  static String investorStartupsPath() => '/space/investor/startups';
}
