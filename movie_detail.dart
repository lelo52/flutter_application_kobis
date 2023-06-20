import 'package:flutter/material.dart';
import 'package:flutter_application_kobis/kobis_api.dart';
import 'package:flutter_application_kobis/movie_detail_view.dart';

class MovieDetail extends StatelessWidget {
  final String movieCd;
  MovieDetail({super.key, required this.movieCd});
  var kobisApi = KobisApi(apiKey: '01736d1cbc4c7f3e45f3f5f6354d4e12');
  @override
  Widget build(BuildContext context) {
    var movieData =  kobisApi.getMovieDetial(movieCd: movieCd);


    return  Scaffold(
      body:FutureBuilder(
        future: movieData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var movie = snapshot.data;
            return MovieDetailView(movie: movie);
          }else {
            var msg = '데이터 로드중입니다...';
            return Center(child: Text(msg),);
          }
        },
        ),
    );
  }
}