class TrailerModel {
  final int id;
  final List<Result> results;

  TrailerModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        results = (parsedJson['results'] as List<dynamic>?)
                ?.map((result) => Result.fromJson(result))
                .toList() ??
            <Result>[];
}

class Result {
  final String id;
  final String iso6391;
  final String iso31661;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Result.fromJson(Map<String, dynamic> result)
      : id = result['id'],
        iso6391 = result['iso_639_1'],
        iso31661 = result['iso_3166_1'],
        key = result['key'],
        name = result['name'],
        site = result['site'],
        size = result['size'],
        type = result['type'];
}
