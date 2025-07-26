# Map BD - Interactive Bangladesh Map Flutter Package

A beautiful, interactive Flutter package that displays a detailed map of Bangladesh with all 8 administrative divisions. This package provides a customizable, interactive map experience perfect for educational apps, tourism applications, data visualization, and geographic learning.

## 🌟 Features

### 🗺️ **Interactive Map Display**
- **8 Administrative Divisions**: Rangpur, Rajshahi, Khulna, Chattogram, Sylhet, Dhaka, Mymensingh, and Barishal
- **Custom Painted Graphics**: High-quality vector graphics using Flutter's CustomPainter
- **Accurate Geographic Representation**: Based on official Bangladesh administrative boundaries
- **Color-coded Divisions**: Each division has a distinct color for easy identification

### 🎯 **Interactive Functionality**
- **Click to Focus**: Tap any division to view it in full-screen mode
- **Centered Display**: Selected divisions are centered and scaled to fit the screen
- **Back Navigation**: Easy return to full map view with a stylish back button
- **Smooth Transitions**: Immediate visual feedback for user interactions

### 📊 **Custom Data Support**
- **Division-specific Data**: Display custom string data for each division
- **Flexible Styling**: Customizable text styles for data display
- **Dynamic Content**: Show/hide data as needed
- **Positioned Text**: Smart text positioning that adapts to full-screen mode

### 🎨 **Visual Customization**
- **Clean Text Display**: Division names and data without background clutter
- **Responsive Design**: Adapts to different screen sizes
- **Professional Appearance**: Modern, minimalist interface
- **Accessible Colors**: High contrast for readability

## 📦 Installation

Add this dependency to your `pubspec.yaml`:

```yaml
dependencies:
  map_bd: ^1.0.0
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:map_bd/map_bd.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Bangladesh Map')),
        body: Center(
          child: MapBD(
            width: 360.59,
            height: 400,
          ),
        ),
      ),
    );
  }
}
```

### With Custom Data

```dart
MapBD(
  width: 360.59,
  height: 400,
  divisionData: {
    'Dhaka': 'Capital City',
    'Chattogram': 'Port City',
    'Sylhet': 'Tea Gardens',
    'Rangpur': 'Agriculture Hub',
    'Rajshahi': 'Silk City',
    'Khulna': 'Mangrove Forest',
    'Mymensingh': 'Education Center',
    'Barishal': 'River Port',
  },
  showData: true,
  dataTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  ),
)
```

## 🎛️ API Reference

### MapBD Widget

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `width` | `double` | `360.59` | Width of the map widget |
| `height` | `double` | `400` | Height of the map widget |
| `divisionData` | `Map<String, String>?` | `null` | Custom data for each division |
| `showData` | `bool` | `false` | Whether to display division data |
| `dataTextStyle` | `TextStyle?` | `null` | Custom style for data text |

### Division Names
The package supports all 8 administrative divisions of Bangladesh:
- **Rangpur** (রংপুর)
- **Rajshahi** (রাজশাহী)
- **Khulna** (খুলনা)
- **Chattogram** (চট্টগ্রাম)
- **Sylhet** (সিলেট)
- **Dhaka** (ঢাকা)
- **Mymensingh** (ময়মনসিংহ)
- **Barishal** (বরিশাল)

## 🎮 Interactive Features

### Full-Screen Mode
When a division is clicked:
- The selected division is displayed in full-screen
- Text and data are centered and enlarged
- Other divisions are hidden
- A back button appears for navigation

### Back Navigation
- Click the back button to return to full map view
- All divisions become visible again
- Text returns to original positioning

## 🎨 Customization Examples

### Custom Colors and Styling
```dart
MapBD(
  width: 400,
  height: 450,
  divisionData: {
    'Dhaka': 'Population: 21.7M',
    'Chattogram': 'Port: Chittagong',
  },
  showData: true,
  dataTextStyle: TextStyle(
    color: Colors.yellow,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 2,
        color: Colors.black,
      ),
    ],
  ),
)
```

### Educational App Integration
```dart
MapBD(
  width: 300,
  height: 350,
  divisionData: {
    'Dhaka': 'Capital & Largest City',
    'Sylhet': 'Famous for Tea Gardens',
    'Chattogram': 'Major Seaport',
    'Rangpur': 'Agricultural Region',
  },
  showData: true,
)
```

## 🏗️ Architecture

### Core Components
- **MapBD Widget**: Main widget that manages state and interactions
- **BangladeshMapPainter**: CustomPainter for rendering the map
- **Division Painters**: Individual CustomPainter classes for each division
- **Interactive Areas**: GestureDetector widgets for click handling

### State Management
- **StatefulWidget**: Manages selected division state
- **Conditional Rendering**: Shows/hides elements based on selection
- **Dynamic Positioning**: Adjusts text and data positioning for different views

## 🎯 Use Cases

### Educational Applications
- **Geography Learning**: Interactive exploration of Bangladesh's divisions
- **History Lessons**: Display historical information for each region
- **Cultural Studies**: Show cultural data and traditions

### Tourism Apps
- **Travel Planning**: Highlight tourist destinations
- **Regional Information**: Display local attractions and facts
- **Interactive Guides**: Click to learn about specific regions

### Data Visualization
- **Demographic Data**: Show population statistics
- **Economic Information**: Display GDP, industries, etc.
- **Environmental Data**: Show climate, geography information

### Business Applications
- **Regional Analysis**: Display business metrics by division
- **Market Research**: Show demographic and economic data
- **Service Coverage**: Highlight service areas

## 🔧 Technical Details

### Dependencies
- **Flutter**: Core framework
- **dart:ui**: For CustomPainter and canvas operations
- **dart:math**: For mathematical calculations

### Performance
- **Optimized Rendering**: Efficient canvas operations
- **Minimal Memory Usage**: Lightweight implementation
- **Smooth Interactions**: Responsive user experience

### Platform Support
- **Android**: Full support
- **iOS**: Full support
- **Web**: Limited support (method channels not available)
- **Desktop**: Full support

## 🤝 Contributing

We welcome contributions! Please feel free to submit issues, feature requests, or pull requests.

### Development Setup
1. Clone the repository
2. Run `flutter pub get`
3. Navigate to `example/` directory
4. Run `flutter run` to test the package

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Geographic data based on official Bangladesh administrative boundaries
- Inspired by educational and interactive map applications
- Built with Flutter's powerful CustomPainter capabilities

## 📞 Support

For support, questions, or feature requests, please open an issue on the GitHub repository.

---

**Made with ❤️ for Bangladesh and the Flutter community**
