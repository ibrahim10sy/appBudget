import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/BudgetService.dart';
import 'package:ika_musaka/screens/categoriess.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ika_musaka/services/budgetService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/Budget.dart';

class ModifyBudget extends StatefulWidget {
  final Budget budget;
  
  const ModifyBudget({super.key, required this.budget});

  @override
  State<ModifyBudget> createState() => _ModifyBudgetState();
}

class _ModifyBudgetState extends State<ModifyBudget> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController description_control = TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController montant_control = TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController montantalert_control = TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController categorie_control = TextEditingController();
    // ignore: non_constant_identifier_names
    TextEditingController datedebut_control = TextEditingController();

    
   
  DateTime selectedDate = DateTime.now();
  late Future<Map<String, dynamic>> future;
  TextEditingController inputController = TextEditingController();
  late Utilisateur utilisateur;
  int? catValue;
  late Categorie maCat;
  late Future _mesCategories;
  Future fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/Budget/list'));
//print(response);
    if (response.statusCode == 200) {
      print("Bienvenue dans le console");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('yyyy-MM').format(picked);
      setState(() {
        inputController.text = formattedDate;
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    description_control =  TextEditingController(text: widget.budget.description);
    montant_control =  TextEditingController(text: widget.budget.montant.toString());
    montantalert_control =  TextEditingController(text: widget.budget.montantAlert.toString());
    categorie_control =  TextEditingController(text: widget.budget.categorie.toString());
    datedebut_control =  TextEditingController(text: widget.budget.dateDebut);
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
   
    // utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
    fetchAlbum();
    _mesCategories = http.get(Uri.parse('http://10.0.2.2:8080/Categorie/lire'));
    utilisateur =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
  }

  @override
  void dispose() {
    description_control.dispose();
    montant_control.dispose();
    montantalert_control.dispose();
    categorie_control.dispose();
    datedebut_control.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
     return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0,top: 30,right: 15.0,bottom: 15.0),
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
            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFF2F9062),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/piece.png"),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        child:  Text(
                          'Modifier Budget',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 15.0, top:15.0, bottom: 15.0 ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
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
                              margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
                              height: 100,
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
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: TextField(
                                  controller: description_control,
                                  maxLines: 3,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Enter a description',
                                    
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/montant.png',
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
                                        controller: montant_control,
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
                                      'assets/images/montant_alert.png',
                                      width: 23,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Montant alerte :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        controller: montantalert_control,
                                        decoration: const InputDecoration(
                                            labelText: 'Montant Alerte',
                                            labelStyle:
                                            TextStyle(color: Colors.green),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))),
                                      ),
                                    ),
                                  ]
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                    "assets/images/categories.png",
                                    width: 23,
                                  ),
                              Expanded (
                                flex: 2,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                  child: Text("Catégorie",style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff2f9062)),
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 2,
                                  child: FutureBuilder(
                                    future: _mesCategories,
                                    builder: (_, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return DropdownButton(
                                          dropdownColor: Colors.green,
                                            items: [], onChanged: (value) {}

                                        );
                                      }
                                      if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      }
                                      if (snapshot.hasData) {
                                        //debugPrint(snapshot.data.body.toString());
                                        final reponse =
                                        json.decode(snapshot.data.body)
                                        as List;
                                        final mesCategories = reponse
                                            .map((e) => Categorie.fromMap(e))
                                            .toList();
                                        //debugPrint(mesCategories.length.toString());
                                        return DropdownButton(
                                            items: mesCategories
                                                .map((e) => DropdownMenuItem(
                                              child: Text(e.titre),
                                              value: e.id,
                                            ))
                                                .toList(),
                                            value: catValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                catValue = newValue;
                                                maCat = mesCategories
                                                    .firstWhere((element) =>
                                                element.id ==
                                                    newValue);
                                                debugPrint(
                                                    maCat.id.toString());
                                              });
                                            });
                                      }
                                      return DropdownButton(
                                          items: const [], onChanged: (value) {});
                                    },
                                  )
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/calendrier.png',
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
                                    controller: datedebut_control,
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
                                              datedebut_control.text = formattedDate;
                                            });
                                          } else {}
                                        },
                                  ),
                                ),
                              ]
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child:  TextButton(
                            onPressed: () async {
                               widget.budget.description = description_control.text;
                                 widget.budget.description = montant_control.text;
                                 widget.budget.description = montantalert_control.text;
                                 widget.budget.description = datedebut_control.text;
                              final description = description_control.text;
                              final montant = montant_control.text;
                              final montantAlert = montantalert_control.text;
                              final datedebut = datedebut_control.text;

                              if (description.isEmpty ||
                                  montant.isEmpty ||
                                  montantAlert.isEmpty ||
                                  datedebut.isEmpty) {
                                final String errorMessage = "Tous les champs doivent être remplis";
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(child: Text('Erreur')),
                                      content: Text(errorMessage),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        )
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                              try {
                                await BudgetServices.updateBudget(
                                    id : widget.budget.idBudget ?? 0,
                                    description: description,
                                    montant: montant,
                                    montantAlert: montantAlert,
                                    datedebut: datedebut,
                                    categorie: maCat,
                                    utilisateur: utilisateur
                                    );
                                Provider.of<BudgetService>(context, listen: false).applyChange();
                                // Budget ajouté avec succès, afficher une boîte de dialogue de succès.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(child: Text('Succès')),
                                      content: Text("Budget modifier avec succès"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(context);
                                          },
                                          child: Text('OK'),
                                        )
                                      ],
                                    );
                                  },
                                );

                                description_control.clear();
                                montant_control.clear();
                                montantalert_control.clear();
                                datedebut_control.clear();
                                categorie_control.clear();
                              } catch (e) {
                                final String errorMessage = e.toString();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Center(child: Text('Erreur')),
                                      content: Text(errorMessage.replaceAll("Exception:", "")),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F9062),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.white70),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2F9062),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "Ajouter",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )

                        ),
                        TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE42E2E), // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.white70),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color:const Color(0xFFE42E2E),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Padding(
                                      padding:  EdgeInsets.all(5.0),
                                      child: Text(
                                        "Annuler",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ),
                              )
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}