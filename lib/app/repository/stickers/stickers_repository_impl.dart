// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fwc_album_app/app/core/exceptions/repository_exception.dart';
import 'package:fwc_album_app/app/core/rest/custom_dio.dart';
import 'package:fwc_album_app/app/models/groups_stickers.dart';
import 'package:fwc_album_app/app/models/register_sticker_model.dart';
import 'package:fwc_album_app/app/models/sticker_model.dart';

import './stickers_repository.dart';

class StickersRepositoryImpl implements StickersRepository {
  final CustomDio dio;

  StickersRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<GroupsStickers>> getMyAlbum() async {
    try {
      final result = await dio.auth().get('/api/countries');
      return result.data
          .map<GroupsStickers>((g) => GroupsStickers.fromMap(g))
          .toList();
    } on DioError catch (e, s) {
      log('Erro do buscar album do usuario', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro do buscar álbum do usuário');
    }
  }

  @override
  Future<StickerModel?> findStickerByCode(
      String stickerCode, String stickerNumber) async {
    try {
      final result = await dio.auth().get('/api/sticker-search',
          queryParameters: {
            'sticker_code': stickerCode,
            'sticker_number': stickerNumber
          });
      return StickerModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      log('Erro ao buscar Figurinha', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar Figurinha');
    }
  }

  @override
  Future<StickerModel> create(RegisterStickerModel registerStickerModel) async {
    try {
      final body = FormData.fromMap({
        ...registerStickerModel.toMap(),
        'sticker_image_upload': '',
      });
      final result = await dio.auth().post('/api/sticker', data: body);
      return StickerModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log('Erro ao registrar figurinha', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar figurinha');
    }
  }

  @override
  Future<void> registerUserSticker(int stickerId, int amount) async {
    try {
      await dio.auth().post('/api/user/sticker', data: {
        'id_sticker': stickerId,
        'amount': amount,
      });
    } on DioError catch (e, s) {
      log('Nao foi possivel inserir a figurinha no album do usuario',
          error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Nao foi possivel inserir a figurinha no album');
    }
  }

  @override
  Future<void> updateUserSticker(int stickerId, int amount) async {
    try {
      await dio.auth().put('/api/user/sticker', data: {
        'id_sticker': stickerId,
        'amount': amount,
      });
    } on DioError catch (e, s) {
      log('Nao foi possivel inserir a figurinha no album do usuario',
          error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Nao foi possivel inserir a figurinha no album');
    }
  }
}
