import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ground_front_end/screens/analysis/history_screen.dart';
import 'package:ground_front_end/widgets/ground_distro_graph.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:ground_front_end/widgets/reusable_card.dart';
import 'package:ground_front_end/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HistData {
  List<dynamic> xHist;
  List<dynamic> yHist;

  HistData({this.xHist, this.yHist});

  factory HistData.fromJson(Map<String, dynamic> parsedJson) {
    return HistData(xHist: parsedJson['x_axis'], yHist: parsedJson['y_axis']);
  }
}

class ResultsScreen extends StatefulWidget {
  ResultsScreen(
      {this.imageFile,
      this.grinder,
      this.brewMethod,
      this.isNewAnalysis,
      this.xHist,
      this.yHist});
  final String grinder;
  final String brewMethod;
  final File imageFile;
  final bool isNewAnalysis;
  final List<double> xHist;
  final List<double> yHist;
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  HistData histData;

  List<Color> graphGradient = [
    const Color(0xff23b6e6),
  ];

  Future<Response<dynamic>> _getApiResults(File imageToBeAnalyzed) async {
    String fileName = imageToBeAnalyzed.path.split('/').last;
    var dio = Dio();
    var apiUrl =
        'http://coffee-flask-env-docker.eba-3txymmh3.us-east-1.elasticbeanstalk.com/histogram/image';
    // var apiUrl = 'http://localhost:5000/histogram/image';
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageToBeAnalyzed.path,
        filename: fileName,
      ),
    });
    return dio.post(apiUrl, data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF205D50),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF205D50),
        title: Text('roastlytics', style: kH1TextStyle),
      ),
      body: Container(
        child: SafeArea(
          child: widget.isNewAnalysis
              ? FutureBuilder<Response<dynamic>>(
                  future: _getApiResults(widget.imageFile),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'There was an error :( \n \nMake sure the paper edge can be clearly distinguished',
                        style: Theme.of(context).textTheme.headline5,
                      );
                    } else if (snapshot.hasData) {
                      final jsonResponse =
                          json.decode(snapshot.data.toString());
                      HistData histData = new HistData.fromJson(jsonResponse);

                      List<double> xs =
                          histData.xHist.map((s) => s as double).toList();
                      // I don't know why this needs to be done this way
                      List<double> ys = [];
                      for (int y in histData.yHist) {
                        ys.add(y.toDouble());
                      }
                      return ResultWidget(
                        xs: xs,
                        ys: ys,
                        graphGradient: graphGradient,
                        brewMethod: widget.brewMethod,
                        grindSetting: widget.grinder,
                        isNewResult: widget.isNewAnalysis,
                      );
                    } else {
                      return Center(
                        child: Container(
                          height: 250.0,
                          width: 250.0,
                          child: ReusableCard(
                            color: kActiveCardColour,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[CircularProgressIndicator()],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              : ResultWidget(
                  xs: widget.xHist,
                  ys: widget.yHist,
                  graphGradient: graphGradient,
                  brewMethod: widget.brewMethod == null
                      ? 'No brew method'
                      : widget.brewMethod,
                  grindSetting: widget.grinder == null
                      ? 'No grind setting'
                      : widget.grinder,
                  isNewResult: widget.isNewAnalysis,
                ),
        ),
      ),
    );
  }
}

class ResultWidget extends StatelessWidget {
  const ResultWidget(
      {Key key,
      @required this.xs,
      @required this.ys,
      @required this.graphGradient,
      this.brewMethod,
      this.grindSetting,
      @required this.isNewResult});

  final List<double> xs;
  final List<double> ys;
  final List<Color> graphGradient;
  final String brewMethod;
  final String grindSetting;
  final bool isNewResult;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GroundDistroGraph(
          x: xs,
          y: ys,
          gradient: graphGradient,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ReusableCard(
                width: double.infinity,
                onPress: () {
                  print('do something');
                },
                color: kActiveCardColour,
                cardChild: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.coffee,
                        color: Color(0xFF4C4F5E),
                        size: 50,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'BREW METHOD:',
                        style: TextStyle(
                          fontFamily: 'IBMPlexSerif-Light',
                          color: Colors.black,
                          fontSize: 15,
                          //fontWeight: FontWeight.w500
                          //fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(brewMethod, style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: ReusableCard(
                width: double.infinity,
                onPress: () {
                  print('do something');
                },
                color: kActiveCardColour,
                cardChild: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.cogs,
                        color: Color(0xFF4C4F5E),
                        size: 50,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'GRIND SETTING:',
                        style: TextStyle(
                          color: Colors.black, fontFamily: 'IBMPlexSerif-Light',
                          fontSize: 15,

                          //fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        grindSetting,
                        style: TextStyle(
                          color: Colors.black,
                          //fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50.0,
        ),
        isNewResult
            ? NavigationButton(
                activated: true,
                onPressedFunction: () {
                  var now = new DateTime.now();
                  var formatter = new DateFormat('MM/dd/yyyy');
                  String formattedDate = formatter.format(now);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HistoryScreen(
                      date: formattedDate,
                      xResults: xs,
                      yResults: ys,
                      brewMethod: brewMethod,
                      grindSetting: grindSetting,
                    );
                  }));
                },
                label: 'SAVE RESULTS')
            : NavigationButton(
                activated: true,
                onPressedFunction: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HistoryScreen();
                  }));
                },
                label: 'BACK TO HISTORY')
      ],
    );
  }
}
