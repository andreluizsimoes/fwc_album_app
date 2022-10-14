abstract class StickerDetailView {
  void screenLoaded(
    bool hasSticker,
    String countryCode,
    String stickerNumber,
    String countryName,
    int amount,
  );

  void updateAmount(int i);

  void showLoader();

  void saveSucess();

  void error(String s);
}
