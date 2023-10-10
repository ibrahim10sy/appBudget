import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ika_musaka/services/updatedepenseservice.dart';
import 'package:intl/intl.dart';

class Depenses {
  int? idDepenses;
  String? description;
  int? montant;
  String? date;
  Map<String,dynamic>? budget;
  Map<String, dynamic>? type;
  Map<String,dynamic>? utilisateur;
  Map<String, dynamic>? categorie;

  Depenses({this.idDepenses, this.description, this.montant, this.date,
      this.budget, this.type, this.utilisateur, this.categorie});

  factory Depenses.fromJson(Map<String, dynamic> json) => Depenses(
    idDepenses : json["idDepense"],
    description: json["description"],
    montant: json["montant"],
    date: json["date"],
    budget: json["budget"],
    type: json["type"],
    utilisateur: json["utilisateur"],
    categorie: json["categorie"]
  );


}

class Depense extends StatefulWidget {
  const Depense({super.key});

  @override
  State<Depense> createState() => _DepenseState();
}

class _DepenseState extends State<Depense> {
  TextEditingController typeInput = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController montantInput = TextEditingController();
  TextEditingController categorieInput = TextEditingController();
  var items = ['quotidien', 'hebdomadaire', 'mensuelle'];

  Depenses depenses = Depenses(
    idDepenses: 2,
    description: "Depense pour le loyer",
    montant: 10000,
    date: "2023-10-02",
    categorie: {
      "idCategorie" : 1
    },
    utilisateur: {
      "idUtilisateur": 1
    },
    type: {
      "idType": 1,
      "titre": 'quotidien'
    },
    budget: {
      "idBudget": 4
    }
  );

  @override
  void initState() {
    dateInput.text = depenses.date!;
    descriptionInput.text= depenses.description!;
    montantInput.text = depenses.montant!.toString();
    typeInput.text = depenses.type!["titre"];

    super.initState();
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
                      const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0, bottom: 15.0),
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
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10),
                                child: TextField(
                                  controller: descriptionInput,
                                  maxLines: 8,
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
                                        controller: montantInput,
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
                                  ]),
                            ),
                            /*Padding(
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
                                     Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: categorieInput,
                                        decoration: const InputDecoration(
                                            labelText: 'Catégorie',
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
                                  ]),
                            )*/
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
                                        readOnly: true,
                                        /*onTap: () async {
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
                                        },*/
                                      ),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/planning.png',
                                      width: 23,
                                    ),
                                    const Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Type :',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff2f9062)),
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        controller: typeInput,
                                        decoration: const InputDecoration(
                                            labelText: 'Type dépense',
                                            labelStyle: TextStyle(
                                                color: Colors.green),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        width: 3,
                                                        color: Colors.green))),
                                        readOnly: true,
                                      ),
                                    )
                                  ])
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 142,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          depenses.montant = int.parse(montantInput.text);
                                          depenses.date = dateInput.text;
                                          depenses.description = descriptionInput.text;
                                        });
                                        FutureBuilder(
                                          future: UpdateDepensesService().modifierdepense(depenses),
                                          builder: (context, snapshot){
                                            debugPrint("Hellooo");
                                            if(snapshot.hasData){
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                        side:const BorderSide(color: Colors.greenAccent),
                                                      ),
                                                      child: const Text('Modification avec succès')
                                                  );
                                                });
                                              return Container();
                                            }else{
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return Dialog(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20.0),
                                                        side:const BorderSide(color: Colors.greenAccent),
                                                      ),
                                                      child: Text("${snapshot.error}")
                                                  );
                                                });
                                              return Container();
                                            }
                                          }
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13))),
                                      child: const Text(
                                        'Modifier',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 142,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13))),
                                      child: const Text(
                                        'Supprimer',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
