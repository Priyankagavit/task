import 'package:flutter/material.dart';
import '../models/characters_model.dart';
import '../blocs/characters_bloc.dart';
import 'character_detail.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharactersListState();
  }
}

class CharactersListState extends State<CharactersList> {
  int _page = 1;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    bloc.fetchAllCharacters(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.fetchAllCharacters(++_page);
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
        title: const Text('Characters'),
      ),
      body: StreamBuilder<CharactersModel>(
        stream: bloc.allCharacters,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(CharactersModel data) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: data.results?.length,
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () => openDetailPage(data, index),
            child: CharacterTile(data: data.results![index]));
      },
    );
  }

  openDetailPage(CharactersModel data, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CharacterDetail(
          data: data.results![index],
        );
      }),
    );
  }
}

class CharacterTile extends StatelessWidget {
  final Results data;
  const CharacterTile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          title: Text(
            data.name ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            data.status ?? '',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        child: Image.network(
          data.image ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
