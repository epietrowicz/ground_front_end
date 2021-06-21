import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ground_front_end/screens/analysis/page_view_screen.dart';
import 'package:ground_front_end/screens/analysis/photo_screen.dart';
import 'package:ground_front_end/screens/analysis/results_screen.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import 'package:localstorage/localstorage.dart';

import '../../constants.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen(
      {this.xResults,
      this.yResults,
      this.date,
      this.brewMethod,
      this.grindSetting});
  final List<double> xResults;
  final List<double> yResults;
  final String date;
  final String brewMethod;
  final String grindSetting;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class ResultsItem {
  List<dynamic> xs;
  List<dynamic> ys;
  String date;
  String brewMethod;
  String grindSetting;

  ResultsItem(
      {this.xs, this.ys, this.date, this.grindSetting, this.brewMethod});
  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['date'] = date;
    m['xs'] = xs;
    m['ys'] = ys;
    m['brewMethod'] = brewMethod;
    m['grindSetting'] = grindSetting;

    return m;
  }
}

class ResultsList {
  List<ResultsItem> results = [];
  toJSONEncodable() {
    return results.map((result) {
      return result.toJSONEncodable();
    }).toList();
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  final LocalStorage storage = new LocalStorage('results_page');
  final ResultsList list = new ResultsList();
  bool _initalized = false;
  bool _getNavBar = false;
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    List existingResultList = storage.getItem('results');
    if (existingResultList != null) {
      for (var existingResult in existingResultList) {
        final r = new ResultsItem(
            xs: existingResult['xs'],
            ys: existingResult['ys'],
            grindSetting: existingResult['grindSetting'],
            brewMethod: existingResult['brewMethod'],
            date: existingResult['date']);
        list.results.add(r);
      }
    }
    if (widget.xResults != null) {
      _addItem(widget.xResults, widget.yResults, widget.brewMethod,
          widget.grindSetting, widget.date);
    }
  }

  _addItem(List<double> xs, List<double> ys, String brewMethod,
      String grindSetting, String date) {
    setState(() {
      final result = new ResultsItem(
          xs: xs,
          ys: ys,
          brewMethod: brewMethod,
          grindSetting: grindSetting,
          date: date);
      list.results.add(result);
      _saveToStorage();
    });
  }

  _saveToStorage() {
    storage.setItem('results', list.toJSONEncodable());
  }

  _clearStorage() async {
    await storage.clear();

    setState(() {
      list.results = storage.getItem('results') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff205D50),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Container(),
        elevation: 2.0,
        backgroundColor: Color(0xFF205D50),
        title: Text('roastlytics', style: kH1TextStyle),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.camera),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PhotoScreen();
              }));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!_initalized) {
              var results = storage.getItem('results');

              if (results != null) {
                list.results = List<ResultsItem>.from(
                  (results as List).map(
                    (result) => ResultsItem(
                        xs: result['xs'],
                        ys: result['ys'],
                        brewMethod: result['brewMethod'],
                        grindSetting: result['grindSetting'],
                        date: result['date']),
                  ),
                );
              }
              _initalized = true;
            }

            // List<Widget> widgets = [];
            // if (list.results != null) {
            //   for (var item in list.results) {
            //     widgets.add(
            // ListTile(
            //   onTap:
            //   () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) {
            //       return ResultsScreen(
            //         isNewAnalysis: false,
            //       );
            //     }));
            //   },
            //   visualDensity: VisualDensity(vertical: 3.0),
            //   // isThreeLine: true,
            //   contentPadding:
            //       EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
            //   title: Text(
            //     'Brew saved on ' + item.date.toString(),
            //     style: TextStyle(
            //         color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            //   subtitle: Row(
            //     children: <Widget>[
            //       Icon(
            //         Icons.settings,
            //         color: Colors.white24,
            //         size: 20.0,
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Container(
            //         width: 105.0,
            //         child: Text(item.grindSetting.toString(),
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(color: Colors.white)),
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Icon(
            //         Icons.local_cafe,
            //         color: Colors.white24,
            //         size: 20.0,
            //       ),
            //       SizedBox(
            //         width: 5.0,
            //       ),
            //       Container(
            //         width: 105.0,
            //         child: Text(item.brewMethod.toString(),
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(color: Colors.white)),
            //       )
            //     ],
            //   ),
            //   trailing: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(Icons.keyboard_arrow_right,
            //           color: Colors.white, size: 35.0),
            //     ],
            //   )));
            //widgets.add(Text(item.xs.toString()));
            //   }
            // }
            return ListView.builder(
              itemCount: list.results.length,
              itemBuilder: (context, index) {
                final savedItem = list.results[index];
                return Column(
                  children: [
                    Dismissible(
                        onDismissed: (direction) {
                          setState(() {
                            //widgets.removeAt(index);
                            list.results.removeAt(index);
                            _saveToStorage();
                          });
                        },
                        background: Container(color: Colors.red),
                        key: Key(savedItem.hashCode.toString()),
                        child: ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ResultsScreen(
                                  isNewAnalysis: false,
                                  xHist: savedItem.xs.cast<double>(),
                                  yHist: savedItem.ys.cast<double>(),
                                );
                              }));
                            },
                            visualDensity: VisualDensity(vertical: 3.0),
                            // isThreeLine: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 0.0),
                            title: Text(
                              'Brew saved on ' + savedItem.date.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  color: Colors.white24,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 105.0,
                                  child: Text(savedItem.grindSetting.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white)),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.local_cafe,
                                  color: Colors.white24,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Container(
                                  width: 105.0,
                                  child: Text(savedItem.brewMethod.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white)),
                                )
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white, size: 35.0),
                              ],
                            ))),
                    Divider(
                      color: Colors.white24,
                      indent: 50,
                      endIndent: 50,
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
