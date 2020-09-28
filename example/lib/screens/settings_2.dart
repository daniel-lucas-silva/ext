import 'package:ext/ext.dart';
import 'package:flutter/material.dart';

class SettingsScreen2 extends StatefulWidget {
  @override
  _SettingsScreen2State createState() => _SettingsScreen2State();
}

class _SettingsScreen2State extends State<SettingsScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        actions: [
          PopupMenuButton<bool>(
            onSelected: (v) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<bool>>[
              const PopupMenuItem(
                value: false,
                child: Text('PopupMenuItem 1'),
              ),
              const PopupMenuItem(
                value: true,
                child: Text('PopupMenuItem 2'),
              ),
//              const PopupMenuDivider(),
//              CheckedPopupMenuItem(
//                value: true,
//                checked: true,
//                child: const Text('Horizontal swipe'),
//              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("General"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Separator(),
          ListTile(
            title: Text("Notifications"),
          ),
          SwitchListTile(
            title: Text("All New Post"),
            value: true,
            onChanged: (v){},
          ),
          SwitchListTile(
            title: Text("Friends"),
            value: false,
            onChanged: (v){},
          ),
          SwitchListTile(
            title: Text("New Places"),
            value: true,
            onChanged: (v){},
          ),
          Separator(),
          ListTile(
            title: Text("Other"),
          ),
          ListTile(
            title: Text("Label"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: Text("Privacy Settings"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: Text("Support"),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Separator(),
        ],
      ),
    );
  }
}
