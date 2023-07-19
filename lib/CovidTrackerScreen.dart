import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'districtscreen.dart';
import 'model.dart';
import 'dart:convert';
class CovidTrackerScreen extends StatefulWidget {
  @override
  _CovidTrackerScreenState createState() => _CovidTrackerScreenState();
}

class _CovidTrackerScreenState extends State<CovidTrackerScreen> {
  List<CityData> cities = []; //list to store cities
  bool isLoading = true;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.covid19india.org/state_district_wise.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final statesData = data.keys;

      statesData.forEach((state) {
        final stateData = data[state]['districtData'];
        final confirmedCount = stateData.values.fold<int>(
            0, (int sum, dynamic district) => sum + (district['confirmed'] as int));

        final districtList = stateData.entries.map((entry) {
          final district = entry.key;
          final districtData = entry.value;
          final districtConfirmed = districtData != null && districtData.containsKey('confirmed')
              ? districtData['confirmed'].toString()
              : '0';
          final districtActive = districtData != null && districtData.containsKey('active')
              ? districtData['active'].toString()
              : '0';
          final districtRecovered = districtData != null && districtData.containsKey('recovered')
              ? districtData['recovered'].toString()
              : '0';
          final districtDeceased = districtData != null && districtData.containsKey('deceased')
              ? districtData['deceased'].toString()
              : '0';
          return DistrictData(district, districtConfirmed, districtActive, districtRecovered, districtDeceased);
        }).toList().cast<DistrictData>();

        cities.add(CityData(state, confirmedCount.toString(), districtList));
      });

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch data. Please try again.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Text("State Data",
          style: TextStyle(
            fontSize: 25,
          ),),
        ),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue.shade50
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(cities[index].state,
                style: TextStyle(
                  fontSize: 20
                ),),
                subtitle: Text('Confirmed cases: ${cities[index].confirmed}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DistrictScreen(districtData: cities[index].districts),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}