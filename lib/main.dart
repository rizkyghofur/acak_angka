import 'dart:math';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acak Angka',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Beranda(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Beranda extends StatefulWidget {
  Beranda({Key key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Random rnd;
  int _currentIntValue = 0;
  TextEditingController min = new TextEditingController();
  TextEditingController max = new TextEditingController();
  FocusNode focusNode = new FocusNode();
  bool _tervalidasi = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acak Angka'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: TextField(
                  decoration: new InputDecoration(
                    labelText: "Masukkan angka awal",
                  ),
                  keyboardType: TextInputType.number,
                  controller: min,
                  maxLength: 99999,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onSubmitted: (minim) {
                    FocusScope.of(context).requestFocus(focusNode);
                    min.text = minim;
                  },
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: new InputDecoration(
                  labelText: "Masukkan angka akhir",
                  errorText: !_tervalidasi
                      ? "Angka akhir tidak boleh lebih kecil dari angka awal!"
                      : null,
                ),
                keyboardType: TextInputType.number,
                focusNode: focusNode,
                controller: max,
                maxLength: 99999,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSubmitted: (maxim) => max.text = maxim,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 16),
              Container(
                width: 100,
                height: 45,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => setState(() {
                          int minimum = int.parse(min.text);
                          int maximum = int.parse(max.text);
                          if (maximum < minimum) {
                            _tervalidasi = false;
                          } else {
                            _tervalidasi = true;
                            rnd = new Random();
                            _currentIntValue =
                                minimum + rnd.nextInt(maximum - minimum);
                          }
                        }),
                    child: Text(
                      'Acak',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
              SizedBox(height: 48),
              Text(
                'Hasil :',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              AnimatedFlipCounter(
                duration: Duration(milliseconds: 500),
                value: _currentIntValue,
                textStyle: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
