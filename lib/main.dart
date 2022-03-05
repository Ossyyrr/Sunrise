/*import 'package:solar_calculator/solar_calculator.dart';
import 'package:solar_calculator/src/instant.dart';

void main() {
  const latitude = 41.387048;
  const longitude = 2.17413425;

  final instant = Instant(year: 2021, month: 5, day: 10, hour: 14, timeZoneOffset: 2.0);

  final calc = SolarCalculator(instant, latitude, longitude);

  print('Sun Equatorial position:');
  print(
      '    Right ascension: ${calc.sunEquatorialPosition.rightAscension} = ${calc.sunEquatorialPosition.rightAscension.decimalDegrees}');
  print('    Declination: ${calc.sunEquatorialPosition.declination}');

  print('Sun Horizontal position:');
  print('    Azimuth: ${calc.sunHorizontalPosition.azimuth}');
  print('    Elevation: ${calc.sunHorizontalPosition.elevation}');

  print('Morning astronomical twilight:');
  print('    Begining: ${calc.morningAstronomicalTwilight.begining}');
  print('    Ending: ${calc.morningAstronomicalTwilight.ending}');
  print('    Duration: ${calc.morningAstronomicalTwilight.duration}');

  print('Morning nautical twilight:');
  print('    Begining: ${calc.morningNauticalTwilight.begining}');
  print('    Ending: ${calc.morningNauticalTwilight.ending}');
  print('    Duration: ${calc.morningNauticalTwilight.duration}');

  print('Morning civil twilight:');
  print('    Begining: ${calc.morningCivilTwilight.begining}');
  print('    Ending: ${calc.morningCivilTwilight.ending}');
  print('    Duration: ${calc.morningCivilTwilight.duration}');

  print('Sunrise: ${calc.sunriseTime}');
  print('Noon: ${calc.sunTransitTime}');
  print('Sunset: ${calc.sunsetTime}');

  print('Evening civil twilight:');
  print('    Begining: ${calc.eveningCivilTwilight.begining}');
  print('    Ending: ${calc.eveningCivilTwilight.ending}');
  print('    Duration: ${calc.eveningCivilTwilight.duration}');

  print('Evening nautical twilight:');
  print('    Begining: ${calc.eveningNauticalTwilight.begining}');
  print('    Ending: ${calc.eveningNauticalTwilight.ending}');
  print('    Duration: ${calc.eveningNauticalTwilight.duration}');

  print('Evening astronomical twilight:');
  print('    Begining: ${calc.eveningAstronomicalTwilight.begining}');
  print('    Ending: ${calc.eveningAstronomicalTwilight.ending}');
  print('    Duration: ${calc.eveningAstronomicalTwilight.duration}');

  if (calc.isHoursOfDarkness) print('===> IS DARK <===');
}
*/

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:solar_calculator/solar_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double>? _magnetometerValues;
  double az = 0.0;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
// SOLAR -----
  double latitude = 41.387048;
  double longitude = 2.17413425;
  final instant = Instant(year: 2021, month: 5, day: 10, hour: 14, timeZoneOffset: 2.0);
  late SolarCalculator calc;
// SOLAR -----

  @override
  void initState() {
    super.initState();

// SOLAR -----
    calc = SolarCalculator(instant, latitude, longitude);

    print('Sun Equatorial position:');
    print(
        '    Right ascension: ${calc.sunEquatorialPosition.rightAscension} = ${calc.sunEquatorialPosition.rightAscension.decimalDegrees}');
    print('    Declination: ${calc.sunEquatorialPosition.declination}');

    print('Sun Horizontal position:');
    print('    Azimuth: ${calc.sunHorizontalPosition.azimuth}');
    print('    Elevation: ${calc.sunHorizontalPosition.elevation}');

    print('Morning astronomical twilight:');
    print('    Begining: ${calc.morningAstronomicalTwilight.begining}');
    print('    Ending: ${calc.morningAstronomicalTwilight.ending}');
    print('    Duration: ${calc.morningAstronomicalTwilight.duration}');

    print('Morning nautical twilight:');
    print('    Begining: ${calc.morningNauticalTwilight.begining}');
    print('    Ending: ${calc.morningNauticalTwilight.ending}');
    print('    Duration: ${calc.morningNauticalTwilight.duration}');

    print('Morning civil twilight:');
    print('    Begining: ${calc.morningCivilTwilight.begining}');
    print('    Ending: ${calc.morningCivilTwilight.ending}');
    print('    Duration: ${calc.morningCivilTwilight.duration}');

    print('Sunrise: ${calc.sunriseTime}');
    print('Noon: ${calc.sunTransitTime}');
    print('Sunset: ${calc.sunsetTime}');

    print('Evening civil twilight:');
    print('    Begining: ${calc.eveningCivilTwilight.begining}');
    print('    Ending: ${calc.eveningCivilTwilight.ending}');
    print('    Duration: ${calc.eveningCivilTwilight.duration}');

    print('Evening nautical twilight:');
    print('    Begining: ${calc.eveningNauticalTwilight.begining}');
    print('    Ending: ${calc.eveningNauticalTwilight.ending}');
    print('    Duration: ${calc.eveningNauticalTwilight.duration}');

    print('Evening astronomical twilight:');
    print('    Begining: ${calc.eveningAstronomicalTwilight.begining}');
    print('    Ending: ${calc.eveningAstronomicalTwilight.ending}');
    print('    Duration: ${calc.eveningAstronomicalTwilight.duration}');

    if (calc.isHoursOfDarkness) print('===> IS DARK <===');
// SOLAR -----

    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
            az = 90 - atan2(event.y, event.x) * 180 / pi;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final magnetometer = _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_left,
                color: (calc.sunHorizontalPosition.azimuth.round() > az.round()) ? Colors.green : Colors.red,
                size: 100,
              ),
              Icon(
                Icons.circle,
                color: (calc.sunHorizontalPosition.azimuth.round() == az.round()) ? Colors.green : Colors.red,
                size: 70,
              ),
              Icon(
                Icons.arrow_right,
                color: (calc.sunHorizontalPosition.azimuth.round() < az.round()) ? Colors.green : Colors.red,
                size: 100,
              ),
            ],
          ),
          Text('Magnetometer: $magnetometer'),
          Text('AZ: ' + az.toString()),
          Text('Sun horizntal position - Azimuth: ${calc.sunHorizontalPosition.azimuth}'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
