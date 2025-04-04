import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  static var _message = "ok.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _message,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: buttonPressed,
                child: const Text(
                  "tap me!",
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text("Hello!"),
        content: Text("This is sample."),
      ),
    );
  }
}
