import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';

class movieDetail extends StatelessWidget {
  final String movieCd;
  movieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(apiKey: '01736d1cbc4c7f3e45f3f5f6354d4e12');
  @override
  Widget build(BuildContext context) {
    kobisApi.getMovieDetial(movieCd: movieCd);


    return  Scaffold(
      body: Text(movieCd),
    );
  }
}