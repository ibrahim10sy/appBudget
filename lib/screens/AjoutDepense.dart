import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';
import '../services/depenseService.dart';

class AjoutDepense extends StatefulWidget {
  const AjoutDepense({super.key});

  @override
  _AjoutState createState() => _AjoutState();
}

class _AjoutState extends State<AjoutDepense> {
  DateTime selectedDate = DateTime.now();
  String? selectedType;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController montantController = TextEditingController();
   TextEditingController dateInput = TextEditingController();
  late Utilisateur utilisateur;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        )) ??
        selectedDate;

    if (picked != true && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _ajouterDepense() async {
    try {
      await DepenseService().ajouterDepense(
        description: descriptionController.text,
        montant: double.parse(montantController.text),
        type: selectedType ?? "",
        date: selectedDate,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Dépense ajoutée avec succès'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout de la dépense : $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  void initState() {
    utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 15.0, left : 15, right : 15),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0.0,0.0),
                            blurRadius: 7.0,
                            color: Color.fromRGBO(0, 0, 0, 0.25) //Color.fromRGBO(47, 144, 98, 1)
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            utilisateur.photos == null || utilisateur.photos!.isEmpty ?
                            CircleAvatar(
                              //backgroundImage: AssetImage("assets/images/avatar.png"),
                              //  child: Image.network(utilisateur.photos),
                              backgroundColor: const Color.fromRGBO(240, 176, 2, 1),
                              radius: 30,
                              child: Text(
                                  "${utilisateur.prenom.substring(0,1).toUpperCase()}${utilisateur.nom.substring(0,1).toUpperCase()}",
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2
                                ),
                              ),
                            ) :
                            CircleAvatar(
                                backgroundImage: NetworkImage(utilisateur.photos!),
                                radius: 30
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                "${utilisateur.prenom} ${utilisateur.nom}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: badges.Badge(
                              position: badges.BadgePosition.topEnd(top: -2,end: -2),
                              badgeContent: const Text("3",style: TextStyle(color: Colors.white),),
                              child: const Icon(Icons.notifications,color: Color.fromRGBO(240, 176, 2, 1),size: 40,),
                            )
                        )
                      ],
                    ),
                  )
              )
          ),
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15,top: 30, bottom: 30),
                height:200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(47, 144, 98, 1),
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        "assets/images/wallet.png"),
                    const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add,
                              color: Colors.white,
                              size: 25,
                            ),
                            Padding(padding:EdgeInsets.only(left: 5.0),
                              child: Text(
                                "Ajouter Dépense",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin:const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                      color: const Color(0xfff9f7f7),
                      borderRadius: BorderRadius.circular(31),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 7,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: TextField(
                                maxLines: 3,
                                decoration: const InputDecoration.collapsed(
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
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                          labelText: 'Montant',
                                          labelStyle:
                                          TextStyle(color: Colors.green),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 3,
                                                  color: Colors.green))),
                                    ),
                                  )
                                ]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/programme.png',
                                  width: 23,
                                ),
                                const Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Type :',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2f9062),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Type de dépense',
                                      labelStyle: TextStyle(color: Colors.green),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3,
                                          color: Colors.green,
                                        ),
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: DropdownButton<String>(
                                          iconSize: 30,
                                          isExpanded: true,
                                          value: selectedType,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedType = newValue;
                                            });
                                          },
                                          items: <String>[
                                            'quotidien',
                                            'hebdomadaire',
                                            'mensuelle',
                                          ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                          ),
                                          dropdownColor: Colors.white,
                                          underline: Container(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      controller: dateInput,
                                      decoration: const InputDecoration(
                                          labelText: 'Date de création',
                                          labelStyle:
                                          TextStyle(color: Colors.green),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 3,
                                                  color: Colors.green))),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1950),
                                            //DateTime.now() - not to allow to choose before today.
                                            lastDate: DateTime(2100));
                                        if (pickedDate != null) {
                                          print(pickedDate);
                                          String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                          print(formattedDate);
                                          setState(() {
                                            dateInput.text = formattedDate;
                                          });
                                        } else {}
                                      },
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.only(top:10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(13))),
                                    onPressed: () { },
                                    child: const Text(
                                      'Ajouter',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child:  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(228, 46, 46, 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(13))),
                                      onPressed: () { },
                                      child: const Text(
                                        'Annuler',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
