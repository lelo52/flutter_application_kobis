import 'dart:convert';

import 'package:http/http.dart' as http;

class KobisApi{
  final String apiKey;
  final String _site ='http://www.kobis.or.kr/kobisopenapi/webservice/rest';
  KobisApi({required this.apiKey});

  Future<List<dynamic>> getDailyBoxOffice({required String targetDt}) async {
    var uri = '$_site/boxoffice/searchDailyBoxOfficeList.json';
    uri = '$uri?key=$apiKey';
    uri ='$uri&targetDt=$targetDt';

    var reponse = await http.get(Uri.parse(uri));
    if(reponse.statusCode == 200){
      //comm
      print(reponse.body);
      try{
      var movies = jsonDecode(reponse.body)['boxOfficeResult']['dailyBoxOfficeList'] as List<dynamic>;
      return movies;
      }catch(e){
        return [];
      }
    }else {
      //error
      return [];
    }

  }

  Future<List<dynamic>> getMovieDetial({required String movieCd}) async {
    var uri = '$_site/movie/searchMovieInfo.json';
    uri = '$uri?key=$apiKey';
    uri = '$uri&movieCd=$movieCd';
    var reponse = await http.get(Uri.parse(uri));
    if(reponse.statusCode == 200){
      //comm
      print(reponse.body);
      try{
      var movie = jsonDecode(reponse.body)['movieInfoResult']['movieInfo'] as dynamic; //Map<String dynamic>
      print(movie['movieNm']);
      return movie;
      }catch(e){
        return [];
      }
    }else {
      //error
      return [];
    }
  }

}