import 'package:flutter/material.dart';
class CitySearchDelegate extends SearchDelegate{
  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return ThemeData(
      primaryColor: Colors.purple,
          textTheme: TextTheme(
        title: TextStyle(color: Colors.white),

    ),
    );
  }
 final cities=[
    "Ahmedabad",
   "Surat",
   "Mumbai",
   "Goa",
   "Pune",
   "Lal Darwaza, Ahmedabad",
   "Chennai",
   "Madurai",
   "Bengaluru",
   "Mangalore",
   "Anantapur",
   "Hubli",
   "Kolhapur",
   "Visakhapatnam",
   "Bhubaneswar,India",
   "Bhadrak,India",
   "Nagpur,India",
   "Raipur,India",
   "Bhilai, India",
   "Bhopal",
   "Indore",
   "Ujjain",
   "Ratlam"
   "Vadodara",
   "Bhavnagar, Gujarat",
   "Patan, Gujarat",
   "Dhanbad",
   "Ranchi",
   "Jamshedpur",
   "Kolkata",
   "Durgapur, West Bengal",
   "Katihar, Bihar",
   "Purnia, Bihar",
   "Kishanganj, Bihar",
   "Patna",
   "Kathmandu, Nepal",
   "Lalitpur, Nepal",
   "Siliguri",
   "Darjeeling"


  ];
 final recentSearch=[
   "Ahmdebad",
   "Pune"
 ];

var cityName;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
              query="";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList=query.isEmpty ? recentSearch : cities.where((text)=> text.startsWith(query)||text.contains(query)).toList();
    return ListView.builder(itemBuilder: (context,index){
      return ListTile(
        onTap:(){
          showResults(context);
          query=suggestionList[index];
          close(context,suggestionList[index]);
          },
        title:Text(suggestionList[index],style: TextStyle(color:Colors.black,fontSize: 18.0),),
      );
    },
    itemCount: suggestionList.length,);
  }

}