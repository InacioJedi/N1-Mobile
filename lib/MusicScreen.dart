import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';
import 'add_music_screen.dart';
import 'list_music_screen.dart';

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

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  List<Musica> musicList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  late String selectedMusicId;

  @override
  void initState() {
    super.initState();
    loadMusicList();
  }

  void loadMusicList() async {
    List<Musica> musicas = await listarMusicas();
    setState(() {
      musicList = musicas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Músicas'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_music');
            },
            child: Text('Adicionar Música'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/list_music');
            },
            child: Text('Listar Músicas'),
          ),
          Text('Lista de Músicas:'),
          Expanded(
            child: ListView.builder(
              itemCount: musicList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(musicList[index].musica),
                  subtitle: Text(musicList[index].artista),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deletarMusica(musicList[index].id);
                      loadMusicList();
                    },
                  ),
                  onTap: () {
                    setState(() {
                      selectedMusicId = musicList[index].id;
                      titleController.text = musicList[index].musica;
                      artistController.text = musicList[index].artista;
                    });
                  },
                );
              },
            ),
          ),
          Divider(),
          Text('Adicionar/Editar Música:'),
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Música'),
          ),
          TextField(
            controller: artistController,
            decoration: InputDecoration(labelText: 'Artista'),
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedMusicId == false) {
                adicionarMusica(Musica(
                  musica: titleController.text,
                  artista: artistController.text,
                  id: '',
                ));
              } else {
                atualizarMusica(Musica(
                  id: selectedMusicId,
                  musica: titleController.text,
                  artista: artistController.text,
                ));
              }
              loadMusicList();
              titleController.clear();
              artistController.clear();
              selectedMusicId = ''; // Atribuição de null
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarMusica(String titulo, String artista) async {
    await _firestore.collection('musicas').add({
      'titulo': titulo,
      'artista': artista,
    });
  }

  Future<List<Map<String, dynamic>> > listarMusicas() async {
    QuerySnapshot querySnapshot = await _firestore.collection('musicas').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Music App',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MusicScreen(),
        '/add_music': (context) => AddMusicScreen(),
        '/list_music': (context) => ListMusicScreen(),
      },
    );
  }
}
