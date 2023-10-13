import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ika_musaka/model/DepenceClasse.dart';
import 'package:ika_musaka/services/Deletedepenseservice.dart';
import 'package:ika_musaka/services/updatedepenseservice.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';

class Depense extends StatefulWidget {
  const Depense({super.key, required this.dedepenses});

  final DepenseClass dedepenses;

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
  late DepenseClass depenses;
  late Utilisateur utilisateur;

  @override
  void initState() {
    utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
    depenses = widget.dedepenses;
    dateInput.text = depenses.date!;
    descriptionInput.text= depenses.description!;
    montantInput.text = depenses.montant!.toString();
    typeInput.text = depenses.type!["titre"];

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 15.0),
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
            const Divider(
              height: 30,
              color: Colors.white,
            ),
            Stack(
              alignment: const Alignment(0.7, -2.9),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(23),
                  child: Container(
                    height: 175,
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
                            height: 65,
                            color: Color(0xff2f9062),
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
                Image.asset('assets/images/wallet.png')
              ],
            ),
            Container(
              margin:
              const EdgeInsets.only(top: 15.0, bottom: 15.0),
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
                                  'assets/images/calendarType.png',
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
                                  UpdateDepensesService().modifierdepense(depenses).then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Dialog(
                                              shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Modifier avec succès',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Image.asset('assets/images/img.png',
                                                        height: 30,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          );
                                        });
                                  }).catchError((onError){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                                side:const BorderSide(color: Colors.greenAccent),
                                              ),
                                              child:Container(
                                                padding: const EdgeInsets.only(left: 15.0) ,
                                                height: 100,
                                                child:  Row(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text("${onError}",
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors.green,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          );
                                        });
                                  });
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
                                onPressed: (){
                                  SupprimerDepensesService().supprimerdepense(depenses.idDepense!).then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Dialog(
                                              shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text('Supprimer avec succès',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.green
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15.0),
                                                      child: Image.asset('assets/images/img.png',
                                                        height: 30,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          );
                                        });
                                  }).catchError((onError){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0),
                                                side:const BorderSide(color: Colors.greenAccent),
                                              ),
                                              child:Container(
                                                padding: const EdgeInsets.only(left: 15.0) ,
                                                height: 100,
                                                child:  Row(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text("${onError}",
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors.green,
                                                                  fontWeight: FontWeight.bold
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                          );
                                        });
                                  });
                                },
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
            )
          ],
        ),
      ),
    );
  }
}
