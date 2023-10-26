import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_service.dart';

class AddMusicScreen extends StatefulWidget {
  @override
  _AddMusicScreenState createState() => _AddMusicScreenState();
}

class _AddMusicScreenState extends State<AddMusicScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  String mensagem = "";

  // Lista local para armazenar músicas
  List<String> musicList = [];

  Future<void> adicionarMusica() async {
    final titulo = titleController.text;
    final artista = artistController.text;

    // Adicione a lógica para adicionar a música à lista (por exemplo, ao Firestore).

    // Exemplo de adicionar a música (substitua por sua lógica real):
    await FirebaseFirestore.instance.collection('musicas').add({
      'titulo': titulo,
      'artista': artista,
    });

    // Após adicionar a música, atualize a lista
    listarMusicas();

    // Atualize a mensagem de confirmação.
    setState(() {
      mensagem = "Música adicionada!";
    });

    // Após um breve atraso, limpe a mensagem e redirecione o usuário.
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mensagem = "";
      });
      Navigator.pushNamed(context, '/list_music');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Música'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título da Música'),
              ),
              TextField(
                controller: artistController,
                decoration: InputDecoration(labelText: 'Artista'),
              ),
              ElevatedButton(
                onPressed: adicionarMusica,
                child: Text('Adicionar Música'),
              ),
              Text(
                mensagem,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
