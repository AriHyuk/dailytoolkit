import 'package:flutter/material.dart';

void main() => runApp(DailyToolkitApp());

class DailyToolkitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Toolkit',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    // Dummy validasi, nanti bisa diganti logic sendiri
    if (emailController.text == "user" && passwordController.text == "123") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 24),
            ElevatedButton(onPressed: login, child: Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: Text("Belum punya akun? Register"),
            )
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(child: Text("Halaman register (coming soon)")),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Catatan Pribadi', 'page': NotesPage()},
    {'title': 'Ambil Foto', 'page': CameraPage()},
    {'title': 'Lihat Lokasi', 'page': MapsPage()},
    {'title': 'Preferences', 'page': PreferencesPage()},
    {'title': 'Grafik Data', 'page': GrafikPage()},
    {'title': 'Autocomplete', 'page': AutocompletePage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daily Toolkit")),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(menuItems[i]['title']),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => menuItems[i]['page']));
          },
        ),
      ),
    );
  }
}

// Halaman-halaman dummy dulu, nanti kita isi satu-satu
class NotesPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Catatan Pribadi")), body: Center(child: Text("Catatan Pribadi"))); }
class CameraPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Ambil Foto")), body: Center(child: Text("Ambil Foto"))); }
class MapsPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Lihat Lokasi")), body: Center(child: Text("Lihat Lokasi"))); }
class PreferencesPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Preferences")), body: Center(child: Text("Preferences"))); }
class GrafikPage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Grafik Data")), body: Center(child: Text("Grafik Data"))); }
class AutocompletePage extends StatelessWidget { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Autocomplete")), body: Center(child: Text("Autocomplete"))); }
