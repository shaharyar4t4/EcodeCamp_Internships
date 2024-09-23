import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/constent.dart';

import '../const.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  String _location = "karachi";  // Default location
  TextEditingController _controller = TextEditingController();  // Controller for search input
  String? _errorMessage;  // Store error message if location is not found

  @override
  void initState() {
    super.initState();
    fetchWeather(_location);  // Initial weather fetch
  }

  // Function to fetch weather by city name and handle errors
  void fetchWeather(String city) async {
    try {
      Weather weather = await _wf.currentWeatherByCityName(city);
      setState(() {
        _weather = weather;
        _errorMessage = null;  // Reset the error message
      });
    } catch (e) {
      setState(() {
        _weather = null;  // Reset the weather to avoid showing outdated data
        _errorMessage = "Location not found";  // Set the error message
      });
    }
  }

  // Function to handle search when submitted
  void _searchLocation() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _location = _controller.text;
        fetchWeather(_location);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGcolor,
      appBar: AppBar(
        toolbarHeight: 110.0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TextField(
          style: TextStyle(color:tdblue),

          controller: _controller,
          decoration: InputDecoration(
            hintText: "Search Location",
            hintStyle: TextStyle(color: tdblue),
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color:tdblue),
              onPressed: _searchLocation,  // Trigger search when button is pressed
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color:tdblue,
                width: 2,
              ),
            ),
            // enable border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
          onSubmitted: (value) => _searchLocation(),  // Trigger search when pressing enter
        ),
      ),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    if (_errorMessage != null) {
      // Display error message when location is not found
      return Center(
        child: Text(
          _errorMessage!,
          style: TextStyle(fontSize: 24, color: Colors.red),
        ),
      );
    }

    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _LocationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _LocationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color:tdblue),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h: mm a").format(now),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color:tdblue),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(fontWeight: FontWeight.w600, color:tdblue),
            ),
            Text(
              "${DateFormat(" d.M.y").format(now)} ",
              style: TextStyle(fontWeight: FontWeight.w600, color:tdblue),
            ),
          ],
        )
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: TextStyle(fontSize: 20, color:tdblue),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: TextStyle(fontSize: 55, fontWeight: FontWeight.w500, color:tdblue),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: tdblack,
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              color: tdblack,
              spreadRadius: 0.01)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)} °C",
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)} °C",
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),

              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %",
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
