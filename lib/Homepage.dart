import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  final String cityName;
  const Homepage({super.key, required this.cityName});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final bool _isLoading = true;
  Future getdata() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      print('API Key: $apiKey');

      final url = Uri.parse("http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${widget.cityName}&aqi=no");
      final res = await http.get(url);

      final data = jsonDecode(res.body);
      print(data);
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    print("build method called");
    super.initState();
  }

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
