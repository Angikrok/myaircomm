// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_aircomm/app20new/data/dati_utenza.dart';
import '/app20new/controller/http_helper.dart';
import 'elementi_menu.dart';

class Profile extends StatefulWidget {
  Profile({
    Key? key,
    required this.datiUtenza,
    required this.datiCliente,
  }) : super(key: key);
  DatiUtenza datiUtenza;
  final String datiCliente;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: _globalKey,
          drawer: ElementiMenu(
            datiUtenza: widget.datiUtenza,
            width: width,
            height: height,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF40b6c7),
                  Color(0xFF023e8a),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: MediaQuery.of(context).size.width / 1.4,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: Color(0xFF023e8a),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: MediaQuery.of(context).size.width / 1.5,
                  child: CircleAvatar(
                    radius: 135,
                    backgroundColor: Color(0xFF40b6c7),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 1.45,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundColor: Color(0xFF0096c7),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: MediaQuery.of(context).size.width / 1.15,
                  child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _globalKey.currentState!.openDrawer();
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 25),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Profilo',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Pt',
                                  fontSize: 19,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ProfileDetails(
                      dati: widget.datiCliente,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DateTime? backButtonPressedTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton;
    backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) > Duration(seconds: 2);
    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
        msg: "Clicca di nuovo per chiudere l'app",
        backgroundColor: Colors.black45,
        textColor: Colors.white,
      );
      return false;
    }
    SystemNavigator.pop();
    return true;
  }
}

class ProfileDetails extends StatefulWidget {
  ProfileDetails({
    Key? key,
    required this.dati,
  }) : super(key: key);
  final String dati;
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  HttpHelper helper = HttpHelper();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          color: Colors.grey[200],
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 3.2,
              left: MediaQuery.of(context).size.width / 5,
              child: CircleAvatar(
                radius: 350,
                backgroundColor: Color(0xFF0096c7).withOpacity(.4),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.5,
              left: MediaQuery.of(context).size.width / 4,
              child: CircleAvatar(
                radius: 250,
                backgroundColor: Color(0xFF0096c7).withOpacity(.4),
              ),
            ),
            Positioned(
              top: 35,
              right: MediaQuery.of(context).size.width / 1.4,
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.white.withOpacity(.3),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage: AssetImage('assets/icon/persona.png'),
                        backgroundColor: Colors.blue.withOpacity(.22),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.dati,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Divider(),
                    TileTool(
                      title: Text('1'),
                    ),
                    Divider(),
                    TileTool(
                      title: Text('2'),
                    ),
                    Divider(),
                    TileTool(
                      title: Text('3'),
                    ),
                    Divider(),
                    TileTool(
                      title: Text('4'),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TileTool extends StatelessWidget {
  const TileTool({Key? key, required this.title}) : super(key: key);
  final Text title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFffffff),
              Color(0xFF9af0f8),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: ListTile(
        trailing: Icon(Icons.clear),
        title: title,
      ),
    );
  }
}
