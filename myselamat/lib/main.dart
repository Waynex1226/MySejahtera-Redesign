import 'package:flutter/material.dart';
import 'package:mysj/pages/hotspot.dart';
import 'package:mysj/pages/profile.dart';
import 'package:mysj/pages/questions.dart';
import 'package:mysj/pages/home.dart';
import 'package:mysj/data/question_sets.dart';
import 'package:mysj/pages/travelhistory.dart';
import 'package:mysj/widgets/bottom_nav_bar_items.dart';
import 'package:flutter/services.dart';
import 'package:mysj/widgets/checkin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //final FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySelamat',
      theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primarySwatch: Colors.lightBlue,
          fontFamily: 'MazzardH-SemiBold'),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => AppHome(),
        "/hotspot": (context) => Hotspot(),
        "/travelhistory": (context) => TravelHistory(),
        "/assesment": (context) => QuestionsPage(
              title: "Questions",
              subtitle: "Daily Health Assessment",
              questions: healthAssessmentQuestionSet(),
            )
      },
    );
  }
}

class AppHome extends StatefulWidget {
  AppHome({
    Key? key,
  }) : super(key: key);

  // final FirebaseApp app;

  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  static var pages = <Widget>[];

  void initState() {
    super.initState();

    // Firebase sample
    final DatabaseReference db = FirebaseDatabase.instance.reference();
    db.child("sample").set('sample writing');
    db.child('sample').once().then((result) => print('result = $result'));

    // Hide Android Status Bar and Navigation Bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    pages = [
      HomePage(
        quickActionsCallbacks: [
          () {
            Navigator.pushNamed(context, '/assesment');
          },
          () {},
          () {},
        ],
      ),
      ProfilePage()
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: pages[_selectedPageIndex],
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: bottomNavigationBarItems(),
              currentIndex: _selectedPageIndex,
              onTap: _selectPage),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          child: Icon(
            Icons.qr_code_scanner,
            size: 28.0,
          ),
          backgroundColor: Color(0xff4f8eff),
          foregroundColor: Colors.white,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => CheckIn())),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
