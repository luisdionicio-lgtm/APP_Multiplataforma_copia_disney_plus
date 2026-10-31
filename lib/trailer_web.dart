import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class TrailerEmbed extends StatefulWidget {
  final String url;
  const TrailerEmbed({super.key, required this.url});
  @override
  State<TrailerEmbed> createState() => _TrailerEmbedState();
}

class _TrailerEmbedState extends State<TrailerEmbed> {
  static int counter = 0;
  late final String viewType;
  @override
  void initState() {
    super.initState();
    viewType = 'official-trailer-${counter++}';
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (_) => web.HTMLIFrameElement()
        ..src = widget.url
        ..title = 'Tráiler oficial de Disney'
        ..allow = 'autoplay; fullscreen; picture-in-picture; encrypted-media'
        ..allowFullscreen = true
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  }

  @override
  Widget build(BuildContext context) => HtmlElementView(viewType: viewType);
}
