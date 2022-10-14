import '../../../models/groups_stickers.dart';

abstract class MyStickersView {
  void loadPage(List<GroupsStickers> album);
  void error(String message);
  void updateStatusFilter(String status);
  void updateAlbum(List<GroupsStickers> album);
}
