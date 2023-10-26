import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListMusicScreen extends StatefulWidget {
  @override
  _ListMusicScreenState createState() => _ListMusicScreenState();
}

class _ListMusicScreenState extends State<ListMusicScreen> {
  List<String> musicList = [];

  @override
  void initState() {
    super.initState();
    listarMusicas();
  }

  void listarMusicas() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('musicas').get();
    final List<String> titles = querySnapshot.docs.map((doc) => doc['titulo'].toString()).toList();
    setState(() {
      musicList = titles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Músicas'),
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(musicList[index]),
          );
        },
      ),
    );
  }
}
