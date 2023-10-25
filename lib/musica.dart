import 'package:cloud_firestore/cloud_firestore.dart';

class Musica {
  String id;
  String titulo;
  String artista;

  Musica({required this.id, required this.titulo, required this.artista});

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'artista': artista,
    };
  }

  Musica.fromSnapshot(DocumentSnapshot snapshot) :
        id = snapshot.id,
        titulo = snapshot['titulo'],
        artista = snapshot['artista'];
}