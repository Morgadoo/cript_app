import 'package:cript_app/const/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cript_app/ui/theme/theme.dart';

class PreferenceScreen extends StatefulWidget {
  /* PreferenceScreen({Key key, this.switchValue}) : super(key: key);
  final int switchValue;*/

  @override
  _PreferenceScreen createState() => _PreferenceScreen();
}

class _PreferenceScreen extends State<PreferenceScreen> {
  bool switchDebug = debug[0].switchdebug;

  visibilityDebug(value) {
    debug[0].switchdebug = value;
    print("test: " + debug[0].switchdebug.toString());
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settigns"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Row(children: <Widget>[
                    RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Dark',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        onPressed: () =>
                            _themeChanger.setTheme(ThemeData.dark())),
                    SizedBox(width: 20),
                    RaisedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Light',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        onPressed: () =>
                            _themeChanger.setTheme(ThemeData.light())),
                  ]),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Debug Mode',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        activeColor: Colors.green,
                        value: switchDebug,
                        onChanged: (value) {
                          setState(() {
                            switchDebug = value;
                            visibilityDebug(value);
                          });
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
