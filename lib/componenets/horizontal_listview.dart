
import 'package:flutter/material.dart';
import 'package:shopapp/screens/list.dart';
class HorizontalListView extends StatelessWidget {
  final cityName;
  HorizontalListView({this.cityName});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F2.png?alt=media&token=dac7e88e-787c-4e47-900e-8a7e21df7c2f",imageCaption: "Cake",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F3.png?alt=media&token=93e8f34c-ee6b-498d-8b17-2307039721ce",imageCaption: "Carpenter",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F4.png?alt=media&token=ced95b56-a7ab-4fc0-8b72-d1e4b03ee6ee",imageCaption: "Electrician",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F7.png?alt=media&token=216c7201-a906-4145-9e26-3b137f98dca0",imageCaption: "Salon",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F5.png?alt=media&token=c47a0edb-d6b9-4cd2-909d-6f417c2a9922",imageCaption: "Laundry",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F6.png?alt=media&token=b64cd674-c2d4-4055-9a61-cc390766087a",imageCaption: "Plumber",name: cityName,),
          Category(imageLocation: "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/logo%2F1.png?alt=media&token=3458824d-f1fd-4afd-9be7-03627ef5d012",imageCaption: "Painter",name: cityName,),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final name;
  final String imageLocation;
  final String imageCaption;
  Category({this.imageCaption, this.imageLocation,this.name});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Lists(listName: imageCaption,cityName: name,),),);
        },
        child: Container(
          width: 105,
          child: ListTile(
            title: Image.network(imageLocation,),
            subtitle: Text(imageCaption,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,),),
          ),
        ),
      ),
    );
  }
}
