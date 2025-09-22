import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/models/forecast.dart';

class Homepage extends StatefulWidget {
  final String cityName;
  const Homepage({super.key, required this.cityName});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool _isLoading = true;
  WeatherData? _weatherData;
  Future getdata() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      print('API Key: $apiKey');

      final url = Uri.parse("http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${widget.cityName}&aqi=no");
      final res = await http.get(url);

      final data = jsonDecode(res.body);
      setState(() {
        _weatherData = WeatherData.fromJson(data);
        _isLoading = false;
      });
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
                      Text(
                        _weatherData!.cityName,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Image.network(_weatherData!.iconUrl),
                      Text(",${_weatherData!.temperature} .C", style: TextStyle(fontSize: 28, color: Colors.white)),
                      Text(_weatherData!.condition, style: TextStyle(fontSize: 24, color: Colors.white)),

                      Text(
                        "high:${_weatherData!.high} low: ${_weatherData!.low}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text("wind:${_weatherData!.wind} km/hr", style: TextStyle(fontSize: 20, color: Colors.white)),
                      Text("humidity:${_weatherData!.humidity} %", style: TextStyle(fontSize: 20, color: Colors.white)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(onPressed: () {}, child: Text("hourly", style: TextStyle(color: Colors.white))),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => forecast(cityName: widget.cityName)),
                              );
                            },
                            child: Text("weekly", style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
        ),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}

class WeatherData {
  final String cityName;
  final String condition;
  final String iconUrl;
  final double temperature;
  final double high;
  final double low;
  final double wind;
  final int humidity;

  WeatherData({
    required this.cityName,
    required this.condition,
    required this.iconUrl,
    required this.temperature,
    required this.high,
    required this.low,
    required this.wind,
    required this.humidity,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['location']['name'],
      condition: json['current']['condition']['text'],
      iconUrl: "https:${json['current']['condition']['icon']}",
      temperature: (json['current']['temp_c'] as num).toDouble(),
      high: (json['forecast']?['forecastday']?[0]?['day']?['maxtemp_c'] ?? json['current']['temp_c']).toDouble(),
      low: (json['forecast']?['forecastday']?[0]?['day']?['mintemp_c'] ?? json['current']['temp_c']).toDouble(),
      wind: (json['current']['wind_kph'] as num).toDouble(),
      humidity: json['current']['humidity'],
    );
  }
}

class forecast extends StatefulWidget {
  final String cityName;
  const forecast({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Text("forecast");
  }

  @override
  State<forecast> createState() => _forecastState();
}

// http://api.weatherapi.com/v1/forecast.json?key=YOUR_API_KEY&q=Delhi&days=5

class _forecastState extends State<forecast> {
  bool _isLoading = true;
  List<Forecastdata> _forecastList = [];

  Future getdata() async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      print('API Key: $apiKey');
      final url = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${widget.cityName}&days=5");
      final res = await http.get(url);
      final data = jsonDecode(res.body);

      List<Forecastdata> tempList = [];
      for (var item in data['forecast']['forecastday']) {
        tempList.add(Forecastdata.fromJson(item));
      }

      print(_forecastList);
      setState(() {
        _forecastList = tempList;
        _isLoading = false;
      });

      print(data);
    } catch (e) {
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    print("initstate");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            _isLoading
                ? CircularProgressIndicator()
                : Center(
                  child: Column(
                    children: [
                      Text(
                        "Daily forecast",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.cyanAccent,
                        ),
                      ),

                      Card(
                        child: Column(
                          children: [
                            for (var forecast in _forecastList)
                              ListTile(
                                leading: Image.network(forecast.iconUrl),
                                title: Text(forecast.day),
                                subtitle: Text("Condition: ${forecast.condition}"),
                                trailing: Text("Max: ${forecast.maxTemp}°C\nMin: ${forecast.minTemp}°C"),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
