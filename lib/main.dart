import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  DatabaseReference _reference;

  Color _lampColor = Colors.grey[200];
  Color _lampBG = Colors.black;
  Color _fanColor = Colors.grey[200];
  Color _fanBG = Colors.black;

  int _fanStatus = 0;
  int _lightStatus = 0;

  @override
  void initState() {
    super.initState();

    _reference = FirebaseDatabase.instance.reference();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animationController.reset();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (_fanColor == Colors.grey[200]) {
                      _fanColor = Colors.yellow[900];
                      _fanBG = Colors.yellow;
                      _animationController.repeat();
                      _fanStatus = 1;
                    } else {
                      _fanColor = Colors.grey[200];
                      _fanBG = Colors.black;
                      _animationController.reset();
                      _fanStatus = 0;
                    }
                    _reference.set(<String, int> {
                      "fan": _fanStatus,
                      "light": _lightStatus,
                    });
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    child: Icon(
                      Icons.toys,
                      color: _fanColor,
                      size: 60.0,
                    ),
                    builder: (context, _widget) {
                      return Transform.rotate(
                        angle: _animationController.value * 6.3,
                        child: _widget,
                      );
                    },
                  ),
                ),
                color: _fanBG,
              ),
              SizedBox(
                height: 16.0,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    if (_lampColor == Colors.grey[200]) {
                      _lampColor = Colors.yellow[900];
                      _lampBG = Colors.yellow;
                      _lightStatus = 1;
                    } else {
                      _lampColor = Colors.grey[200];
                      _lampBG = Colors.black;
                      _lightStatus = 0;
                    }
                    _reference.set(<String, int> {
                      "fan": _fanStatus,
                      "light": _lightStatus,
                    });
                  });
                },
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.wb_incandescent,
                    color: _lampColor,
                    size: 60.0,
                  ),
                ),
                color: _lampBG,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
