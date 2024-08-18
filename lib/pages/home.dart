import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meteomuse/includes/colors.dart';
import 'package:meteomuse/model/weatherModel.dart';
import 'package:meteomuse/pages/forecast.dart';
import 'package:meteomuse/pages/perception.dart';
import 'package:meteomuse/pages/today.dart';
import 'package:meteomuse/services/location_service.dart';
import 'package:meteomuse/services/weather_service.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  late LocationService _locationService;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _locationService = Provider.of<LocationService>(context, listen: false);
    _initializeLocationService();
  }

  void _initializeLocationService() async {
    await _locationService.checkAndRequestLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context);

    return ChangeNotifierProvider(
      create: (_) => _locationService,
      child: Scaffold(
        backgroundColor: MyColors.primaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            toolbarHeight: 40.0,
            title: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ' ${LocationService.currentAddress}',
                    style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            backgroundColor: MyColors.backgroungPrimary,
            leading: Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  color: MyColors.textColorwhite,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Text(
                    "Today",
                    style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.white : MyColors.lighttextcolor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Text(
                    "Forecast",
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.white : MyColors.lighttextcolor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Text(
                    "Perception",
                    style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.white : MyColors.lighttextcolor,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _buildPageContent(),
            ),
            Divider(
              color: MyColors.lighttextcolor,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    switch (_selectedIndex) {
      case 0:
        return Today(); // Replace with your widget for "Today"
      case 1:
        return ForecastPage(); // Replace with your widget for "Forecast"
      case 2:
        return PerceptionPage(); // Replace with your widget for "Perception"
      default:
        return Container(); // Default empty container if something goes wrong
    }
  }
}
