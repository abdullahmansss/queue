import 'package:flutter/material.dart';
import 'package:queue/shared/components.dart';
import 'dart:math';

class MMKScreen extends StatefulWidget {
  @override
  _MMKScreenState createState() => _MMKScreenState();
}

class _MMKScreenState extends State<MMKScreen> {
  var lamdaController = TextEditingController();
  var MiuController = TextEditingController();
  var KController = TextEditingController();

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'M/M/1/K',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInput(
                controller: lamdaController,
                hint: 'enter λ',
                text: 'λ',
              ),
              SizedBox(
                height: 15.0,
              ),
              buildInput(
                controller: MiuController,
                hint: 'enter μ',
                text: 'μ',
              ),
              SizedBox(
                height: 15.0,
              ),
              buildInput(
                controller: KController,
                hint: 'enter K',
                text: 'K',
              ),
              SizedBox(
                height: 15.0,
              ),
              buildButton(
                function: () {
                  String lamda = lamdaController.text;
                  String miu = MiuController.text;
                  String K = KController.text;

                  if (lamda.isEmpty || miu.isEmpty || K.isEmpty) {
                    showToast('please enter a valid data');
                    return;
                  }

                  operation(
                    lamda: lamda,
                    miu: miu,
                    k: K,
                  );
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(result),
            ],
          ),
        ),
      ),
    );
  }

  void operation({lamda, miu, k}) {
    double l = double.parse(lamda);
    double mi = double.parse(miu);
    int K = int.parse(k);

    double P = l / mi;
    double Pk;
    double L;

    if (P != 1) {
      Pk = pow(P, K) * ((1 - P) / (1 - pow(P, K + 1)));
      L = P *
          ((1 - ((K + 1) * pow(P, K)) + (K * pow(P, K + 1))) /
              ((1 - P) * (1 - pow(P, K + 1))));
    } else {
      Pk = 1 / (K + 1);
      L = K / 2;
    }

    double W = L / (l * (1 - Pk));
    double Wq = W - (1 / mi);
    double Lq = l * (1 - Pk) * Wq;

    setState(() {
      result = 'L = $L \n' + 'Lq = $Lq \n' + 'W = $W \n' + 'Wq = $Wq';
    });
  }
}
