import 'package:flutter/material.dart';

class ThreadPage extends StatefulWidget {
  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  String _result = '';
  bool _isProcessing = false;

  Future<void> _prosesDataBerat() async {
    setState(() {
      _isProcessing = true;
      _result = "Sedang diproses...";
    });

    // Simulasi proses berat (contoh: fetch dari internet, proses data, dsb)
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isProcessing = false;
      _result = "Proses selesai! Data berhasil diproses 🎉";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thread & AsyncTask Demo")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isProcessing ? null : _prosesDataBerat,
              child: _isProcessing
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Text("Memproses..."),
                ],
              )
                  : Text("Proses Data Berat"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 32),
            Text(
              _result,
              style: TextStyle(fontSize: 16, color: Colors.teal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
