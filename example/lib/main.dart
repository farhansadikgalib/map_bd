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
    'Bogura': 'Yogurt',
    'Joypurhat': 'Sugar Mill',
    'Naogaon': 'Paddy',
    'Natore': 'Kachagolla',
    'Nawabganj': 'Mango',
    'Pabna': 'Mental Hospital',
    'Rajshahi': 'Silk City',
    'Sirajganj': 'Handloom',
    'Jamalpur': 'Nakshi Kantha',
    'Mymensingh': 'Education Hub',
    'Netrokona': 'Birishiri',
    'Sherpur': 'Garo Hills',
    'Sylhet': 'Tea Gardens',
    'Sunamganj': 'Haor',
    'Habiganj': 'Gas Field',
    'Moulvibazar': 'Madhabkunda Waterfall',
    'Barishal': 'Guava',
    'Patuakhali': 'Kuakata',
    'Bhola': 'Island',
    'Pirojpur': 'Floating Market',
    'Barguna': 'Betel Leaf',
    'Jhalokati': 'Hog Plum',
    'Chattogram': 'Port City',
    "Cox's Bazar": 'Beach',
    'Rangamati': 'Lake',
    'Bandarban': 'Hills',
    'Khagrachhari': 'Cave',
    'Feni': 'River',
    'Lakshmipur': 'Coconut',
    'Comilla': 'Rasmalai',
    'Noakhali': 'Island',
    'Brahmanbaria': 'Sweet',
    'Chandpur': 'Hilsa',
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
