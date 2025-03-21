import 'package:flutter/material.dart';
import 'package:goatgames2025classifier/routeData%20copy.dart';
import 'package:goatgames2025classifier/routeData.dart';

class BaseCampScoreCard extends StatefulWidget {
  @override
  _BaseCampScoreCardState createState() => _BaseCampScoreCardState();
}

class _BaseCampScoreCardState extends State<BaseCampScoreCard> {
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
    for (var route in routesCrest) {
      route["isTop10"] = false;
    }

    // Filter routes where Top is checked
    var topRoutes = routesCrest
        .where((route) => route["Top"] == true || route["Zone"] == true)
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
      var remainingRoutes = routesCrest
          .where((route) => !route["Top"])
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
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              for (var route in routesCrest) {
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.grey[300],
                              child: Text(
                                "Route",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.grey[300],
                              child: Text(
                                "Zone",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Colors.grey[300],
                              child: Text(
                                "Top",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...routesCrest.map((route) {
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
                        return Container(
                          color: rowColor,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    route["Route"] +
                                        ((isFemale == false
                                                ? route[
                                                    "Required for Ibex Male"]
                                                : route[
                                                    "Required for Ibex Female"])
                                            ? " *"
                                            : ""),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      route["Zone"] = !route["Zone"];
                                      if (!route["Zone"]) {
                                        route["Top"] = false;
                                      }
                                      _calculateScore();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: route["Zone"]
                                          ? route["isTop10"]
                                              ? Colors.green
                                              : Colors.grey
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: route["Zone"]
                                        ? Icon(Icons.check,
                                            color: Colors.white, size: 16)
                                        : null,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      route["Top"] = !route["Top"];
                                      if (route["Top"]) {
                                        route["Zone"] = true;
                                      }
                                      _calculateScore();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: route["Top"]
                                          ? route["isTop10"]
                                              ? Colors.green
                                              : Colors.grey
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: Colors.green,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: route["Top"]
                                        ? Icon(Icons.check,
                                            color: Colors.white, size: 16)
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
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
