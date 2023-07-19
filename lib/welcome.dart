import 'package:covid_tracker/CovidTrackerScreen.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Center(
              child: Column(
                children:[
                  Text("Let's Grow More",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue.shade900
                  ),),
                  SizedBox(height: 110,),
                  Text('Welome to a covid fighting universe!',
                    style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue.shade900
                    ),
                  ),

                  SizedBox(height: 30,),
                  Image.asset('assets/images/covid.png',
                  fit: BoxFit.fill,
                  height: 330,
                  width:360,),
                  SizedBox(height: 80,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CovidTrackerScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade700),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        child: Text('Get Started'),
                      ),
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}
