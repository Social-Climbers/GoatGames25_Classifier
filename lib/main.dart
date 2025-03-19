import 'package:flutter/material.dart';

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
  String tier = "Unclassified";
  double totalScore = 0;
  double requiredScore = 0;
  TextEditingController MinScoreTextController = TextEditingController();
  final List<Map<String, dynamic>> routes = [
    {
      "Route": "Route 1",
      "Zone": false,
      "Top": false,
      "Zone Points": 100,
      "Top Points": 50,
      "Zone Weight": 20,
      "Top Weight": 30,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.yellow,
    },
    {
      "Route": "Route 2",
      "Zone": false,
      "Top": false,
      "Zone Points": 100,
      "Top Points": 50,
      "Zone Weight": 20,
      "Top Weight": 31,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.yellow,
    },
    {
      "Route": "Route 3",
      "Zone": false,
      "Top": false,
      "Zone Points": 95,
      "Top Points": 50,
      "Zone Weight": 22,
      "Top Weight": 28,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.green,
    },
    {
      "Route": "Route 4",
      "Zone": false,
      "Top": false,
      "Zone Points": 95,
      "Top Points": 50,
      "Zone Weight": 22,
      "Top Weight": 28,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.green,
    },
    {
      "Route": "Route 5",
      "Zone": false,
      "Top": false,
      "Zone Points": 95,
      "Top Points": 45,
      "Zone Weight": 22,
      "Top Weight": 29,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.green,
    },
    {
      "Route": "Route 6",
      "Zone": false,
      "Top": false,
      "Zone Points": 90,
      "Top Points": 45,
      "Zone Weight": 23,
      "Top Weight": 29,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 7",
      "Zone": false,
      "Top": false,
      "Zone Points": 95,
      "Top Points": 45,
      "Zone Weight": 22,
      "Top Weight": 29,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 8",
      "Zone": false,
      "Top": false,
      "Zone Points": 90,
      "Top Points": 45,
      "Zone Weight": 23,
      "Top Weight": 29,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 9",
      "Zone": false,
      "Top": false,
      "Zone Points": 90,
      "Top Points": 45,
      "Zone Weight": 24,
      "Top Weight": 30,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.green,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 10",
      "Zone": false,
      "Top": false,
      "Zone Points": 85,
      "Top Points": 40,
      "Zone Weight": 24,
      "Top Weight": 30,
      "Required for Ibex Male": false,
      "Required for Ibex Female": true,
      "Color1": Colors.blue,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 11",
      "Zone": false,
      "Top": false,
      "Zone Points": 80,
      "Top Points": 40,
      "Zone Weight": 25,
      "Top Weight": 31,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 12",
      "Zone": false,
      "Top": false,
      "Zone Points": 80,
      "Top Points": 40,
      "Zone Weight": 25,
      "Top Weight": 31,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.blue,
    },
    {
      "Route": "Route 13",
      "Zone": false,
      "Top": false,
      "Zone Points": 80,
      "Top Points": 40,
      "Zone Weight": 26,
      "Top Weight": 32,
      "Required for Ibex Male": true,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 14",
      "Zone": false,
      "Top": false,
      "Zone Points": 75,
      "Top Points": 35,
      "Zone Weight": 26,
      "Top Weight": 32,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 15",
      "Zone": false,
      "Top": false,
      "Zone Points": 75,
      "Top Points": 35,
      "Zone Weight": 27,
      "Top Weight": 33,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 16",
      "Zone": false,
      "Top": false,
      "Zone Points": 70,
      "Top Points": 35,
      "Zone Weight": 27,
      "Top Weight": 33,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.blue,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 17",
      "Zone": false,
      "Top": false,
      "Zone Points": 70,
      "Top Points": 35,
      "Zone Weight": 28,
      "Top Weight": 34,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.purple,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 18",
      "Zone": false,
      "Top": false,
      "Zone Points": 65,
      "Top Points": 30,
      "Zone Weight": 28,
      "Top Weight": 34,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.purple,
      "Color2": Colors.purple,
    },
    {
      "Route": "Route 19",
      "Zone": false,
      "Top": false,
      "Zone Points": 65,
      "Top Points": 30,
      "Zone Weight": 29,
      "Top Weight": 35,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.purple,
      "Color2": Colors.black,
    },
    {
      "Route": "Route 20",
      "Zone": false,
      "Top": false,
      "Zone Points": 60,
      "Top Points": 30,
      "Zone Weight": 29,
      "Top Weight": 35,
      "Required for Ibex Male": false,
      "Required for Ibex Female": false,
      "Color1": Colors.purple,
      "Color2": Colors.black,
    },
  ];

  void _calculateScore() {
    double totalZonePoints = 0;
    double totalTopPoints = 0;
    bool completedAllSilverhorn = true;
    bool completedRoute13 = false;
    bool climbedAnyIbex = false;

    for (var route in routes) {
      int routeNumber = int.parse(route["Route"].split(" ")[1]);

      if (routeNumber >= 13 && (route["Zone"] || route["Top"])) {
        climbedAnyIbex = true;
      }

      bool isSilverhorn =
          (isMale && routeNumber <= 12) || (!isMale && routeNumber <= 9);

      if (route["Zone"]) {
        totalZonePoints += route["Zone Points"] * route["Zone Weight"];
      } else if (isSilverhorn) {
        completedAllSilverhorn = false;
      }

      if (route["Top"]) {
        totalTopPoints += route["Top Points"] * route["Top Weight"];
      } else if (isSilverhorn) {}

      // if ((isMale && route["Required for Ibex Male"]) ||
      //     (!isMale && route["Required for Ibex Female"])) {
      //   // if (route["Zone"] || route["Top"]) {
      //   //   completedRoute13 = true;
      //   // }
      // }
    }

    totalScore = totalZonePoints + totalTopPoints;

    //double requiredScore = isMale == false ? 40800 : 34000;
    tier = (totalScore >= requiredScore) ? "Ibex" : "Silverhorn";

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
                              onChanged: (value) {
                                setState(() {
                                  requiredScore =
                                      double.tryParse(value) ?? requiredScore;
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
                    // ElevatedButton(
                    //   onPressed: _calculateScore,
                    //   child: Text("Calculate"),
                    // ),
                    // SizedBox(width: 10),
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
                ],
                rows: routes.map((route) {
                  Color rowColor = Colors.transparent;
                  if (route["Zone"]) {
                    rowColor = Colors.grey[200]!;
                  }
                  if (route["Top"]) {
                    rowColor = Colors.grey[300]!;
                  }
                  double totalPoints = (route["Zone"]
                          ? route["Zone Points"] * route["Zone Weight"]
                          : 0) +
                      (route["Top"]
                          ? route["Top Points"] * route["Top Weight"]
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
                          style: TextStyle(fontWeight: FontWeight.bold))),
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
