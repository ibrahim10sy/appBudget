import 'package:flutter/material.dart';

void main() {
  runApp(const Mapage());
}

class Mapage extends StatelessWidget {
  const Mapage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(),
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/piece.png"),
              // Image(image: AssetImage('assets/images/piece.png')),
             const SizedBox(height: 10),
             const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ajout Budget',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
