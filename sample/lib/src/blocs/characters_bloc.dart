import 'package:rxdart/rxdart.dart';

import '../models/characters_model.dart';
import '../resources/repository.dart';

class CharactersBloc {
  final _repository = Repository();
  final _charactersFetcher = BehaviorSubject<CharactersModel>();
  int totalPages = 1;

  Stream<CharactersModel> get allCharacters => _charactersFetcher.stream;

  fetchAllCharacters(int page) async {
    if (page <= totalPages) {
      CharactersModel itemModel = await _repository.fetchAllCharacters(page);
      if (_charactersFetcher.hasValue == false) {
        totalPages = itemModel.info?.pages ?? 0;
        _charactersFetcher.sink.add(itemModel);
      } else {
        if ((itemModel.results != null && itemModel.results!.isNotEmpty)) {
          _charactersFetcher.value.results?.addAll(itemModel.results!);
          _charactersFetcher.sink.add(_charactersFetcher.value);
        }
      }
    }
  }

  dispose() {
    _charactersFetcher.close();
  }
}

final bloc = CharactersBloc();
