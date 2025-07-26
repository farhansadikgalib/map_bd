import 'package:flutter/material.dart';
import 'package:map_bd/map_bd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Sample division data
  final Map<String, String> divisionData = {
    'Dhaka': 'Capital',
    'Chattogram': 'Port City',
    'Rajshahi': 'Silk City',
    'Khulna': 'Mangrove',
    'Barishal': 'River Port',
    'Sylhet': 'Tea Gardens',
    'Rangpur': 'Agriculture',
    'Mymensingh': 'Education',
  };

  final Map<String, String> districtData = {
    'Dhaka': 'Capital',
    'Gazipur': 'City Corporation',
    'Narayanganj': 'Port City',
    'Tangail': 'Tangaile Sari',
    'Kishoreganj': 'President\'s Home',
    'Manikganj': 'Ferry Ghat',
    'Munshiganj': 'Famous for Ilish',
    'Rajbari': 'Rajbari Rajbari',
    'Faridpur': 'River Port',
    'Madaripur': 'Famous for Dates',
    'Shariatpur': 'Famous for Sweets',
    'Gopalganj': 'Bangabandhu\'s Home',
    'Rangpur': 'Main City',
    'Dinajpur': 'Litchi',
    'Kurigram': 'Riverine District',
    'Gaibandha': 'Charland',
    'Nilphamari': 'Indigo Cultivation',
    'Panchagarh': 'Tea Gardens',
    'Thakurgaon': 'Sugar Mill',
    'Lalmonirhat': 'Railway Junction',
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bangladesh Map',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('বাংলাদেশের মানচিত্র / Bangladesh Map'),
          backgroundColor: Colors.green[700],
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[50]!, Colors.green[50]!],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: MapBD(
                    divisionData: divisionData,
                    districtData: districtData,
                    showData: true,
                    dataTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
