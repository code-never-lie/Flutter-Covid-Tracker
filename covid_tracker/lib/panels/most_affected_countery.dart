import 'package:flutter/material.dart';

class MostAffectedPenal extends StatelessWidget {
  final List counteryData;

  const MostAffectedPenal({Key? key, required this.counteryData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  counteryData[index]['countryInfo']['flag'],
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  counteryData[index]['country'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Deaths:' + counteryData[index]['deaths'].toString(),
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        },
        itemCount: counteryData.length,
      ),
    );
  }
}
