import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/character_detail_model.dart';
import '../resources/repository.dart';

class CharacterDetailBloc {
  final _repository = Repository();
  final _characterId = PublishSubject<int>();
  final _character = BehaviorSubject<Future<CharacterDetailModel>>();

  Function(int) get fetchCharactersById => _characterId.sink.add;
  Stream<Future<CharacterDetailModel>> get characters => _character.stream;

  CharacterDetailBloc() {
    _characterId.stream.transform(_itemTransformer()).pipe(_character);
  }

  dispose() async {
    _characterId.close();
    await _character.drain();
    _character.close();
  }

  StreamTransformer<int, Future<CharacterDetailModel>> _itemTransformer() {
    return StreamTransformer<int, Future<CharacterDetailModel>>.fromHandlers(
      handleData: (int id, EventSink<Future<CharacterDetailModel>> sink) {
        final trailer = _repository.fetchCharacterDetails(id);
        sink.add(trailer);
      },
    );
  }
}
