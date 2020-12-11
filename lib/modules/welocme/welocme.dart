import 'package:flutter/material.dart';
import 'package:queue/modules/dd1/dd1.dart';
import 'package:queue/modules/mm1/mm1.dart';
import 'package:queue/modules/mmk/mmk.dart';
import 'package:queue/shared/components.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Project'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please Choose System :',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: buildSystem(
                'D/D/1',
                ()
                {
                  navigateTo(context, DD1Screen());
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: buildSystem(
                'M/M/1',
                ()
                {
                  navigateTo(context, MM1Screen());
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: buildSystem(
                'M/M/1/K',
                ()
                {
                  navigateTo(context, MMKScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}