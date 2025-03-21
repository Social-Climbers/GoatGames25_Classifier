import 'package:flutter/material.dart';
import 'package:goatgames2025classifier/routeData%20copy.dart';
import 'package:goatgames2025classifier/routeData.dart';

class CrestScoreCardScreen extends StatefulWidget {
  @override
  _CrestScoreCardScreenState createState() => _CrestScoreCardScreenState();
}

class _CrestScoreCardScreenState extends State<CrestScoreCardScreen> {
  bool isFemale = false;
  bool disableWeight = false;
  String tier = "Unclassified";
  double totalScore = 0;
  double requiredScore = 0;
  int topRoutesRange = 10;
  TextEditingController MinScoreTextController = TextEditingController();
  TextEditingController TopRoutesRangeController = TextEditingController();

  void _calculateScore() {
    double totalScore = 0;
    bool completedAllSilverhorn = true;
    bool climbedAnyIbex = false;

    // Reset the top 10 flag for all routes
    for (var route in Crest16) {
      route["isTop10"] = false;
    }

    // Filter routes where Top is checked
    var topRoutes =
        Crest16.where((route) => route["Top"] == true || route["Zone"] == true)
            .toList();

    // Sort the routes by route number in descending order
    topRoutes.sort((a, b) {
      int aRouteNumber = int.parse(a["Route"].split(" ")[1]);
      int bRouteNumber = int.parse(b["Route"].split(" ")[1]);
      return bRouteNumber.compareTo(aRouteNumber);
    });

    // Take the top routes based on the specified range
    topRoutes = topRoutes.take(topRoutesRange).toList();

    // Mark the top routes
    for (var route in topRoutes) {
      route["isTop10"] = true;
    }

    for (var route in topRoutes) {
      int routeNumber = int.parse(route["Route"].split(" ")[1]);

      if (routeNumber >= 13 && route["Top"]) {
        climbedAnyIbex = true;
      }

      bool isSilverhorn =
          (isFemale && routeNumber <= 12) || (!isFemale && routeNumber <= 9);

      if (route["Top"]) {
        totalScore +=
            route["Top Points"] * (disableWeight ? 1 : route["Top Weight"]);
      } else if (isSilverhorn) {
        completedAllSilverhorn = false;
      }

      if (route["Zone"]) {
        totalScore +=
            route["Zone Points"] * (disableWeight ? 1 : route["Zone Weight"]);
      }

      if ((isFemale && routeNumber >= 10 && route["Top"]) ||
          (!isFemale && routeNumber >= 13 && route["Top"])) {
        climbedAnyIbex = true;
      }
    }

    // If there are less than 10 top routes, add the zone points of the remaining routes
    if (topRoutes.length < topRoutesRange) {
      var remainingRoutes = Crest16.where((route) => !route["Top"])
          .toList()
          .take(topRoutesRange - topRoutes.length);

      for (var route in remainingRoutes) {
        if (route["Zone"]) {
          totalScore +=
              route["Zone Points"] * (disableWeight ? 1 : route["Zone Weight"]);
          route["isTop10"] = true; // Mark the zone as part of the top 10
        }
      }
    }

    this.totalScore = totalScore;
    tier =
        (totalScore >= requiredScore || climbedAnyIbex) ? "Ibex" : "Silverhorn";
    print(this.totalScore);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    requiredScore = isFemale == false ? 40800 : 34000;
    MinScoreTextController.text = requiredScore.toString();
    TopRoutesRangeController.text = topRoutesRange.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Male"),
                        Switch(
                          value: isFemale,
                          onChanged: (bool value) {
                            setState(() {
                              isFemale = value;
                              setState(() {
                                requiredScore =
                                    isFemale == false ? 40800 : 34000;
                                MinScoreTextController.text =
                                    requiredScore.toString();
                              });
                            });
                          },
                          activeColor: Colors.pink,
                          inactiveThumbColor: Colors.blue,
                          activeTrackColor: Colors.grey,
                          inactiveTrackColor: Colors.grey,
                        ),
                        Text("Female"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Row(
                          children: [
                            Text('Score Range: '),
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: TopRoutesRangeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    topRoutesRange =
                                        int.tryParse(value) ?? topRoutesRange;
                                    _calculateScore();
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    topRoutesRange =
                                        int.tryParse(value) ?? topRoutesRange;
                                    _calculateScore();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Checkbox(
                          value: disableWeight,
                          onChanged: (bool? value) {
                            setState(() {
                              disableWeight = value ?? false;
                              _calculateScore();
                            });
                          },
                        ),
                        Text("Disable Weight"),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              for (var route in Crest16) {
                                route["Zone"] = false;
                                route["Top"] = false;
                                route["isTop10"] = false;
                              }
                              totalScore = 0;
                              tier = "Unclassified";
                            });
                          },
                          child: Text("Clear"),
                        ),
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 80, top: 20),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 15,
                    columns: [
                      DataColumn(
                          label: Text("Route",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Grade",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Zone",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Top",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Zone Pts",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Zone Wgt",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Top Pts",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Top Wgt",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Total Pts",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text("Top Routes",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: Crest16.map((route) {
                      TextEditingController zonePointsController =
                          TextEditingController(
                              text: route["Zone Points"].toString());
                      TextEditingController topPointsController =
                          TextEditingController(
                              text: route["Top Points"].toString());

                      Color rowColor = Colors.transparent;
                      if (route["Zone"]) {
                        rowColor = Colors.grey[200]!;
                      }
                      if (route["Top"]) {
                        rowColor = Colors.grey[300]!;
                      }
                      if (route["isTop10"]) {
                        rowColor = Colors.blue[100]!;
                      }
                      double totalPoints = (route["Zone"]
                              ? route["Zone Points"] *
                                  (disableWeight ? 1 : route["Zone Weight"])
                              : 0) +
                          (route["Top"]
                              ? route["Top Points"] *
                                  (disableWeight ? 1 : route["Top Weight"])
                              : 0);
                      return DataRow(
                        color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return rowColor;
                          },
                        ),
                        cells: [
                          DataCell(Text(
                            route["Route"] +
                                ((isFemale == false
                                        ? route["Required for Ibex Male"]
                                        : route["Required for Ibex Female"])
                                    ? " *"
                                    : ""),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataCell(
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: route["Color1"],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 10,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                    color: route["Color2"],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              value: route["Zone"],
                              onChanged: (bool? value) {
                                setState(() {
                                  route["Zone"] = value ?? false;
                                  if (!route["Zone"]) {
                                    route["Top"] = false;
                                  }
                                  _calculateScore();
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                          DataCell(
                            Checkbox(
                              value: route["Top"],
                              onChanged: (bool? value) {
                                setState(() {
                                  route["Top"] = value ?? false;
                                  if (value == true) {
                                    route["Zone"] = true;
                                  }
                                  _calculateScore();
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          ),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: zonePointsController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    route["Zone Points"] = double.tryParse(
                                            zonePointsController.text) ??
                                        route["Zone Points"];
                                    _calculateScore();
                                  });
                                },
                              ),
                            ),
                          ),
                          DataCell(Text(
                            route["Zone Weight"].toString(),
                            style: TextStyle(
                              color: disableWeight
                                  ? Colors.blueGrey.shade200
                                  : Colors.black,
                            ),
                          )),
                          DataCell(
                            SizedBox(
                              width: 50,
                              child: TextField(
                                controller: topPointsController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                ),
                                onSubmitted: (value) {
                                  setState(() {
                                    route["Top Points"] = double.tryParse(
                                            topPointsController.text) ??
                                        route["Top Points"];
                                    _calculateScore();
                                  });
                                },
                              ),
                            ),
                          ),
                          DataCell(Text(
                            route["Top Weight"].toString(),
                            style: TextStyle(
                              color: disableWeight
                                  ? Colors.blueGrey.shade200
                                  : Colors.black,
                            ),
                          )),
                          DataCell(Text(totalPoints.toStringAsFixed(2),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: !route["isTop10"]
                                      ? Colors.grey
                                      : Colors.black))),
                          DataCell(
                            route["isTop10"]
                                ? Icon(Icons.check, color: Colors.green)
                                : SizedBox.shrink(),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Score: ${totalScore.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                SizedBox(width: 30),
                Row(
                  children: [
                    Text(
                      'Threshold: ',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: MinScoreTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            requiredScore =
                                double.tryParse(value) ?? requiredScore;
                            _calculateScore();
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            requiredScore =
                                double.tryParse(value) ?? requiredScore;
                            _calculateScore();
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          requiredScore = isFemale == false ? 40800 : 34000;
                          MinScoreTextController.text =
                              requiredScore.toString();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Text(
                  'To Ibex: ${requiredScore - totalScore}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  'Your Tier: $tier',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
