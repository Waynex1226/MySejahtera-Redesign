import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final List<void Function()> quickActionsCallbacks;

  QuickActions(this.quickActionsCallbacks);

  // ignore: non_constant_identifier_names
  Widget ActionButton(
      IconData icon, String label, Color color, void Function() callback) {
    return Column(
      children: <Widget>[
        ElevatedButton(
            onPressed: callback,
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: CircleBorder(),
                primary: color),
            child: Container(
              width: 70.0,
              height: 70.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 28.0,
                color: Colors.white,
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "MazzardH-SemiBold",
                  fontSize: 12.0,
                  height: 1.2)),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 25.0),
            child: Text(
              "Quick actions",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "MazzardH-SemiBold",
                  fontSize: 18.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ActionButton(Icons.assignment, "My Status", Colors.blueAccent,
                  quickActionsCallbacks[0]),
              ActionButton(Icons.location_on, "Hotspots", Colors.orangeAccent,
                  (){
                    Navigator.pushNamed(context, "/hotspot");
                  }),
              ActionButton(Icons.history, "Travel History", Colors.green, () {
                Navigator.pushNamed(context, "/travelhistory");
              })
            ],
          ),
        )
      ],
    );
  }
}
