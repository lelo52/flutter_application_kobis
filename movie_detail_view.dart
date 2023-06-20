import 'dart:html';

import 'package:flutter/material.dart';
class MovieDetailView extends StatelessWidget {
  Map<String, dynamic> movie;
  MovieDetailView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${movie['movieNm']}(${movie['prdtYear']})')
      ],
    );
  }
}

