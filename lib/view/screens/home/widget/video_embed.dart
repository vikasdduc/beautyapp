import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoEmbed extends StatefulWidget {
  final String url;
  const VideoEmbed({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoEmbed> createState() => _VideoEmbedState();
}

class _VideoEmbedState extends State<VideoEmbed> {
  late YoutubePlayerController _controller;
  bool autoPlay = false;

  String urlParser(String url) {
    RegExp regExp = RegExp(
      r"/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/",
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.stringMatch(url).toString();
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        loop: true,
        mute: true,
        showControls: false,
      ),
    )..onInit = () {
        if (autoPlay) {
          _controller.loadVideoByUrl(mediaContentUrl: widget.url);
        } else {
          _controller.cueVideoByUrl(mediaContentUrl: widget.url);
        }
      };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const  Padding(
            padding:  EdgeInsets.symmetric(vertical: 18),
            child: Text(
              " Thoughtful Curations",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: YoutubePlayerControllerProvider(
              controller: _controller,
              child: YoutubePlayer(
                aspectRatio: 16 / 9,
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
