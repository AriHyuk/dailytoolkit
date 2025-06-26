import 'package:flutter/material.dart';

class AutocompletePage extends StatefulWidget {
  @override
  State<AutocompletePage> createState() => _AutocompletePageState();
}

class _AutocompletePageState extends State<AutocompletePage> {
  final List<String> kategoriList = [
    "Belanja", "Tugas", "Penting", "Pribadi", "Kuliah", "Kerja"
  ];
  String? _selectedKategori;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Autocomplete & Spinner")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Autocomplete Kategori", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return kategoriList.where((String option) {
                  return option.toLowerCase().contains(textEditingValue.text.toLowerCase());
                });
              },
              onSelected: (String selection) {
                setState(() {
                  _result = "Terpilih (autocomplete): $selection";
                });
              },
              fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ketik kategori...',
                  ),
                );
              },
            ),
            SizedBox(height: 32),
            Text("Spinner (Dropdown) Kategori", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              items: kategoriList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pilih kategori...',
              ),
              onChanged: (value) {
                setState(() {
                  _selectedKategori = value;
                  _result = "Terpilih (dropdown): $value";
                });
              },
            ),
            SizedBox(height: 32),
            Text(_result, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
