import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GrafikPage extends StatefulWidget {
  @override
  State<GrafikPage> createState() => _GrafikPageState();
}

class _GrafikPageState extends State<GrafikPage> {
  Map<String, int> _stats = {}; // key: tanggal, value: jumlah catatan

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString('notes') ?? '[]';
    List notes = json.decode(notesString);
    // Anggap setiap catatan punya tanggal (simulasi sederhana saja)
    _stats.clear();
    for (final note in notes) {
      // Di kode sebelumnya belum ada tanggal, jadi kita kasih default "hari ini"
      // Kamu bisa upgrade kode notes biar simpan tanggal beneran kalau mau
      String date = note['date'] ?? 'Hari Ini';
      _stats[date] = (_stats[date] ?? 0) + 1;
    }
    if (_stats.isEmpty) _stats["Hari Ini"] = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final labels = _stats.keys.toList();
    final data = _stats.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Grafik Data")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text("Statistik Catatan per Hari", style: TextStyle(fontSize: 18)),
            SizedBox(height: 32),
            if (_stats.isEmpty || data.every((e) => e == 0))
              Text("Belum ada data catatan.")
            else
              SizedBox(
                height: 240,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: (data.isEmpty ? 0 : (data.reduce((a, b) => a > b ? a : b).toDouble() + 1)),
                    barTouchData: BarTouchData(enabled: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int i = value.toInt();
                            if (i < labels.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(labels[i], style: TextStyle(fontSize: 10)),
                              );
                            }
                            return Container();
                          },
                          reservedSize: 32,
                        ),
                      ),
                    ),
                    barGroups: List.generate(labels.length, (i) {
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: data[i].toDouble(),
                            width: 18,
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.teal,
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _loadStats,
              child: Text("Refresh Grafik"),
            ),
          ],
        ),
      ),
    );
  }
}
