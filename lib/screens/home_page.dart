//import 'package:firebase_auth/firebase_auth.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/componenets/auth.dart';
import 'package:shopapp/componenets/cart_products.dart';
import 'package:shopapp/componenets/cityproider.dart';
import 'package:shopapp/componenets/horizontal_listview.dart';
import 'package:shopapp/componenets/loading.dart';
import 'package:shopapp/componenets/services.dart';
import 'package:shopapp/componenets/theme.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/screens/help.dart';
import 'package:shopapp/screens/my_order.dart';
import 'package:shopapp/order/profile.dart';
import 'package:badges/badges.dart';
import 'package:shopapp/screens/notification.dart';


class HomePage extends StatefulWidget {
//  final email;
//  final FirebaseUser user;
//  HomePage({this.email,this.user});
//  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.status == Status.Authenticating
        ? Loading()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.lightBlueAccent,
                title: Row(
                  children: [
                    Icon(Icons.location_on, size: 35),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 18, 0, 0),
                          child: Text("Select City"),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Row(
                            children: [
                              Text(Provider.of<CityProvider>(context,listen: false).cityName),
                              IconButton(
                                icon: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  showDialog(context: context,builder: (context){
                                    return AlertDialog(
                                      title: Text("Select City "),
                                      content:  Container(
                                        height: MediaQuery.of(context).size.height*0.5,
                                        child: SelectCity(),
                                      ),
                                      actions: [
                                        RaisedButton(
                                          child: Text("Continue"),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  },);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ));
                    },
                    child: Badge(
                      child: Icon(Icons.shopping_cart),
                      badgeContent: Text(
                        "${Provider.of<CartProduct>(context).taskCount}",
                        style: TextStyle(color: Colors.white),
                      ),
                      position: BadgePosition(start: 12, top: 1),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    currentAccountPicture: GestureDetector(
                      child: AvatarGlow(
                        endRadius: 60,
                        glowColor: Colors.white,
                        child: Material(
                          elevation: 8,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.lightBlueAccent),
                    accountName: Text("${authProvider.userModel?.name ?? "username lading..."}"),
                    accountEmail: Text("${authProvider.user.email}"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Home Page"),
                      leading: Icon(Icons.home, color: Colors.blue),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cart(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Shopping Card"),
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrder(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("My Orders"),
                      leading:
                          Icon(Icons.assignment_turned_in, color: Colors.blue),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("My Profile"),
                      leading: Icon(Icons.person, color: Colors.blue),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Notify(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Notification"),
                      leading: Icon(Icons.notifications, color: Colors.blue),
                    ),
                  ),
                  ListTile(
                    title: Text("Dark Theme"),
                    leading: Icon(Icons.brightness_5, color: Colors.blue),
                    trailing: IconButton(
                      onPressed: () {
                        ThemeProvider themeProvider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        themeProvider.swapTheme();
                      },
                      icon: Icon(
                        Icons.brightness_6,
                      ),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Help(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Help"),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Text("Abount"),
                      leading: Icon(
                        Icons.help,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScreenController(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text("Log Out"),
                      leading: Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  height: 235,
                  child: Carousel(
                    boxFit: BoxFit.fitWidth,
                    images: [
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F1.jpg?alt=media&token=93afa864-ce50-491f-93bd-48fc06ddd543"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F2.jpg?alt=media&token=1adf459e-a804-42c7-a7a5-f761e0977272"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F3.jpg?alt=media&token=9dc8f44e-0a45-4b04-9fa6-9d36e3164f74"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F4.jpg?alt=media&token=b11a1f7e-fdfe-4720-bd10-d35643b3d569"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F5.jpg?alt=media&token=a4e6200a-2aa8-480e-8c49-7df4db709744"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F6.jpg?alt=media&token=af642aaf-6292-4fef-85aa-cdad271f3caa"),
                      Image.network(
                          "https://firebasestorage.googleapis.com/v0/b/shopapp-354c8.appspot.com/o/all%2F7.jpg?alt=media&token=0e7ea808-5d3f-4587-a9ec-3c4f4260e49b"),
                    ],
                    autoplay: false,
                    dotBgColor: Colors.transparent,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    dotColor: Colors.blue,
                    indicatorBgPadding: 8.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Categories :",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                HorizontalListView(
                  cityName: Provider.of<CityProvider>(context).cityName,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Top Services :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  height: 400,
                  child: Services(),
                ),
              ],
            ),
          );
  }
}

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: "Amravati",
          title: Text("Amravati"),
          activeColor: Colors.lightBlue,
          groupValue: Provider.of<CityProvider>(context,listen: false).cityName,
          onChanged: (t){
            setState(() {
              Provider.of<CityProvider>(context,listen: false).swapCity(t);
            });
          },
        ),
        RadioListTile(
          value: "Morshi",
          title: Text("Morshi"),
          activeColor: Colors.lightBlue,
          groupValue: Provider.of<CityProvider>(context,listen: false).cityName,
          onChanged: (t){
            setState(() {
              Provider.of<CityProvider>(context,listen: false).swapCity(t);
            });
          },
        ),
      ],
    );
  }
}
