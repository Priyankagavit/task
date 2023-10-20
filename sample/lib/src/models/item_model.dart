class ItemModel {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Result> results;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : page = parsedJson['page'] ?? 0,
        totalResults = parsedJson['total_results'] ?? 0,
        totalPages = parsedJson['total_pages'] ?? 0,
        results = (parsedJson['results'] as List<dynamic>?)
                ?.map((result) => Result.fromJson(result))
                .toList() ??
            <Result>[];
}

class Result {
  final int voteCount;
  final int id;
  final bool video;
  final String voteAverage;
  final String title;
  final double popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  Result.fromJson(Map<String, dynamic> result)
      : voteCount = result['vote_count'] ?? 0,
        id = result['id'] ?? 0,
        video = result['video'] ?? false,
        voteAverage = result['vote_average']?.toString() ?? '0.0',
        title = result['title'] ?? '',
        popularity = result['popularity'] ?? 0.0,
        posterPath = result['poster_path'] ?? '',
        originalLanguage = result['original_language'] ?? '',
        originalTitle = result['original_title'] ?? '',
        genreIds = (result['genre_ids'] as List<dynamic>?)
                ?.map((id) => id as int)
                .toList() ??
            <int>[],
        backdropPath = result['backdrop_path'] ?? '',
        adult = result['adult'] ?? false,
        overview = result['overview'] ?? '',
        releaseDate = result['release_date'] ?? '';
}
