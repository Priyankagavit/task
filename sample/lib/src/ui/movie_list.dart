import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';
import '../blocs/movie_detail_bloc_provider.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  int _page = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    bloc.fetchAllMovies(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.fetchAllMovies(++_page);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder<ItemModel>(
        stream: bloc.allMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(ItemModel data) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: data.results.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185${data.results[index].posterPath}',
              fit: BoxFit.cover,
            ),
            onTap: () => openDetailPage(data, index),
          ),
        );
      },
    );
  }

  openDetailPage(ItemModel data, int index) {
    final page = MovieDetailBlocProvider(
      child: MovieDetail(
        title: data.results[index].title,
        posterUrl: data.results[index].backdropPath,
        description: data.results[index].overview,
        releaseDate: data.results[index].releaseDate,
        voteAverage: data.results[index].voteAverage.toString(),
        movieId: data.results[index].id,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return page;
      }),
    );
  }
}
