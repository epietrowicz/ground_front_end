import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ground_front_end/widgets/ground_distro_graph.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:ground_front_end/widgets/reusable_card.dart';
import 'package:ground_front_end/constants.dart';
import 'package:dio/dio.dart';

class HistData {
  List<dynamic> xHist;
  List<dynamic> yHist;

  HistData({this.xHist, this.yHist});

  factory HistData.fromJson(Map<String, dynamic> parsedJson) {
    return HistData(xHist: parsedJson['x_axis'], yHist: parsedJson['y_axis']);
  }
}

class ResultsScreen extends StatefulWidget {
  ResultsScreen({this.imageFile, this.grinder, this.brewMethod});
  final String grinder;
  final String brewMethod;
  final File imageFile;
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
    // var apiUrl =
    //    'http://coffee-flask-env-docker.eba-3txymmh3.us-east-1.elasticbeanstalk.com/histogram/image';
    var apiUrl = 'http://localhost:5000/histogram/image';
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
          child: FutureBuilder<Response<dynamic>>(
            future: _getApiResults(widget.imageFile),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'There was an error :( \n \nMake sure the paper edge can be clearly distinguished',
                  style: Theme.of(context).textTheme.headline5,
                );
              } else if (snapshot.hasData) {
                final jsonResponse = json.decode(snapshot.data.toString());
                HistData histData = new HistData.fromJson(jsonResponse);

                List<double> xs =
                    histData.xHist.map((s) => s as double).toList();
                // I don't know why this needs to be done this way
                List<double> ys = [];
                for (int y in histData.yHist) {
                  ys.add(y.toDouble());
                }

                List<Widget> listDataView = [];
                for (var item in histData.xHist) {
                  Widget singleCard = Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      //width: 160,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF205D50),
                        border: Border.all(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: EasyRichText(
                                'Patricle size: ' +
                                    item.toStringAsFixed(2) +
                                    'mm 2',
                                defaultStyle: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                                patternList: [
                                  EasyRichTextPattern(
                                      targetString: '2',
                                      superScript: true,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );

                  listDataView.add(singleCard);
                }
                return Column(
                  children: [
                    GroundDistroGraph(
                      x: xs,
                      y: ys,
                      gradient: graphGradient,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              height: 50,
                              // width: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 3.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5.0),
                                  Icon(
                                    FontAwesomeIcons.coffee,
                                    color: Color(0xFF4C4F5E),
                                    // size: 50,
                                  ),
                                  SizedBox(width: 15.0),
                                  Flexible(
                                    child: Text(
                                      widget.brewMethod,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13.0),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Flexible(
                            child: Container(
                              height: 50,
                              //width: 170,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.white, width: 3.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 5.0),
                                  Icon(
                                    FontAwesomeIcons.cogs,
                                    color: Color(0xFF4C4F5E),
                                    // size: 50,
                                  ),
                                  SizedBox(width: 15.0),
                                  Flexible(
                                    child: Text(
                                      widget.grinder,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.0),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    //   child: Container(
                    //       color: Colors.white,
                    //       child: Text(
                    //         widget.brewMethod,
                    //         style: TextStyle(color: Colors.black),
                    //       )),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        //color: Colors.white,
                        height: 200,
                        child: CupertinoScrollbar(
                          isAlwaysShown: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ListView(
                              // This next line does the trick.
                              scrollDirection: Axis.vertical,
                              children: listDataView,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }
}
