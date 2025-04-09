class AppRegex {
  static final RegExp numberOnlyFilter = RegExp(r'[\d]');
  static final RegExp alphabetSpaceFilter = RegExp(r'[a-zA-Z ]');
  static final alphabetNumberSpaceFilter = RegExp(r'[a-zA-Z0-9 ]');
  static final RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  static RegExp emoji = RegExp(
      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
}
