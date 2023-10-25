import 'package:cloud_firestore/cloud_firestore.dart';
import 'musica.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> adicionarMusica(Musica musica) async {
  CollectionReference musicasCollection = firestore.collection('musicas');
  DocumentReference documentReference = await musicasCollection.add(musica.toMap());
  return documentReference.id;
}

Future<List<Musica>> listarMusicas() async {
  CollectionReference musicasCollection = firestore.collection('musicas');
  QuerySnapshot querySnapshot = await musicasCollection.get();
  return querySnapshot.docs.map((doc) => Musica.fromSnapshot(doc)).toList();
}

Future<void> atualizarMusica(Musica musica) async {
  CollectionReference musicasCollection = firestore.collection('musicas');
  await musicasCollection.doc(musica.id).update(musica.toMap());
}

Future<void> deletarMusica(String id) async {
  CollectionReference musicasCollection = firestore.collection('musicas');
  await musicasCollection.doc(id).delete();
}