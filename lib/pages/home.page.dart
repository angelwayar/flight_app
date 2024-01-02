import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

enum FlightView { form, timeline }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlightView flightView = FlightView.form;

  void _onFlightPressed() {
    setState(() {
      flightView = FlightView.timeline;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE04148),
                      Color(0xFFD85774),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        'Air Asia',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          HeaderButton(title: 'One way'),
                          HeaderButton(title: 'Round'),
                          HeaderButton(
                            title: 'Multicity',
                            selected: true,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              right: 10.0,
              top: headerHeight / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: TabButton(
                            title: 'Flight',
                            selected: true,
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: 'Train',
                          ),
                        ),
                        Expanded(
                          child: TabButton(
                            title: 'Bus',
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: flightView == FlightView.form
                          ? FlightForm(
                              onTap: _onFlightPressed,
                            )
                          : const FlightTimeLine(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
