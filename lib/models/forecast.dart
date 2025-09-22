class Forecastdata {
  String day;
  String condition;
  String maxTemp;
  String minTemp;
  String iconUrl;

  // Constructor
  Forecastdata({
    required this.day,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
    required this.iconUrl,
  });

  // Factory method to create Forecastdata from JSON
  factory Forecastdata.fromJson(Map<String, dynamic> json) {
    // Extracting values from the forecast for a specific day
    var dayData = json["day"];
    var conditionData = dayData["condition"];

    return Forecastdata(
      day: json["date"], // Assuming 'date' represents the day
      condition: conditionData["text"], // Extract the condition text
      maxTemp: dayData["maxtemp_c"].toString(), // Max temp in Celsius
      minTemp: dayData["mintemp_c"].toString(), // Min temp in Celsius
      iconUrl: conditionData["icon"], // Icon URL for the condition
    );
  }
}
