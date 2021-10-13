import 'dart:convert';
import 'package:covid_tracker/panels/counterydata.dart';
import 'package:covid_tracker/panels/infopenal.dart';
import 'package:covid_tracker/panels/most_affected_countery.dart';
import 'package:http/http.dart' as http;
import 'package:covid_tracker/data_sorce.dart';
import 'package:covid_tracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List countryData = [];
  Map worlddata = <dynamic, dynamic>{};

  fetchworldWideData() async {
    List<Future> responseFuture = [
      http.get(Uri.parse("http://corona.lmao.ninja/v2/all")),
      http.get(Uri.parse('http://corona.lmao.ninja/v2/countries'))
    ];
    List responses = await Future.wait(responseFuture);

    // http.Response response =
    //   await Future.wait(futures) http.get(Uri.parse('http://corona.lmao.ninja/v2/all'));
    setState(() {
      worlddata = json.decode(responses[0].body);
    });
    setState(() {
      countryData = json.decode(responses[1].body);
    });
  }

  @override
  void initState() {
    fetchworldWideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "COVID_19 TRACKER",
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                color: Colors.orange[100],
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: Text(DataSource.quote,
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Worldwide',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CountryPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: primaryBlack,
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(10),
                          child: const Text(
                            'Regional',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
              fetchworldWideData() == null
                  ? const CircularProgressIndicator()
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 3,
                        ),
                      ),
                      child: WorldwidePanel(worldData: worlddata),
                    ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Most Affected Countries',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 3,
                  ),
                ),
                child: MostAffectedPenal(
                    counteryData: countryData.take(5).toList()),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 3,
                  ),
                ),
                child: const InfoPanel(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                'WE ARE TOGETHER IN THE FIGHT',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}
