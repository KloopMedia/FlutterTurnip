// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:just_audio/just_audio.dart';
//
// CustomRenderMatcher audioMatcher() => (context) {
//       return context.tree.element?.localName == "audio";
//     };
//
// class SimpleAudioPlayer extends StatefulWidget {
//   final RenderContext context;
//
//   const SimpleAudioPlayer({Key? key, required this.context}) : super(key: key);
//
//   @override
//   State<SimpleAudioPlayer> createState() => _SimpleAudioPlayerState();
// }
//
// class _SimpleAudioPlayerState extends State<SimpleAudioPlayer> {
//   late AudioPlayer player = AudioPlayer();
//   bool isPlaying = false;
//
//   @override
//   void initState() {
//     player.setUrl(widget.context.tree.element?.attributes['src'] ?? '');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         if (isPlaying) {
//           player.pause();
//         } else {
//           player.play();
//         }
//         setState(() {
//           isPlaying = !isPlaying;
//         });
//       },
//       icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
//     );
//   }
// }
