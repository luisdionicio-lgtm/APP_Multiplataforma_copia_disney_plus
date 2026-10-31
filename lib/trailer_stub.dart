import 'package:flutter/material.dart';

class TrailerEmbed extends StatelessWidget {
  final String url;
  const TrailerEmbed({super.key, required this.url});
  @override
  Widget build(BuildContext context) => const Center(
    child: Text('Abre el tráiler oficial con el botón inferior.'),
  );
}
