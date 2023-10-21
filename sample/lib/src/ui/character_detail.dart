import 'package:flutter/material.dart';
import '../blocs/character_detail_bloc.dart';
import '../models/characters_model.dart';

class CharacterDetail extends StatefulWidget {
  final Results data;

  const CharacterDetail({super.key, required this.data});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends State<CharacterDetail> {
  late final blocDetails = CharacterDetailBloc();
  CharacterDetailState();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    blocDetails.fetchCharactersById(widget.data.id ?? 0);
  }

  @override
  void dispose() {
    blocDetails.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Character Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.data.name ?? 'Loading...',
              style: const TextStyle(fontSize: 20),
            ),
            Image.network(widget.data.image ?? ''),
            if ((widget.data.status ?? '') == 'Dead')
              Container(
                color: Colors.red,
                child: Text(
                  widget.data.status ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            if ((widget.data.status ?? '') == 'Alive')
              Container(
                color: Colors.green,
                child: Text(
                  widget.data.status ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            if ((widget.data.status ?? '') != 'Dead' &&
                (widget.data.status ?? '') != 'Alive')
              Container(
                color: Colors.grey,
                child: Text(
                  widget.data.status ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            Column(
              children: <Widget>[
                Text('Gender: ${widget.data.gender}'),
                Text('Location: ${widget.data.location}'),
                Text('Origin: ${widget.data.origin}'),
                Text('Species: ${widget.data.species}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
