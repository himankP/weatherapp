import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:
              _isLoading
                  ? CircularProgressIndicator()
                  : Column(
                    children: [
                      SizedBox(height: 100),
                      Text("Dlihe", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      Image.network("https://cdn.weatherapi.com/weather/128x128/day/113.png"),
                      Text("23°C", style: TextStyle(fontSize: 28)),
                      Text("Sunny", style: TextStyle(fontSize: 24)),
                      Text("high:31.low20", style: TextStyle(fontSize: 20)),
                      Text("wind:12km/h", style: TextStyle(fontSize: 20)),
                      Text("humidity:50", style: TextStyle(fontSize: 20)),
                    ],
                  ),
        ),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
