import 'package:fwc_album_app/app/models/sticker_model.dart';
import 'package:fwc_album_app/app/models/user_sticker_model.dart';
import 'package:fwc_album_app/app/pages/sticker_detail/view/sticker_detail_view.dart';
import 'package:fwc_album_app/app/repository/stickers/stickers_repository.dart';
import 'package:fwc_album_app/app/services/sticker/find_sticker_service.dart';

import './sticker_detail_presenter.dart';

class StickerDetailPresenterImpl implements StickerDetailPresenter {
  late final StickerDetailView _view;
  final FindStickerService findStickerService;
  final StickersRepository stickersRepository;
  UserStickerModel? stickerUser; // Figurinha do usuário
  StickerModel? sticker; // Figurinha geral
  int amount = 0;

  StickerDetailPresenterImpl(
      {required this.findStickerService, required this.stickersRepository});

  @override
  set view(StickerDetailView view) => _view = view;

  @override
  Future<void> load({
    required String countryCode,
    required String stickerNumber,
    required String countryName,
    UserStickerModel? stickerUser,
  }) async {
    this.stickerUser = stickerUser;

    if (stickerUser == null) {
      sticker = await findStickerService.execute(countryCode, stickerNumber);
    }

    bool hasSticker = stickerUser != null;

    if (hasSticker) {
      amount = stickerUser.duplicate + 1;
    }

    _view.screenLoaded(
        hasSticker, countryCode, stickerNumber, countryName, amount);
  }

  @override
  void decrementAmount() {
    if (amount > 1) {
      _view.updateAmount(--amount);
    }
  }

  @override
  void incrementAmount() {
    _view.updateAmount(++amount);
  }

  @override
  Future<void> saveSticker() async {
    try {
      _view.showLoader();
      if (stickerUser == null) {
        //Registrar figurinha
        await stickersRepository.registerUserSticker(sticker!.id, amount);
      } else {
        // Atualizar figurinha
        await stickersRepository.updateUserSticker(
            stickerUser!.idSticker, amount);
      }
      _view.saveSucess();
    } catch (e) {
      _view.error('Erro ao cadastrar ou atualizar figurinha');
    }
  }

  @override
  Future<void> deleteSticker() async {
    _view.showLoader();
    if (stickerUser != null) {
      await stickersRepository.updateUserSticker(stickerUser!.idSticker, 0);
    }

    _view.saveSucess();
  }
}
