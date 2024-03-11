class ImagePath {
  static const appIcon = 'assets/images/new_app_icon.png';
  static const appIconText = 'assets/images/new_app_icon_text.png';
  static const errorImage = 'assets/images/mark_question.png';
  static const soldOutImage = 'assets/images/sold_out.png';
  static const tradingImage = 'assets/images/trading.png';
  static const toggleTrue = 'assets/images/toggle_true.png';
  static const toggleFalse = 'assets/images/toggle_false.png';
  static String toggle(bool isSold) => isSold ? toggleTrue : toggleFalse;
}
