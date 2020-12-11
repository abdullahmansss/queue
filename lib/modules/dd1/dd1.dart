import 'package:flutter/material.dart';
import 'package:queue/shared/components.dart';

class DD1Screen extends StatefulWidget
{
  @override
  _DD1ScreenState createState() => _DD1ScreenState();
}

class _DD1ScreenState extends State<DD1Screen>
{
  var lamdaController = TextEditingController();
  var MiuController = TextEditingController();
  var MController = TextEditingController();
  var KController = TextEditingController();

  bool isM = false;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'D/D/1',
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
                  change: (s) {
                    if (double.parse(MiuController.text) <= double.parse(s)) {
                      setState(() {
                        isM = true;
                      });
                    } else {
                      setState(() {
                        isM = false;
                      });
                    }
                  }),
              SizedBox(
                height: 15.0,
              ),
              buildInput(
                controller: MiuController,
                hint: 'enter μ',
                text: 'μ',
                change: (s) {
                  if (double.parse(lamdaController.text) >= double.parse(s)) {
                    setState(() {
                      isM = true;
                    });
                  } else {
                    setState(() {
                      isM = false;
                    });
                  }
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              if (isM)
                buildInput(
                  controller: MController,
                  hint: 'enter M',
                  text: 'M',
                ),
              if (isM)
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
                  String M = MController.text;
                  String K = KController.text;

                  if (lamda.isEmpty || miu.isEmpty || K.isEmpty) {
                    showToast('please enter a valid data');
                    return;
                  }

                  if (isM) {
                    if (M.isEmpty) {
                      showToast('please enter a valid data');
                      return;
                    }
                  }

                  operation(
                    lamda: lamda,
                    k: K,
                    m: M,
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

  void operation({lamda, miu, String m, k}) {
    double l = 1 / double.parse(lamda);
    double mi = 1 / double.parse(miu);
    int K = 1 + int.parse(k);

    int M;
    if (m != null && m.length > 0) M = int.parse(m);

    if (l < mi || l == mi)
    {
      int ti = 0;

      if (l == mi) {
        setState(() {
          result = 'ti= ' +
              ti.toString() +
              '\n' +
              'n(t)= ' +
              M.toString() +
              '\n\n' +
              'Wq(n)= ' +
              ((M - 1) * (1 / mi)).toString();
        });
      } else {
        for (int i = 0; i > -1; i++)
        {
          if (M == (i / (1 / mi)).toInt() - (i / (1 / l)).toInt())
          {
            ti = i;
            break;
          }
        }

        setState(() {
          result = 'ti= ' +
              ti.toString() +
              '\n' +
              'n(t)= ' +
              M.toString() +
              '|λt| - |μt| at t < ' +
              ti.toString() +
              '\n' +
              'n(t)= 0 or 1 at t => ' +
              ti.toString() +
              '\n\n' +
              'Wq(n)= ' +
              (((M - 1) / (2 * mi)).toInt()).toString() +
              'at n=0' +
              '\n' +
              'Wq(n)= (M-1+n)(1/μ)–n(1/λ) at n< ${(l * ti).toInt()}' +
              '\n' +
              'Wq(n)= 0   at n=> ${(l * ti).toInt()}';
        });
      }
    } else if (l > mi) {
      int ti = 0;

      for (int i = 0; i > -1; i++) {
        if (K ==
            (i / (1 / l)).toInt() -
                (i / (1 / mi) - ((1 / l) / (1 / mi))).toInt()) {
          ti = i;
          break;
        }
      }

      if (l % mi == 0) {
        setState(() {
          result = 'ti= $ti' +
              '\n' +
              'n(t) =0   at t < ${1 / l}' +
              '\n' +
              'n(t)=|λt|-|μt-μ/λ|   at $l' +
              '<t< $ti' +
              '\n' +
              'n(t)=' +
              (K - 1).toString() +
              'at t=> $ti' +
              '\n\n' +
              'Wq(n)= 0   at n=0' +
              '\n' +
              'Wq(n)= ${(1 / mi - 1 / l)}' +
              '(n-1)   at n< ${(l * ti).toInt()}' +
              '\n' +
              'Wq(n)= ${(1 / mi - 1 / l) * (l * ti - 2)} at n=> ${(l * ti).toInt()}';
        });
      } else {
        setState(() {
          result = 'ti= $ti' +
              '\n' +
              'n(t)= 0   at t< ${1 / l}' +
              '\n' +
              'n(t)= |λti|-|μti-μ/λ|   at ${1 / l}' +
              '<t< $ti' +
              '\n' +
              'n(t)= ${(K - 1)} or ${(K - 2)}  at t=> $ti' +
              '\n\n' +
              'Wq(n)= ${(1 / mi - 1 / l).toInt()} (n-1) at n< ${(l * ti).toInt()} \n' +
              'Wq(n)= ${(1 / mi - 1 / l) * (l * ti - 2).toInt()} or ${(1 / mi - 1 / l) * (l * ti - 3)} at n=> ${(l * ti).toInt()}';
        });
      }
    }
  }
}