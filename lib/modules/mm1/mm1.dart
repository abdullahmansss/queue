import 'package:flutter/material.dart';
import 'package:queue/shared/components.dart';

class MM1Screen extends StatefulWidget
{
  @override
  _MM1ScreenState createState() => _MM1ScreenState();
}

class _MM1ScreenState extends State<MM1Screen>
{
  var lamdaController = TextEditingController();
  var MiuController = TextEditingController();

  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'M/M/1',
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
              buildButton(
                function: () {
                  String lamda = lamdaController.text;
                  String miu = MiuController.text;

                  if (lamda.isEmpty || miu.isEmpty) {
                    showToast('please enter a valid data');
                    return;
                  }

                  operation(
                    lamda: lamda,
                    miu: miu,
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

  void operation({lamda, miu})
  {
    double l = double.parse(lamda);
    double mi = double.parse(miu);

    double L = l / (mi - l);
    double Lq = (l * l) / (mi * (mi - l));
    double W = L / l;
    double Wq = Lq / l;

    setState(() {
      result = 'L = $L \n' + 'Lq = $Lq \n' + 'W = $W \n' + 'Wq = $Wq';
    });
  }
}
