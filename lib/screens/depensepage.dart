import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
class Depense extends StatefulWidget {
  const Depense({super.key});

  @override
  State<Depense> createState() => _DepenseState();
}

class _DepenseState extends State<Depense> {
  TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
          backgroundColor: Colors.blueAccent,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 30, bottom: 50, left: 15, right: 15),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/profile.png',
                                fit: BoxFit.cover),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Pablo Picasso',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Stack(
                  alignment: const Alignment(0.7, -2.3),
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(23),
                        child: Container(
                          height: 200,
                          color: const Color(0xff2f9062),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dépense',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const Divider(
                                  height: 90,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(23)),
                                        child: const Row(children: [
                                          Icon(Icons.add_circle,
                                              color: Colors.white),
                                          Padding(
                                            padding: EdgeInsets.only(left: 3),
                                            child: Text(
                                              'Ajouter dépense',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ]))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.asset('assets/images/wallet.png')
                  ],
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0),
                  height: 436,
                  decoration: BoxDecoration(
                      color: const Color(0xfff9f7f7),
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/wallet.png',
                            width: 88,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 10.0),
                              child: Text(
                                'Description :',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2f9062)),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 15, left: 15, right: 15, bottom: 15),
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xfff9f7f7),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 7,
                                      color: Color.fromRGBO(0, 0, 0, 0.25))
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: TextField(
                                  maxLines: 8,
                                  decoration: InputDecoration.collapsed(
                                      hintText:
                                          "Une description pour la dépense"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/share.png',
                                      width: 23,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Montant :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))),
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/820826.png',
                                      width: 25,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Catégorie :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))),
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/calendar.png',
                                      width: 23,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Date début :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: _dateController,
                                        decoration: InputDecoration(
                                            labelText: 'Date',
                                            filled: true,
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))),
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? _picked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2100));
                                          if (_picked != null) {
                                            String formattedDate =
                                                DateFormat("yyyy-MM-dd")
                                                    .format(_picked);
                                            setState(() {
                                              _dateController.text =
                                                  formattedDate.toString();
                                            });
                                          } else {
                                            print('Not Selected');
                                          }
                                        },
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/share.png',
                                      width: 23,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Montant :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )),
                                    ),
                                    const Expanded(
                                      flex: 2,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))),
                                      ),
                                    )
                                  ]),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
