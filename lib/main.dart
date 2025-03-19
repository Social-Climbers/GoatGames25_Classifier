import 'package:flutter/material.dart';
import 'package:goatgames2025classifier/routeData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GG25 Classifier',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ScoreCardScreen(),
    );
  }
}

class ClimbingScoreCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goat Games 25 Classifier',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ScoreCardScreen(),
    );
  }
}

class ScoreCardScreen extends StatefulWidget {
  @override
  _ScoreCardScreenState createState() => _ScoreCardScreenState();
}

class _ScoreCardScreenState extends State<ScoreCardScreen> {
  bool isMale = false;
  bool disableWeight = false;
  String tier = "Unclassified";
  double totalScore = 0;
  double requiredScore = 0;
  TextEditingController MinScoreTextController = TextEditingController();

  void _calculateScore() {
    double totalScore = 0;
    bool completedAllSilverhorn = true;
    bool climbedAnyIbex = false;

    // Reset the top 10 flag for all routes
    for (var route in routes) {
      route["isTop10"] = false;
    }

    // Filter routes where Top is checked
    var topRoutes = routes.where((route) => route["Top"] == true).toList();

    // Sort the routes by route number in descending order
    topRoutes.sort((a, b) {
      int aRouteNumber = int.parse(a["Route"].split(" ")[1]);
      int bRouteNumber = int.parse(b["Route"].split(" ")[1]);
      return bRouteNumber.compareTo(aRouteNumber);
    });

    // Take the top 10 routes
    topRoutes = topRoutes.take(10).toList();

    // Mark the top 10 routes
    for (var route in topRoutes) {
      route["isTop10"] = true;
    }

    for (var route in topRoutes) {
      int routeNumber = int.parse(route["Route"].split(" ")[1]);

      if (routeNumber >= 13 && route["Top"]) {
        climbedAnyIbex = true;
      }

      bool isSilverhorn =
          (isMale && routeNumber <= 12) || (!isMale && routeNumber <= 9);

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

      if ((!isMale && routeNumber >= 10 && route["Top"]) ||
          (isMale && routeNumber >= 13 && route["Top"])) {
        climbedAnyIbex = true;
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

    requiredScore = isMale == false ? 40800 : 34000;
    MinScoreTextController.text = requiredScore.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Goat Games 25 Classifier",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
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
                                requiredScore = isMale == false ? 40800 : 34000;
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
                      )
                    ],
                  ),
                  SizedBox(height: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Male"),
                    Switch(
                      value: isMale,
                      onChanged: (bool value) {
                        setState(() {
                          isMale = value;
                          setState(() {
                            requiredScore = isMale == false ? 40800 : 34000;
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          for (var route in routes) {
                            route["Zone"] = false;
                            route["Top"] = false;
                          }
                          totalScore = 0;
                          tier = "Unclassified";
                        });
                      },
                      child: Text("Clear"),
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
                  ],
                ),
              ],
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 80),
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
                      label: Text("Top 10",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: routes.map((route) {
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
                            ((isMale == false
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
                        Text(
                          route["Zone Points"].toString(),
                          style: TextStyle(
                            fontWeight: route["Zone"]
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: route["Zone"] ? Colors.green : Colors.black,
                          ),
                        ),
                      ),
                      DataCell(Text(route["Zone Weight"].toString())),
                      DataCell(
                        Text(
                          route["Top Points"].toString(),
                          style: TextStyle(
                            fontWeight: route["Top"]
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: route["Top"] ? Colors.green : Colors.black,
                          ),
                        ),
                      ),
                      DataCell(Text(route["Top Weight"].toString())),
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
    );
  }
}
