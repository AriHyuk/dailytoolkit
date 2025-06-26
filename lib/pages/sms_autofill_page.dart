import 'package:flutter/material.dart';

class SMSAutofillPage extends StatefulWidget {
  @override
  State<SMSAutofillPage> createState() => _SMSAutofillPageState();
}

class _SMSAutofillPageState extends State<SMSAutofillPage> {
  final otpController = TextEditingController();
  String _simulasiOTP = "927462"; // OTP contoh

  void _autofillOTP() {
    setState(() {
      otpController.text = _simulasiOTP;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP ter-autofill (simulasi)!")),
    );
  }

  void _kirimOTP() {
    // Di aplikasi real, proses ini akan mengirim SMS ke user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Kode OTP $_simulasiOTP dikirim (simulasi).")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SMS Autofill (Simulasi)")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _kirimOTP,
              child: Text("Kirim Kode OTP (Simulasi)"),
            ),
            SizedBox(height: 24),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Masukkan OTP",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _autofillOTP,
              child: Text("Autofill OTP (Simulasi)"),
            ),
            SizedBox(height: 24),
            Text(
              "Ini hanya demo SMS Autofill.\nAslinya perlu plugin dan akses SMS di device.",
              style: TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
