import 'package:flutter/material.dart';
import 'notes_page.dart';
import 'camera_page.dart';
import 'maps_page.dart';
import 'preferences_page.dart';
import 'grafik_page.dart';
import 'autocomplete_page.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Catatan Pribadi', 'page': NotesPage()},
    {'title': 'Ambil Foto', 'page': CameraPage()},
    // {'title': 'Lihat Lokasi', 'page': MapsPage()},
    {'title': 'Preferences', 'page': PreferencesPage()},
    {'title': 'Grafik Data', 'page': GrafikPage()},
    // {'title': 'Autocomplete', 'page': AutocompletePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama")),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            title: Text(menuItems[i]['title']),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menuItems[i]['page']),
              );
            },
          ),
        ),
      ),
    );
  }
}
