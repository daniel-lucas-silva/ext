import 'package:ext_example/drawer.dart';
import 'package:ext_example/forms.dart';
import 'package:ext_example/nested_scrollview.dart';
import 'package:ext_example/screens/settings_2.dart';
import 'package:flutter/material.dart';
import 'package:ext/ext.dart';
import 'package:flutter/services.dart';

import 'backdrop.dart';
import 'expansion_panels.dart';
import 'expansion_tile_list.dart';
import 'leave_behind.dart';
import 'reorderable_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ExtTheme.light(),
      darkTheme: ExtTheme.dark(),
      home: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SystemOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        drawer: ExtDrawer(),
        body: ListView(
          children: [
            DefaultListTile(
              title: Text("Settings 2"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SettingsScreen2()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Settings 1"),
              detail: Text("Detail"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => SettingsScreen2()),
                );
              },
            ),
            Separator(),
            DefaultListTile(
              title: Text("Forms"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FormsExample()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Backdrop"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => BackdropDemo()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Drawer"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DrawerDemo()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Expansion Tile List"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ExpansionTileListDemo()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Expansion Panels"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ExpansionPanelsDemo()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Nested Scaffold"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => NestedScaffold()),
                );
              },
            ),
            DefaultListTile(
              title: Text("Reorderable List"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ReorderableListDemo()),
                );
              },
            ),
            ListTile(
              title: Text("Leave Behind"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => LeaveBehindDemo()),
                );
              },
            ),
            Separator(),
          ],
        ),
      ),
    );
  }
}
