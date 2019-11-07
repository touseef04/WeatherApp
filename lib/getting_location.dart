import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/homepage.dart';
import 'package:weather_app/search_cities.dart';

const apiKey = 'efee6fac01cb27cd2bb22f22e8e20d6f';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  var longitude;
  var latitude;

  var addLongitude;
  var addLatitude;
  var cityName="Enter your city name";

  void getLocationFromAddress(city) async{
    print("Getting location from from address");
    List<Placemark> placemark = await Geolocator().placemarkFromAddress(city);
   addLatitude= placemark[0].position.latitude;
   addLongitude=placemark[0].position.longitude;

   print(addLongitude);
   print(addLatitude);
   print(placemark[0].country);
   getWeatherData(addLatitude,addLongitude);


  }
    void getLocation() async {
    print("Getting your location");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    print(position);
    longitude = position.longitude;
    latitude = position.latitude;
    getWeatherData(latitude,longitude);
  }

  void getWeatherData(lat, lon) async {
    //if(latitude!=null && longitude!=null) {
      try {
        http.Response response = await http.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
        );
        if (response.statusCode == 200) {
          var weatherData = response.body;
          var decodedWeatherData = jsonDecode(weatherData);
          String cityName = decodedWeatherData['name'];
          String countryName = decodedWeatherData['sys']['country'];
          int temperature = decodedWeatherData['main']['temp'].toInt();
          String description = decodedWeatherData['weather'][0]['main'];
          String iconImageID = decodedWeatherData['weather'][0]['icon'];
          print(cityName);
          print(countryName);
          print(temperature);
          print(description);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage(cityName, countryName, temperature, description,
                          iconImageID)));
        }
      } catch (exception) {
        print(exception);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            HomePage("Unknown", "Unknown", 0, "Check your internet connection",
                "Error")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: Container(

        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.25),
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
                fit: BoxFit.cover,
          )
        ),
        child: //Center(child: CircularProgressIndicator()),
        ListView(
          children:<Widget>[ Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top:30.0,bottom: 10.0),
                  width: MediaQuery.of(context).size.width/1.2,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),

                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Icon(Icons.search,size: 30.0,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text(cityName,style: TextStyle(fontSize: 20.0),),
                      ),
                    ],
                  ),
                ),
                onTap: () async{
                  var selectedCity=await showSearch(context: context, delegate: CitySearchDelegate());
                  if(selectedCity!=null)
                    {
                      setState(() {
                        cityName=selectedCity;
                      });
                    }

                },
              ),

              Container(
                  height: 350.0,
                width: 250.0,
                color: Colors.transparent,
                child: Carousel(
                  //autoplayDuration:Duration(microseconds: 1),
                 // animationDuration: Duration(microseconds: 100),
                  boxFit: BoxFit.fill,
                  showIndicator: false,
                  animationCurve:Curves.decelerate,

                  images: [
                    Image.asset("images/rain.png"),
                    Image.asset("images/sun.png"),
                    Image.asset("images/snow.png"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: RaisedButton(
                  onPressed: (){
                   print(cityName);
                   if(cityName!="Enter your city name") {
                     getLocationFromAddress(cityName);
                     cityName="Enter your city name";
                   }
                   //Fluttertoast.showToast(msg: "Plese enter city name",gravity: ToastGravity.CENTER);
                    // TODO: show an alert dialog "Please enter a valid location"..
                  else if(cityName=="Enter your city name") {
                     showDialog(context: context,
                         builder: (BuildContext context) {
                           return AlertDialog(title: Text("Error"),
                             content: Text(
                               "Please enter city name", style: TextStyle(
                                 fontSize: 18.0),),
                             actions: <Widget>[
                               FlatButton(
                                 child: Text("Ok", style: TextStyle(
                                     color: Colors.blueAccent, fontSize: 20.0),),
                                 onPressed: () {
                                   Navigator.pop(context);
                                 },
                               )
                             ],

                           );
                         }
                     );
                   }
                  },
                  child: Text("Get Weather"),
                ),
              ),
             Padding(
               padding: const EdgeInsets.only(top:10.0),
               child: FlatButton(
                 child: Text("Get weather of your current location"),
                 onPressed: (){
                   getLocation();
                 },
                 color: Colors.redAccent,
               ),
             ),
            ],
          ),
        ]
        )
      ),
    );
  }
}
