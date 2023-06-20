import 'package:flutter/material.dart';
import 'kobis_api.dart';
import 'movie_detail.dart';
class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final kobisApi = KobisApi(apiKey: '01736d1cbc4c7f3e45f3f5f6354d4e12');
  dynamic bodyPage = Center(child: Text('!MOVIES!'));
  void showCal() async {
    var dt = await showDatePicker(context: context, 
    initialDate: DateTime.now().subtract(const Duration(days: 1)), 
    firstDate: DateTime(2022), 
    lastDate: DateTime.now().subtract(const Duration(days: 1))
    );
    if(dt !=null){
      //2022-02-02 00:00:00
      var targetDt = dt.toString().split(' ')[0].replaceAll('-', '');
      var movies = kobisApi.getDailyBoxOffice(targetDt: targetDt);
      showList(movies);
    }
  }

  void showList(Future<List<dynamic>> movies) { //결과를 보여줄 곳
    setState(() {
      bodyPage = FutureBuilder(future: movies , builder: (context, snapshot) {
        if(snapshot.hasData) {
          //데이터가 넘어옴
          var moviesData = snapshot.data;

          return ListView.separated(
            itemBuilder: (context, index) {
              var rankColor = Colors.black;
              if(index==0){
                rankColor = Colors.red;
              }else if (index==1){
                rankColor = Colors.blue;
              }else if (index==2){
                rankColor = Colors.green;
              }
              var movie = moviesData[index]; //이걸로 바꿔서 써도 상관없음
              return ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: rankColor,borderRadius: BorderRadius.circular(8)),
                  child: Text(moviesData[index]['rank']+'위',style: TextStyle(fontSize: 30,color: Colors.white),),
                ),
                title: Text(moviesData[index]['movieNm']),
                subtitle: Text('관객수 : ${moviesData[index]['audiAcc']}명'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetail(movieCd:moviesData[index]['movieCd']),)),
              );
            }, 
            separatorBuilder: (context, index) => Divider(), 
            itemCount: moviesData!.length
          );
        }else{
          //loading...
          return Center(child: const CircularProgressIndicator(color: Colors.pink,));
        }
      },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyPage,
      floatingActionButton: FloatingActionButton(onPressed: showCal, child: Icon(Icons.calendar_month),),
    );
  }
}