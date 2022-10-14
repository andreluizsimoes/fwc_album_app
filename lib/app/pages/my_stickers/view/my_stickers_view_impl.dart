import 'package:flutter/widgets.dart';
import 'package:fwc_album_app/app/core/ui/helpers/loader.dart';
import 'package:fwc_album_app/app/core/ui/helpers/messages.dart';
import 'package:fwc_album_app/app/models/groups_stickers.dart';

import '../my_stickers_page.dart';
import './my_stickers_view.dart';

abstract class MyStickersViewImpl extends State<MyStickersPage>
    with Loader<MyStickersPage>, Messages<MyStickersPage>
    implements MyStickersView {
  var album = <GroupsStickers>[];
  var statusFilter = 'all';
  var countries = <String, String>{};

  @override
  void initState() {
    widget.presenter.view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showLoader();
      widget.presenter.getMyAlbum();
    });
    super.initState();
  }

  @override
  void error(String message) => showError(message);

  @override
  void loadPage(List<GroupsStickers> album) {
    setState(() {
      hideLoader();
      this.album = album;
      countries = {
        for (var c in album)
          c.countryCode:
              c.countryName, // Monta o mapa de Países com as Siglas - Nome
      };
    });
  }

  @override
  void updateStatusFilter(String status) {
    setState(() {
      statusFilter = status;
    });
  }


  @override
  void updateAlbum(List<GroupsStickers> album) {
    setState(() {
      hideLoader();
      this.album = album;      
    });
  }
}
