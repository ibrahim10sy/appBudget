import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepensesListes extends StatefulWidget {
  const DepensesListes({Key? key}) : super(key: key);

  @override
  _DepenseState createState() => _DepenseState();
}

class _DepenseState extends State<DepensesListes> {
  late Future<List<Map<String, dynamic>>> depenses;

  @override
  void initState() {
    super.initState();
    depenses = fetchDepenses();
  }

  Future<List<Map<String, dynamic>>> fetchDepenses() async {
    final response = await http.get(Uri.parse('http://localhost:8080/Depenses/read/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('erreur');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: depenses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 30),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/photoprofil.png'),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text(
                            "Name User",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 10, left: 10, bottom: 10, top: 50),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(47, 144, 98, 1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Budget Total:',
                                style: TextStyle(
                                    fontSize: 29.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 50),
                              OutlinedButton(
                                onPressed: () {
                                  // Action à effectuer lorsqu'on appuie sur le bouton
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(90.0),
                                  ),
                                  side: BorderSide(color: Colors.white),
                                ),
                                child: Text(
                                  "+ Ajouter Dépenses",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 40,
                        child: Image.asset(
                          'assets/images/wallet.png',
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 372,
                    height: 457,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/wallet.png"),
                                ),
                                title: Text("Liste des depenses",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(47, 144, 98, 1),
                                    ))),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final depense = snapshot.data![index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white10, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/wallet.png"),
                                      ),
                                      title: Text(depense['nom']),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}
