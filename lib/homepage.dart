import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomePage extends StatefulWidget {
  final city;
  final country;
  final temp;
  final desc;
  final iconID;
  HomePage(this.city,this.country,this.temp,this.desc,this.iconID);
  @override
  _HomePageState createState() => _HomePageState(iconID);
}

class _HomePageState extends State<HomePage> {
  final iconImageId;
  _HomePageState(this.iconImageId);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Container(

        decoration: BoxDecoration(
          color: Color.fromRGBO(205, 120, 241, 0.5),
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.fill,
          ),
//          color: Color.fromRGBO(205, 120, 241, .5),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Color(0xff343d46),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient:SweepGradient(
                  tileMode: TileMode.mirror,
                  startAngle: 0.0,
                  endAngle: 1.5,
                  center: Alignment.bottomLeft,
                  colors: [
                    Colors.black12,
                    Colors.blue[200]
                  ]
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(15.0),
              ),

              width: MediaQuery.of(context).size.width/1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:50.0),
                    child: Text(widget.city,textAlign:TextAlign.center,style: TextStyle(fontSize: 50.0,color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(widget.country,style:TextStyle(fontSize: 28.0,color: Colors.white),),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.temp.toString()+"°",style: TextStyle(fontSize: 60.0,color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.only(bottom:15.0,left: 10.0),
                        child: iconImageId=="Error"? Text("Error"): Image.network("http://openweathermap.org/img/w/$iconImageId.png"),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(widget.desc,style: TextStyle(fontSize: 22.0,color: Colors.white),),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0),
              child: RaisedButton(
                color: Colors.white,
                child: Text("Search for other cities"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
