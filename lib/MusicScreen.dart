import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;
  int currentTrackIndex = 0;

  final Map<int, String> musicImages = {
    0: 'assets/image/music1.png',
    1: 'assets/image/music2.png',
  };

  String currentMusicImage = 'assets/image/music1.png';

  // Defina as dimensões desejadas para as imagens
  double larguraImagem = 200;
  double alturaImagem = 200;

  @override
  void initState() {
    super.initState();

    assetsAudioPlayer.open(
      Playlist(audios: [
        Audio('assets/music/musica1.mp3'),
        Audio('assets/music/musica2.mp3'),
      ]),
      autoStart: false,
      loopMode: LoopMode.playlist,
    );

    // Inicialmente, defina a imagem para a primeira música
    currentMusicImage = musicImages[0] ?? 'assets/image/music1.png';

    // Adicione um ouvinte para detectar quando a faixa de música atual muda
    assetsAudioPlayer.current.listen((event) {
      if (event != null) {
        setState(() {
          currentTrackIndex = event.index;
          currentMusicImage = musicImages[currentTrackIndex] ??
              'assets/image/music2.png';
        });
      }
    });
  }

  void togglePlayPause() {
    if (isPlaying) {
      assetsAudioPlayer.pause();
    } else {
      assetsAudioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void playNextTrack() {
    assetsAudioPlayer.next();
  }

  void playPreviousTrack() {
    assetsAudioPlayer.previous();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.asset(
            currentMusicImage,
            width: 500,
            height: 450,
            fit: BoxFit.cover, // Ajuste de dimensionamento
          ),
          Positioned(
            top: 480,
            left: 180,
            right: 160,
            child: Container(
              width: 400,
              height: 200,
              color: Colors.white,
              child: Text(
                "Sweet Dreams", // Substitua pelo nome da música atual
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: () {
                        playPreviousTrack();
                      },
                    ),
                    IconButton(
                      icon: isPlaying
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow),
                      onPressed: () {
                        togglePlayPause();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () {
                        playNextTrack();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }
}
