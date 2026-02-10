import 'package:flutter/material.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Willkommen auf dem Playlist Screen',
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }
}