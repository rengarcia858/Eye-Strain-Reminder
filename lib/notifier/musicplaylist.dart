import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);
  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  List musicList = [
    {
      "title": "Grand Escape",
      "artist": "Radwimps",
      "cover":
          "https://images.genius.com/b090dcf6ba550622628162dd9ece4082.1000x1000x1.jpg",
      "url":
          "https://github.com/rengarcia858/music_player/raw/main/Grand_Escape.mp3",
    },
    {
      "title": "Orange",
      "artist": "7!!",
      "cover": "https://japanpowered.com/media/images/your-lie-in-april-2.jpg",
      "url": "https://github.com/rengarcia858/music_player/raw/main/Orange.mp3",
    },
    {
      "title": "River Flows in You",
      "artist": "Yiruma",
      "cover":
          "https://2.bp.blogspot.com/-IjH249fxds0/XLJRtTZIW9I/AAAAAAAANIA/sOxT4iwAejoeBvvteQfbMQpUzIsqi2m3gCLcBGAs/s1600/Yiruma.jpg",
      "url":
          "https://github.com/rengarcia858/music_player/raw/main/River_Flows_in_You.mp3",
    },
    {
      "title": "Sparkle",
      "artist": "Radwimps",
      "cover":
          "https://i1.sndcdn.com/artworks-000198662700-kmpx60-t500x500.jpg",
      "url":
          "https://github.com/rengarcia858/music_player/raw/main/Sparkle.mp3",
    },
    {
      "title": "To The Bone",
      "artist": "Pamungkas",
      "cover":
          "https://i1.sndcdn.com/artworks-lDeecbbySI2e70Ym-UhD4Kg-t500x500.jpg",
      "url":
          "https://github.com/rengarcia858/music_player/raw/main/To_The_Bone.mp3",
    },
  ];

  String currentTitle = "";
  String currentArtist = "";
  String currentCover = "";
  String currentSong = "";

  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  Duration musicDuration = Duration.zero;
  Duration musicPosition = Duration.zero;

  @override
  void initState() {
    super.initState();

    /// Listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    /// Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        musicDuration = newDuration;
      });
    });

    /// Listen to audio position
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        musicPosition = newPosition;
      });
    });
  }

  void disPose() {
    audioPlayer.dispose();
    audioPlayer.stop();
    audioPlayer.release();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final mins = twoDigits(duration.inMinutes.remainder(60));
    final secs = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      mins,
      secs,
    ].join(':');
  }

  Future notification() async {
    return audioPlayer.notificationService.setNotification(
      title: currentTitle,
      artist: currentArtist,
      imageUrl: currentCover,
      forwardSkipInterval: const Duration(seconds: 10),
      backwardSkipInterval: const Duration(seconds: 10),
      enableNextTrackButton: true,
      enablePreviousTrackButton: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music Playlist',
          style: GoogleFonts.cormorantGaramond(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color(0xff757c88),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff3C415C),
              Color(0xff232323),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 22.0,
                  right: 22.0,
                  top: 15.0,
                  bottom: 15.0,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: musicList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      audioPlayer.play(musicList[index]["url"]);
                      setState(() async {
                        currentTitle = musicList[index]["title"];
                        currentArtist = musicList[index]["artist"];
                        currentCover = musicList[index]["cover"];
                        notification();
                      });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          musicList[index]["cover"],
                        ),
                      ),
                      title: Text(
                        musicList[index]["title"],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        musicList[index]["artist"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      trailing: Container(
                        margin: const EdgeInsets.all(17.0),
                        child: Icon(
                          Icons.music_note,
                          color: Colors.blueGrey.shade200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(currentCover),
                    ),
                    title: Text(
                      currentTitle,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      currentArtist,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    trailing: Container(
                      height: 40.0,
                      width: 40.0,
                      margin: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            if (isPlaying) {
                              await audioPlayer.pause();
                              await audioPlayer.notificationService.clearNotification();
                            } else {
                              await audioPlayer.resume();
                            }
                          },
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 26, color: Colors.white)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 22.0,
                      right: 30.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(musicPosition),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            )),
                        Expanded(
                          child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            min: 0,
                            value: musicPosition.inSeconds.toDouble(),
                            max: musicDuration.inSeconds.toDouble(),
                            onChanged: (val) async {
                              final position = Duration(seconds: val.toInt());
                              await audioPlayer.seek(position);
                              await audioPlayer.resume();
                            },
                          ),
                        ),
                        Text(formatTime(musicDuration - musicPosition),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
