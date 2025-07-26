import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'map/divisions/division.dart';

class MapBD extends StatefulWidget {
  const MapBD({
    super.key,
    this.width = 360.59,
    this.height = 500,
    this.divisionData,
    this.districtData,
    this.showData = true,
    this.dataTextStyle,
  });

  final double width;
  final double height;
  final Map<String, String>? divisionData;
  final Map<String, String>? districtData;
  final bool showData;
  final TextStyle? dataTextStyle;

  @override
  State<MapBD> createState() => _MapBDState();
}

class _MapBDState extends State<MapBD> {
  String? selectedDivision;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          CustomPaint(
            painter: BangladeshMapPainter(
              divisionData: widget.divisionData,
              districtData: widget.districtData,
              showData: widget.showData,
              dataTextStyle: widget.dataTextStyle,
              selectedDivision: selectedDivision,
            ),
            child: Container(),
          ),
          // Clickable areas for divisions
          ..._buildClickableAreas(),
          // Back button when a division is selected
          if (selectedDivision != null) _buildBackButton(),
        ],
      ),
    );
  }

  List<Widget> _buildClickableAreas() {
    const double pWidth = 360.59;
    const double pHeight = 500;

    final divisions = [
      {
        'name': 'Rangpur',
        'x': 6.2 + 139.23 / 2,
        'y': 3.12 + 132.73 / 2,
        'width': 139.23,
        'height': 132.73,
      },
      {
        'name': 'Rajshahi',
        'x': 1.76 + 138.64 / 2,
        'y': 114.89 + 120.51 / 2,
        'width': 138.64,
        'height': 120.51,
      },
      {
        'name': 'Khulna',
        'x': 43.74 + 108.13 / 2,
        'y': 206.29 + 210.79 / 2,
        'width': 108.13,
        'height': 210.79,
      },
      {
        'name': 'Chattogram',
        'x': 197.46 + 162.88 / 2,
        'y': 198.71 + 300.01 / 2,
        'width': 162.88,
        'height': 300.01,
      },
      {
        'name': 'Sylhet',
        'x': 227.61 + 118.54 / 2,
        'y': 121 + 101.58 / 2,
        'width': 118.54,
        'height': 101.58,
      },
      {
        'name': 'Dhaka',
        'x': 100.79 + 151.94 / 2,
        'y': 155.05 + 161.75 / 2,
        'width': 151.94,
        'height': 161.75,
      },
      {
        'name': 'Mymensingh',
        'x': 127.1 + 125.93 / 2,
        'y': 102.37 + 96.64 / 2,
        'width': 125.93,
        'height': 96.64,
      },
      {
        'name': 'Barishal',
        'x': 144.54 + 86.34 / 2,
        'y': 296.8 + 106.65 / 2,
        'width': 86.34,
        'height': 106.65,
      },
    ];

    return divisions.map((division) {
      final name = division['name'] as String;
      final x = (division['x'] as double) / pWidth * widget.width;
      final y = (division['y'] as double) / pHeight * widget.height;
      final width = (division['width'] as double) / pWidth * widget.width;
      final height = (division['height'] as double) / pHeight * widget.height;

      return Positioned(
        left: x - width / 2,
        top: y - height / 2,
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedDivision = name;
            });
          },
          child: Container(
            width: width,
            height: height,
            color: Colors.transparent,
          ),
        ),
      );
    }).toList();
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 10,
      left: 10,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDivision = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BangladeshMapPainter extends CustomPainter {
  BangladeshMapPainter({
    this.divisionData,
    this.districtData,
    this.showData = true,
    this.dataTextStyle,
    this.selectedDivision,
  });

  final Map<String, String>? divisionData;
  final Map<String, String>? districtData;
  final bool showData;
  final TextStyle? dataTextStyle;
  final String? selectedDivision;

  @override
  void paint(Canvas canvas, Size size) {
    const double pWidth = 360.59;
    const double pHeight = 500;

    // Draw national border
    _drawNationalBorder(canvas, size, pWidth, pHeight);

    // Draw divisional borders
    _drawDivisionalBorders(canvas, size, pWidth, pHeight);

    // Draw divisions based on selection
    if (selectedDivision != null) {
      // Draw only the selected division
      _drawSelectedDivision(canvas, size, pWidth, pHeight);
    } else {
      // Draw all divisions
      _drawAllDivisions(canvas, size, pWidth, pHeight);
    }

    // Draw division names
    _drawDivisionNames(canvas, size, pWidth, pHeight);

    // Draw division data if enabled
    if (showData) {
      _drawDivisionData(canvas, size, pWidth, pHeight);
    }
  }

  void _drawSelectedDivision(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    final divisionMap = {
      'Rangpur': {
        'painter': RangpurPainter(),
        'left': 6.2,
        'top': 3.12,
        'width': 139.23,
        'height': 132.73,
        'color': Colors.amber[600]!,
      },
      'Rajshahi': {
        'painter': RajshahiPainter(),
        'left': 1.76,
        'top': 114.89,
        'width': 138.64,
        'height': 120.51,
        'color': Colors.orange[600]!,
      },
      'Khulna': {
        'painter': KhulnaPainter(),
        'left': 43.74,
        'top': 206.29,
        'width': 108.13,
        'height': 210.79,
        'color': Colors.purple[600]!,
      },
      'Chattogram': {
        'painter': ChittagongPainter(),
        'left': 197.46,
        'top': 198.71,
        'width': 162.88,
        'height': 300.01,
        'color': Colors.blue[600]!,
      },
      'Sylhet': {
        'painter': SylhetPainter(),
        'left': 227.61,
        'top': 121,
        'width': 118.54,
        'height': 101.58,
        'color': Colors.indigo[600]!,
      },
      'Dhaka': {
        'painter': DhakaPainter(),
        'left': 100.79,
        'top': 155.05,
        'width': 151.94,
        'height': 161.75,
        'color': Colors.green[600]!,
      },
      'Mymensingh': {
        'painter': MymensinghPainter(),
        'left': 127.1,
        'top': 102.37,
        'width': 125.93,
        'height': 96.64,
        'color': Colors.lime[600]!,
      },
      'Barishal': {
        'painter': BarisalPainter(),
        'left': 144.54,
        'top': 296.8,
        'width': 86.34,
        'height': 106.65,
        'color': Colors.teal[600]!,
      },
    };

    final division = divisionMap[selectedDivision];
    if (division != null) {
      // Special handling for Dhaka division - show detailed district map
      if (selectedDivision == 'Dhaka') {
        _drawDhakaDetailedMap(canvas, size);
      } else if (selectedDivision == 'Rangpur') {
        _drawRangpurDetailedMap(canvas, size);
      } else if (selectedDivision == 'Rajshahi') {
        _drawRajshahiDetailedMap(canvas, size);
      } else {
        // Save canvas state
        canvas.save();

        // Calculate scale to fit the division to full screen
        final originalWidth =
            (division['width'] as double) / pWidth * size.width;
        final originalHeight =
            (division['height'] as double) / pHeight * size.height;

        final scaleX = size.width / originalWidth;
        final scaleY = size.height / originalHeight;
        final scale =
            math.min(scaleX, scaleY) * 0.8; // 80% of full size for some margin

        // Center the division
        final scaledWidth = originalWidth * scale;
        final scaledHeight = originalHeight * scale;
        final centerX = (size.width - scaledWidth) / 2;
        final centerY = (size.height - scaledHeight) / 2;

        // Translate to center
        canvas.translate(centerX, centerY);

        // Scale the division
        canvas.scale(scale);

        // Create a custom painter with the specified color
        final coloredPainter = _ColoredDivisionPainter(
          division['painter'] as CustomPainter,
          division['color'] as Color,
        );

        // Draw the division at full size
        coloredPainter.paint(canvas, Size(originalWidth, originalHeight));

        // Restore canvas state
        canvas.restore();
      }
    }
  }

  void _drawDhakaDetailedMap(Canvas canvas, Size size) {
    // Calculate scaling to fit the map in the available space
    final mapWidth = 300.0;
    final mapHeight = 400.0;
    final scaleX = size.width / mapWidth;
    final scaleY = size.height / mapHeight;
    final scale = math.min(scaleX, scaleY) * 0.9;

    // Center the map
    final scaledWidth = mapWidth * scale;
    final scaledHeight = mapHeight * scale;
    final centerX = (size.width - scaledWidth) / 2;
    final centerY = (size.height - scaledHeight) / 2;

    // Save canvas state
    canvas.save();

    // Translate to center
    canvas.translate(centerX, centerY);

    // Scale the map
    canvas.scale(scale);

    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, mapWidth, mapHeight),
      Paint()..color = Colors.white,
    );

    // Draw title at the top
    /*
    final titleSpan = TextSpan(
      text: 'DHAKA MAP',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
    final titlePainter = TextPainter(
      text: titleSpan,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout();
    titlePainter.paint(canvas, Offset(10, 10));
    */

    // Draw the actual Dhaka division shape as background
    canvas.save();
    canvas.translate(15, 40); // Position the division shape
    _drawDhakaDivisionShape(canvas, mapWidth - 30, mapHeight - 55);
    canvas.restore();

    // Draw districts with more realistic shapes
    _drawDistrict(canvas, 'Tangail', 80, 70, 70, 50, districtData?['Tangail']);
    _drawDistrict(canvas, 'Gazipur', 160, 80, 60, 40, districtData?['Gazipur']);
    _drawDistrict(
      canvas,
      'Kishoreganj',
      230,
      60,
      50,
      35,
      districtData?['Kishoreganj'],
    );
    _drawDistrict(
      canvas,
      'Narsingdi',
      210,
      110,
      45,
      30,
      districtData?['Narsingdi'],
    );
    _drawDistrict(
      canvas,
      'Manikganj',
      60,
      140,
      55,
      40,
      districtData?['Manikganj'],
    );
    _drawDistrict(canvas, 'Dhaka', 140, 140, 55, 45, districtData?['Dhaka']);
    _drawDistrict(
      canvas,
      'Narayanganj',
      205,
      150,
      45,
      35,
      districtData?['Narayanganj'],
    );
    _drawDistrict(
      canvas,
      'Munshiganj',
      170,
      190,
      50,
      30,
      districtData?['Munshiganj'],
    );
    _drawDistrict(canvas, 'Rajbari', 50, 200, 40, 35, districtData?['Rajbari']);
    _drawDistrict(
      canvas,
      'Faridpur',
      70,
      250,
      55,
      40,
      districtData?['Faridpur'],
    );
    _drawDistrict(
      canvas,
      'Madaripur',
      55,
      300,
      45,
      35,
      districtData?['Madaripur'],
    );
    _drawDistrict(
      canvas,
      'Shariatpur',
      120,
      250,
      50,
      30,
      districtData?['Shariatpur'],
    );
    _drawDistrict(
      canvas,
      'Gopalganj',
      75,
      340,
      55,
      40,
      districtData?['Gopalganj'],
    );
    // Restore canvas state
    canvas.restore();
  }

  void _drawDhakaDivisionShape(
    Canvas canvas,
    double mapWidth,
    double mapHeight,
  ) {
    // Use the actual DhakaPainter to draw the real Dhaka division shape
    final dhakaPainter = DhakaPainter(
      color: Colors.green[600]!, // Same green as main Bangladesh map
      strokeColor: Colors.black,
      strokeWidth: 3.0, // Thicker border for better visibility
      showDistrictBorder: false,
    );

    // Draw the actual Dhaka division shape
    dhakaPainter.paint(canvas, Size(mapWidth, mapHeight));
  }

  void _drawRangpurDetailedMap(Canvas canvas, Size size) {
    // Calculate scaling to fit the map in the available space
    final mapWidth = 300.0;
    final mapHeight = 400.0;
    final scaleX = size.width / mapWidth;
    final scaleY = size.height / mapHeight;
    final scale = math.min(scaleX, scaleY) * 0.9;

    // Center the map
    final scaledWidth = mapWidth * scale;
    final scaledHeight = mapHeight * scale;
    final centerX = (size.width - scaledWidth) / 2;
    final centerY = (size.height - scaledHeight) / 2;

    // Save canvas state
    canvas.save();

    // Translate to center
    canvas.translate(centerX, centerY);

    // Scale the map
    canvas.scale(scale);

    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, mapWidth, mapHeight),
      Paint()..color = Colors.white,
    );

    // Draw the actual Rangpur division shape as background
    canvas.save();
    canvas.translate(15, 40); // Position the division shape
    _drawRangpurDivisionShape(canvas, mapWidth - 30, mapHeight - 55);
    canvas.restore();

    // Draw districts for Rangpur
    _drawDistrict(
      canvas,
      'Panchagarh',
      50,
      50,
      80,
      60,
      districtData?['Panchagarh'],
    );
    _drawDistrict(
      canvas,
      'Thakurgaon',
      40,
      120,
      80,
      70,
      districtData?['Thakurgaon'],
    );
    _drawDistrict(
      canvas,
      'Nilphamari',
      120,
      80,
      70,
      80,
      districtData?['Nilphamari'],
    );
    _drawDistrict(
      canvas,
      'Dinajpur',
      60,
      200,
      80,
      90,
      districtData?['Dinajpur'],
    );
    _drawDistrict(
      canvas,
      'Lalmonirhat',
      180,
      100,
      90,
      60,
      districtData?['Lalmonirhat'],
    );
    _drawDistrict(
      canvas,
      'Rangpur',
      150,
      180,
      80,
      70,
      districtData?['Rangpur'],
    );
    _drawDistrict(
      canvas,
      'Kurigram',
      220,
      170,
      80,
      80,
      districtData?['Kurigram'],
    );
    _drawDistrict(
      canvas,
      'Gaibandha',
      160,
      260,
      80,
      80,
      districtData?['Gaibandha'],
    );

    // Restore canvas state
    canvas.restore();
  }

  void _drawRangpurDivisionShape(
    Canvas canvas,
    double mapWidth,
    double mapHeight,
  ) {
    // Use the actual RangpurPainter to draw the real Rangpur division shape
    final rangpurPainter = RangpurPainter(
      color: Colors.amber[600]!, // From division map
      strokeColor: Colors.black,
      strokeWidth: 3.0, // Thicker border for better visibility
      showDistrictBorder: false,
    );

    // Draw the actual Rangpur division shape
    rangpurPainter.paint(canvas, Size(mapWidth, mapHeight));
  }

  void _drawRajshahiDetailedMap(Canvas canvas, Size size) {
    // Calculate scaling to fit the map in the available space
    final mapWidth = 300.0;
    final mapHeight = 400.0;
    final scaleX = size.width / mapWidth;
    final scaleY = size.height / mapHeight;
    final scale = math.min(scaleX, scaleY) * 0.9;

    // Center the map
    final scaledWidth = mapWidth * scale;
    final scaledHeight = mapHeight * scale;
    final centerX = (size.width - scaledWidth) / 2;
    final centerY = (size.height - scaledHeight) / 2;

    // Save canvas state
    canvas.save();

    // Translate to center
    canvas.translate(centerX, centerY);

    // Scale the map
    canvas.scale(scale);

    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, mapWidth, mapHeight),
      Paint()..color = Colors.white,
    );

    // Draw the actual Rajshahi division shape as background
    canvas.save();
    canvas.translate(15, 40); // Position the division shape
    _drawRajshahiDivisionShape(canvas, mapWidth - 30, mapHeight - 55);
    canvas.restore();

    // Draw districts for Rajshahi
    _drawDistrict(
      canvas,
      'Joypurhat',
      160,
      50,
      80,
      60,
      districtData?['Joypurhat'],
    );
    _drawDistrict(canvas, 'Naogaon', 80, 80, 80, 70, districtData?['Naogaon']);
    _drawDistrict(canvas, 'Bogura', 170, 120, 70, 80, districtData?['Bogura']);
    _drawDistrict(
      canvas,
      'Nawabganj',
      30,
      160,
      80,
      90,
      districtData?['Nawabganj'],
    );
    _drawDistrict(
      canvas,
      'Rajshahi',
      60,
      240,
      90,
      60,
      districtData?['Rajshahi'],
    );
    _drawDistrict(canvas, 'Natore', 140, 220, 80, 70, districtData?['Natore']);
    _drawDistrict(
      canvas,
      'Sirajganj',
      200,
      200,
      80,
      80,
      districtData?['Sirajganj'],
    );
    _drawDistrict(canvas, 'Pabna', 150, 300, 80, 80, districtData?['Pabna']);

    // Restore canvas state
    canvas.restore();
  }

  void _drawRajshahiDivisionShape(
    Canvas canvas,
    double mapWidth,
    double mapHeight,
  ) {
    // Use the actual RajshahiPainter to draw the real Rajshahi division shape
    final rajshahiPainter = RajshahiPainter(
      color: Colors.orange[600]!, // From division map
      strokeColor: Colors.black,
      strokeWidth: 3.0, // Thicker border for better visibility
      showDistrictBorder: false,
    );

    // Draw the actual Rajshahi division shape
    rajshahiPainter.paint(canvas, Size(mapWidth, mapHeight));
  }

  void _drawDistrict(
    Canvas canvas,
    String name,
    double x,
    double y,
    double width,
    double height, [
    String? data,
  ]) {
    // No district background - removed colored rectangles

    // Draw district name only
    final nameSpan = TextSpan(
      text: name,
      style: TextStyle(
        color: Colors.white, // Black text on green background
        fontSize: 10,
        fontWeight: FontWeight.bold,
        // No shadows - clean appearance
      ),
    );

    final namePainter = TextPainter(
      text: nameSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    namePainter.layout();

    // Center text in district area
    final textX = x + (width - namePainter.width) / 2;
    final textY = y + (height - namePainter.height) / 2;

    namePainter.paint(canvas, Offset(textX, textY));

    if (showData && data != null && data.isNotEmpty) {
      final dataSpan = TextSpan(
        text: data,
        style:
            dataTextStyle ??
            const TextStyle(
              color: Colors.black,
              fontSize: 8,
              fontWeight: FontWeight.w500,
            ),
      );
      final dataPainter = TextPainter(
        text: dataSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      dataPainter.layout();
      final dataX = x + (width - dataPainter.width) / 2;
      final dataY = textY + namePainter.height; // Position below the name
      dataPainter.paint(canvas, Offset(dataX, dataY));
    }
  }

  void _drawAllDivisions(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    // Draw all divisions with proper positioning
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      RangpurPainter(),
      6.2,
      3.12,
      139.23,
      132.73,
      Colors.amber[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      RajshahiPainter(),
      1.76,
      114.89,
      138.64,
      120.51,
      Colors.orange[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      KhulnaPainter(),
      43.74,
      206.29,
      108.13,
      210.79,
      Colors.purple[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      ChittagongPainter(),
      197.46,
      198.71,
      162.88,
      300.01,
      Colors.blue[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      SylhetPainter(),
      227.61,
      121,
      118.54,
      101.58,
      Colors.indigo[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      DhakaPainter(),
      100.79,
      155.05,
      151.94,
      161.75,
      Colors.green[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      MymensinghPainter(),
      127.1,
      102.37,
      125.93,
      96.64,
      Colors.lime[600]!,
    );
    _drawDivision(
      canvas,
      size,
      pWidth,
      pHeight,
      BarisalPainter(),
      144.54,
      296.8,
      86.34,
      106.65,
      Colors.teal[600]!,
    );
  }

  void _drawNationalBorder(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final borderRect = Rect.fromLTWH(
      2.2 / pWidth * size.width,
      2.52 / pHeight * size.height,
      358.48 / pWidth * size.width,
      486.92 / pHeight * size.height,
    );

    canvas.drawRect(borderRect, borderPaint);
  }

  void _drawDivisionalBorders(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final borderRect = Rect.fromLTWH(
      53.71 / pWidth * size.width,
      102.39 / pHeight * size.height,
      204.69 / pWidth * size.width,
      299.72 / pHeight * size.height,
    );

    canvas.drawRect(borderRect, borderPaint);
  }

  void _drawDivision(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
    CustomPainter painter,
    double left,
    double top,
    double width,
    double height,
    Color color,
  ) {
    // Save canvas state
    canvas.save();

    // Translate to division position
    canvas.translate(left / pWidth * size.width, top / pHeight * size.height);

    // Create a custom painter with the specified color
    final coloredPainter = _ColoredDivisionPainter(painter, color);

    // Draw the division
    coloredPainter.paint(
      canvas,
      Size(width / pWidth * size.width, height / pHeight * size.height),
    );

    // Restore canvas state
    canvas.restore();
  }

  void _drawDivisionNames(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    // Don't draw division names when Dhaka is selected (showing detailed district map)
    if (selectedDivision == 'Dhaka' ||
        selectedDivision == 'Rangpur' ||
        selectedDivision == 'Rajshahi') {
      return;
    }

    final divisions = [
      {'name': 'Rangpur', 'x': 6.2 + 139.23 / 2, 'y': 3.12 + 132.73 / 2},
      {'name': 'Rajshahi', 'x': 1.76 + 138.64 / 2, 'y': 114.89 + 120.51 / 2},
      {'name': 'Khulna', 'x': 43.74 + 108.13 / 2, 'y': 206.29 + 210.79 / 2},
      {
        'name': 'Chattogram',
        'x': 197.46 + 162.88 / 2,
        'y': 198.71 + 300.01 / 2,
      },
      {'name': 'Sylhet', 'x': 227.61 + 118.54 / 2, 'y': 121 + 101.58 / 2},
      {'name': 'Dhaka', 'x': 100.79 + 151.94 / 2, 'y': 155.05 + 161.75 / 2},
      {'name': 'Mymensingh', 'x': 127.1 + 125.93 / 2, 'y': 102.37 + 96.64 / 2},
      {'name': 'Barishal', 'x': 144.54 + 86.34 / 2, 'y': 296.8 + 106.65 / 2},
    ];

    for (var division in divisions) {
      final divisionName = division['name'] as String;

      // Only show names for selected division or all divisions
      if (selectedDivision == null || selectedDivision == divisionName) {
        Offset center;

        if (selectedDivision != null && selectedDivision == divisionName) {
          // Center the name for selected division
          center = Offset(size.width / 2, size.height / 2);
        } else {
          // Use original position for all divisions view
          center = Offset(
            (division['x'] as double) / pWidth * size.width,
            (division['y'] as double) / pHeight * size.height,
          );
        }

        // Special positioning for Chattogram
        if (divisionName == 'Chattogram') {
          // Draw division name to the right, above the data value
          final textSpan = TextSpan(
            text: divisionName,
            style: TextStyle(
              color: Colors.white,
              fontSize: selectedDivision != null ? 16 : 9,
              fontWeight: FontWeight.bold,
            ),
          );

          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();

          // Position name to the right, above the data with 2px gap
          final nameX = center.dx + (selectedDivision != null ? 20 : 12);
          final nameY = center.dy - (selectedDivision != null ? 20 : 14);

          // Draw text
          textPainter.paint(
            canvas,
            Offset(nameX, nameY - textPainter.height / 2),
          );
        } else if (divisionName == 'Sylhet') {
          // Special positioning for Sylhet - moved by 10 pixels
          final textSpan = TextSpan(
            text: divisionName,
            style: TextStyle(
              color: Colors.white,
              fontSize: selectedDivision != null ? 16 : 9,
              fontWeight: FontWeight.bold,
            ),
          );

          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();

          // Move Sylhet by 10 pixels + 10 more pixels upward
          final adjustedCenter = selectedDivision != null
              ? Offset(center.dx + 10, center.dy)
              : Offset(center.dx + 10, center.dy);

          // Draw text
          textPainter.paint(
            canvas,
            Offset(
              adjustedCenter.dx - textPainter.width / 2,
              adjustedCenter.dy,
            ),
          );
        } else {
          // Default positioning for other divisions
          final textSpan = TextSpan(
            text: divisionName,
            style: TextStyle(
              color: Colors.white,
              fontSize: selectedDivision != null ? 16 : 9,
              fontWeight: FontWeight.bold,
            ),
          );

          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          );

          textPainter.layout();

          // Draw text
          textPainter.paint(
            canvas,
            Offset(center.dx - textPainter.width / 2, center.dy),
          );
        }
      }
    }
  }

  void _drawDivisionData(
    Canvas canvas,
    Size size,
    double pWidth,
    double pHeight,
  ) {
    // Don't draw division data when Dhaka is selected (showing detailed district map)
    if (selectedDivision == 'Dhaka' ||
        selectedDivision == 'Rangpur' ||
        selectedDivision == 'Rajshahi') {
      return;
    }

    final divisions = [
      {'name': 'Rangpur', 'x': 6.2 + 139.23 / 2, 'y': 3.12 + 132.73 / 2},
      {'name': 'Rajshahi', 'x': 1.76 + 138.64 / 2, 'y': 114.89 + 120.51 / 2},
      {'name': 'Khulna', 'x': 43.74 + 108.13 / 2, 'y': 206.29 + 210.79 / 2},
      {
        'name': 'Chattogram',
        'x': 197.46 + 162.88 / 2,
        'y': 198.71 + 300.01 / 2,
      },
      {'name': 'Sylhet', 'x': 227.61 + 118.54 / 2, 'y': 121 + 101.58 / 2},
      {'name': 'Dhaka', 'x': 100.79 + 151.94 / 2, 'y': 155.05 + 161.75 / 2},
      {'name': 'Mymensingh', 'x': 127.1 + 125.93 / 2, 'y': 102.37 + 96.64 / 2},
      {'name': 'Barishal', 'x': 144.54 + 86.34 / 2, 'y': 296.8 + 106.65 / 2},
    ];

    for (var division in divisions) {
      final divisionName = division['name'] as String;
      final data = divisionData?[divisionName];

      // Only show data for selected division or all divisions
      if ((data != null && data.isNotEmpty) &&
          (selectedDivision == null || selectedDivision == divisionName)) {
        Offset center;

        if (selectedDivision != null && selectedDivision == divisionName) {
          // Center the data for selected division
          center = Offset(size.width / 2, size.height / 2);
        } else {
          // Use original position for all divisions view
          center = Offset(
            (division['x'] as double) / pWidth * size.width,
            (division['y'] as double) / pHeight * size.height,
          );
        }

        // Special positioning for Chattogram
        if (divisionName == 'Chattogram') {
          // Draw data text to the right of the division name
          final dataSpan = TextSpan(
            text: data,
            style:
                dataTextStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: selectedDivision != null ? 12 : 7,
                  fontWeight: FontWeight.w500,
                ),
          );

          final dataPainter = TextPainter(
            text: dataSpan,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
          );

          dataPainter.layout();

          // Position data to the right with 15px spacing (original position)
          final dataX = center.dx + (selectedDivision != null ? 20 : 15);
          final dataY = center.dy;

          // Draw data text
          dataPainter.paint(
            canvas,
            Offset(dataX, dataY - dataPainter.height / 2),
          );
        } else if (divisionName == 'Sylhet') {
          // Special positioning for Sylhet data - moved by 10 pixels
          final dataSpan = TextSpan(
            text: data,
            style:
                dataTextStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: selectedDivision != null ? 12 : 7,
                  fontWeight: FontWeight.w500,
                ),
          );

          final dataPainter = TextPainter(
            text: dataSpan,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          );

          dataPainter.layout();

          // Move Sylhet data by 10 pixels to match the text
          final adjustedCenter = selectedDivision != null
              ? Offset(center.dx + 10, center.dy)
              : Offset(center.dx + 10, center.dy);

          // Draw data text - positioned above the division name
          dataPainter.paint(
            canvas,
            Offset(
              adjustedCenter.dx - dataPainter.width / 2,
              adjustedCenter.dy - 14,
            ),
          );
        } else {
          // Default positioning for other divisions
          final dataSpan = TextSpan(
            text: data,
            style:
                dataTextStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: selectedDivision != null ? 12 : 7,
                  fontWeight: FontWeight.w500,
                ),
          );

          final dataPainter = TextPainter(
            text: dataSpan,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center,
          );

          dataPainter.layout();

          // Draw data text
          dataPainter.paint(
            canvas,
            Offset(
              center.dx - dataPainter.width / 2,
              center.dy + (selectedDivision != null ? 28 : 18),
            ),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ColoredDivisionPainter extends CustomPainter {
  final CustomPainter originalPainter;
  final Color color;

  _ColoredDivisionPainter(this.originalPainter, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Apply color transformation
    final paint = Paint()
      ..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);

    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    originalPainter.paint(canvas, size);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
