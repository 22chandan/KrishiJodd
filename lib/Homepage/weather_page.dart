// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:krishijodd/Homepage/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Position? _currentPosition;
  String? _currentAddress;
  bool isLoading = false;
  String? temp;
  String? cond;
  String? iconVal;
  Future<Weather> _getTemparature(latitude, longitude) async {
    try {
      final queryParameters = {
        'key': '9b23054a831f4932ad790845230902',
        'q': '$latitude,$longitude'
      };
      final uri =
          Uri.http('api.weatherapi.com', 'v1/current.json', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error occured');
      }
    } catch (e) {
      rethrow;
    }
  }

  Weather weather = Weather();
  void getTemperatureData(latitude, longitude) async {
    weather = await _getTemparature(latitude, longitude);
    setState(() {
      int val = weather.tempC!.toInt();
      temp = '${val}';
    });
    setState(() {
      cond = weather.condition;
    });
    setState(() {
      iconVal = weather.iconVal;
    });
  }

  Future<Position> _getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location not available');
      }
    } else {
      print('Location not available');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _getAddress(latitude, longitude) async {
    try {
      List<Placemark> placemark = await GeocodingPlatform.instance
          .placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAddress = '${place.locality}, ${place.administrativeArea}';
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    startLocation();
    super.initState();
  }

  void startLocation() async {
    setState(() {
      isLoading = true;
    });
    _currentPosition = await _getPosition();
    _getAddress(_currentPosition!.latitude, _currentPosition!.longitude);
    getTemperatureData(_currentPosition!.latitude, _currentPosition!.longitude);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double currH = MediaQuery.of(context).size.height;
    double currW = MediaQuery.of(context).size.width;
    return isLoading
        // ignore: prefer_const_constructors
        ? Padding(
            padding: const EdgeInsets.all(30),
            child: const CircularProgressIndicator())
        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFEFF3F5),
                  borderRadius: BorderRadius.circular(0.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 3.0)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (temp != null)
                                if (int.parse(temp!) > 15)
                                  Text(
                                    temp!,
                                    style: GoogleFonts.livvic(
                                        color:
                                            Color.fromARGB(255, 241, 116, 20),
                                        fontSize: currH * 0.07,
                                        fontWeight: FontWeight.w400),
                                  )
                                else
                                  Text(
                                    temp!,
                                    style: GoogleFonts.livvic(
                                        color: Color.fromARGB(255, 3, 83, 197),
                                        fontSize: currH * 0.07,
                                        fontWeight: FontWeight.w400),
                                  ),
                              Text(
                                '°C',
                                style: GoogleFonts.livvic(
                                    color: Color.fromARGB(255, 92, 92, 92),
                                    fontSize: currH * 0.07,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          if (_currentAddress != null)
                            Text(
                              _currentAddress!,
                              style: GoogleFonts.livvic(
                                  color: Color.fromARGB(255, 96, 96, 96),
                                  fontSize: currH * 0.023,
                                  fontWeight: FontWeight.w500),
                            )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (iconVal != null)
                                Image.network(
                                  'https:${iconVal!}',
                                  // width: currW - 272,
                                  height: currH * 0.09,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          ),
                          if (cond != null)
                            Text(
                              cond!,
                              style: GoogleFonts.livvic(
                                  color: Color.fromARGB(255, 54, 54, 54),
                                  fontSize: currH * 0.023,
                                  fontWeight: FontWeight.w500),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);
  }
}
