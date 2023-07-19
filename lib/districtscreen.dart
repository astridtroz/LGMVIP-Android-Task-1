import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';
class DistrictScreen extends StatelessWidget {
  final List<DistrictData> districtData;
  const DistrictScreen({required this.districtData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('District Details'),
      ),
      body: ListView.builder(
        itemCount: districtData.length,
        itemBuilder: (context, index) {
          final data = districtData[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue.shade50
                ),
                child: ListTile(
                  title: Text(data.district,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lora',
                    fontStyle: FontStyle.italic
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),

                      Text('Confirmed cases: ${data.confirmed}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                      ),
                      Text('Active cases: ${data.active}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),),
                      Text('Recovered: ${data.recovered}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),),
                      Text('Deceased: ${data.deceased}',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black
                        ),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
