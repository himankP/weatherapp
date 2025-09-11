import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/Homepage.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextField(
            onSubmitted:
                (String value) => {
                  print('User entered: $value'),
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage(cityName: value))),
                  // You can add your search logic here
                },
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
