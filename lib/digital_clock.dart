// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

enum _Element {
  background,
  text,
}

final _lightTheme = {
  _Element.background: Colors.white,
  _Element.text: Colors.black,
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
};

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  String weatherIcon() {
    if (widget.model.weatherString == "sunny") {
      return 'images/sun.png';
    } else if (widget.model.weatherString == "windy") {
      return 'images/wind.png';
    } else if (widget.model.weatherString == "cloudy") {
      return 'images/cloud.png';
    } else if (widget.model.weatherString == "rainy") {
      return 'images/rain.png';
    } else if (widget.model.weatherString == "foggy") {
      return 'images/fog.png';
    } else if (widget.model.weatherString == "snowy") {
      return 'images/snow.png';
    } else {
      return 'images/thunderstorm.png';
    }
  }

  String setBackground() {
    if (widget.model.weatherString == "sunny") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/sunnyLight.gif';
      } else {
        return 'images/sunnyDark.gif';
      }
    }
    if (widget.model.weatherString == "windy") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/windyLight.gif';
      } else {
        return 'images/windyDark.gif';
      }
    }
    if (widget.model.weatherString == "cloudy") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/cloudyLight.gif';
      } else {
        return 'images/cloudyDark.gif';
      }
    }
    if (widget.model.weatherString == "rainy") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/rainyLight.gif';
      } else {
        return 'images/rainyDark.gif';
      }
    }
    if (widget.model.weatherString == "foggy") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/foggyLight.gif';
      } else {
        return 'images/foggyDark.gif';
      }
    }
    if (widget.model.weatherString == "snowy") {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/snowyLight.gif';
      } else {
        return 'images/snowyDark.gif';
      }
    } else {
      if (Theme.of(context).brightness == Brightness.light) {
        return 'images/thunderLight.gif';
      } else {
        return 'images/thunderDark.gif';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? _lightTheme
        : _darkTheme;
    final setBackgroundcolor = setBackground();
    final imageAsset = weatherIcon();
    final location = widget.model.location.toString();
    final tempeature = widget.model.temperatureString;
    final weekDay = DateFormat('EEEE').format(_dateTime);
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final second = DateFormat('ss').format(_dateTime);
    final date = DateFormat('MMM d y').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 7.5;
    final offset = -fontSize / 20;
    final defaultStyle = TextStyle(
      color: colors[_Element.text],
      fontSize: fontSize,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('$setBackgroundcolor'), fit: BoxFit.cover),
      ),
      child: Container(
          alignment: AlignmentDirectional.bottomStart,

          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

            Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                          child: Image(
                            image: AssetImage('$imageAsset'),
                          ),
                        ),
                        Text(
                          '$tempeature',
                          style: GoogleFonts.blackOpsOne(),
                        ),
                      ],
                    ),
                    Text(
                      '$location',
                      style: GoogleFonts.blackOpsOne(),
                    )
                  ],
                ),




                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '$weekDay , $date',
                              style: GoogleFonts.blackOpsOne(),
                            )
                          ],
                        ),
                        DefaultTextStyle(
                          style: defaultStyle,
                          child: Row(
                            children: <Widget>[
                              Text(
                                '$hour: $minute: $second',
                                style: GoogleFonts.blackOpsOne(),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
//                Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.fromLTRB(0, 0, 10.0, 0),
//                          child: Image(
//                            image: AssetImage('$imageAsset'),
//                          ),
//                        ),
//                        Text(
//                          '$tempeature',
//                          style: GoogleFonts.blackOpsOne(),
//                        ),
//                      ],
//                    ),
//                    Text(
//                      '$location',
//                      style: GoogleFonts.blackOpsOne(),
//                    )
//                  ],
//                )
              ],
            ),
          )),
    );
  }
}
