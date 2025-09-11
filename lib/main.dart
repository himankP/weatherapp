import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp/Searchpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main(List<String> args) async {
  print('Hello, World!');
  await dotenv.load(fileName: ".env");
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: const Homescreen(), backgroundColor: Colors.cyan));
  }
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.network("https://cdn.weatherapi.com/weather/128x128/day/113.png", width: 128, height: 128),
          Text("WeatherNow", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 24),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Searchpage()));
            },
            child: Text("Get Started", style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
