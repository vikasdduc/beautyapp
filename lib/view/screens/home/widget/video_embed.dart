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
    RegExp regExp = RegExp(r"/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/",
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "What Celebrities Say ",
            style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
    );
  }
}
