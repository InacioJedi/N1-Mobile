import 'package:cloud_firestore/cloud_firestore.dart';

class Musica {
  String id;
  String musica;
  String artista;

  Musica({required this.id, required this.musica, required this.artista});

  Map<String, dynamic> toMap() {
    return {
      'musica': musica,
      'artista': artista,
    };
  }

  Musica.fromSnapshot(DocumentSnapshot snapshot) :
        id = snapshot.id,
        musica = snapshot['musica'],
        artista = snapshot['artista'];
}