import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>{

// api key
final _WeatherService = WeatherService('your weather api key');
Weather? _weather;

// fetch weather
_fetchWeather() async {
  // get the current city 
String cityName = await _WeatherService.getCurrentCity();
  // get the weather for current city
  try {
    final weather = await _WeatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }
  // any errors
  catch (e) {
    print(e);
  }
}
//weather animation
String getWeatherAnimation( String? mainCondition) {
  if (mainCondition == null) return "assets/sunny.json";//defult to sunnny 
 
 switch (mainCondition.toLowerCase()) {

case 'clouds':
case 'mist':
case 'smoke':
case 'haze':
case 'dust':
case 'fog':
   return 'assets/cloud.json';
case 'rain':
case 'drizzle':
case 'shower rain':
  return 'assets/rain.json';
  case 'thunderstorm':
  return 'assets/thunder.json';
  case 'clear':
  return 'assets/sunny.json';
  default:
  return "assets/sunny.json";
 }
}

//intt state 
@override
void initState() {
  super.initState();

  // featch weather  on strtup
  _fetchWeather();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 128, 201, 206),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //city name
          Text(_weather?.cityName ?? "Loading City.."),

        // animation
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          //temprature
          Text('${_weather?.temperature.round()}°C'),

          //wether conditions 
          Text(_weather?.mainCondition ??"")
        ],
        ),
      ),
    );
  }
}