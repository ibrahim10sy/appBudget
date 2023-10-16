import 'package:flutter/material.dart';
import 'package:ika_musaka/model/DepenceClasse.dart';
import 'package:ika_musaka/screens/depensepage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../model/Budget.dart';
import '../model/utilisateur.dart';
import '../provider/UtilisateurProvider.dart';
import '../services/budgetService.dart';
import '../services/depenseService.dart';
import 'AjoutDepense.dart';
import 'AjouterBudget.dart';

class BudgetDetaille extends StatefulWidget {
  const BudgetDetaille ({super.key, required this.budget});

  final Budget budget;

  @override
  _BudgetDetaille createState() => _BudgetDetaille();
}

class _BudgetDetaille extends State<BudgetDetaille> {

  late Budget budget ;
  late Future<Map<String, dynamic>> future;
  late Future<List<DepenseClass>> _futureListDepense;
  late List<DepenseClass>? depenses = [];
  TextEditingController inputController = TextEditingController();
  late Utilisateur utilisateur;
  var depenseService = DepenseService();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );
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
    utilisateur = Provider.of<UtilisateurProvider>(context,listen: false).utilisateur!;
    future = BudgetService().getBudgetTotal("somme/${utilisateur.idUtilisateur}");
    _futureListDepense = depenseService.getDepenseByIdBudget(widget.budget.idBudget!);
    inputController.text = DateFormat('yyyy-MM').format(DateTime.now());
    debugPrint("Hello");
  }

  @override
  Widget build(BuildContext context) {
    budget = widget.budget;
    return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0,top: 30,right: 15.0,bottom: 15.0),
              child: Column(
                children: [
                  Container(
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
                  ),
                  Stack(
                    alignment: const Alignment(0.9,-0.8),
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Divider(
                              color: Colors.white,
                              height: 20,
                            ),
                            SizedBox(
                              height: 200,
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                                color: const Color.fromRGBO(47, 144, 98, 1),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${budget.montant} FCFA",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.notifications,color: Colors.white,size: 13),
                                          Text(
                                            "Montant alerte : ${budget.montantAlert}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          /*Text(
                                              "${snapshot.data?["Total"]} CFA",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),*/
                                          const Divider(
                                              height: 10,
                                              color: Color.fromRGBO(47, 144, 98, 1)
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10.0,bottom: 7.5,top: 7.5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                            "Restant :",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17
                                                            )
                                                        ),
                                                        Text(
                                                            "${budget.montantRestant}",
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text(
                                                            "Dépensé :",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17
                                                            )
                                                        ),
                                                        Text(
                                                            "${budget.montant! - budget.montantRestant!}",
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 17
                                                            )
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AjoutDepense()));},
                                                    child: Container(
                                                      padding: const EdgeInsets.all(5.0),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(width: 2, color: Colors.white),
                                                          borderRadius: BorderRadius.circular(23)
                                                      ),
                                                      child: const Row(
                                                        children: [
                                                          Icon(Icons.add_circle, color: Colors.white),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 3.0),
                                                            child: Text(
                                                              "Ajouter dépense",
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16,
                                                                  color: Colors.white
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 3),
                                                    child: IconButton(
                                                      onPressed: () => showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) => Dialog(
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(32)
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                                                                  decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0),topRight: Radius.circular(32.0)),
                                                                      color: Color.fromRGBO(47, 144, 98, 1)
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(bottom: 3),
                                                                        child: Image.asset("assets/images/budget.png",width: 53,height: 53),
                                                                      ),
                                                                      const Padding(
                                                                        padding: EdgeInsets.only(left: 10),
                                                                        child: Text(
                                                                          "Information sur le budget",
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white,
                                                                              fontSize: 18
                                                                          ),
                                                                          textAlign: TextAlign.center,
                                                                          overflow: TextOverflow.visible,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 10,left: 15, right: 15, bottom: 10),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                    children: [
                                                                      Container(
                                                                        height: 64,
                                                                        padding: const EdgeInsets.all(10),
                                                                        margin: const EdgeInsets.only(bottom: 10),
                                                                        decoration: BoxDecoration(
                                                                            color : Colors.white,
                                                                            borderRadius: BorderRadius.circular(13),
                                                                            boxShadow: const [
                                                                              BoxShadow(
                                                                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                                                                  blurRadius: 8
                                                                              )
                                                                            ]
                                                                        ),
                                                                        child: Text(budget.description!),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            "Montant : ",
                                                                            style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Color.fromRGBO(47, 144, 98, 1)
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${budget.montant} FCFA",
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            "Montant alerte : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromRGBO(47, 144, 98, 1)
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${budget.montantAlert} FCFA",
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      const Divider(
                                                                        height : 15,
                                                                        color : Colors.white
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            "Restant : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromRGBO(47, 144, 98, 1)
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${budget.montantRestant} FCFA",
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            "Dépensé : ",
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Color.fromRGBO(47, 144, 98, 1)
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "${budget.montant! - budget.montantRestant!} FCFA",
                                                                            style: const TextStyle(
                                                                              fontSize: 14,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      const Divider(
                                                                          height : 15,
                                                                          color : Colors.white
                                                                      ),
                                                                      Row(
                                                                        children : [
                                                                          Expanded(
                                                                            child : Row(
                                                                              children: [
                                                                                const Expanded(
                                                                                    child : Text(
                                                                                      "Date début : ",
                                                                                      style: TextStyle(
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Color.fromRGBO(47, 144, 98, 1)
                                                                                      ),
                                                                                    )
                                                                                ),
                                                                                Expanded(
                                                                                  child : Text(
                                                                                    "${budget.dateDebut}",
                                                                                    overflow : TextOverflow.visible,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  )
                                                                                )
                                                                              ],
                                                                            )
                                                                          ),
                                                                          Expanded(
                                                                            child : Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                const Expanded(
                                                                                  child: Text(
                                                                                    "Date fin : ",
                                                                                    style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Color.fromRGBO(47, 144, 98, 1)
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child : Text(
                                                                                    "${budget.dateFin}",
                                                                                    overflow : TextOverflow.visible,
                                                                                    style: const TextStyle(
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  )
                                                                                )
                                                                              ],
                                                                            )
                                                                          )
                                                                        ]
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                      ),
                                                      icon: const Icon(Icons.info,color: Colors.white,size: 38)
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]
                      ),
                      Image.asset(
                        "assets/images/budget.png",
                        width: 150,
                        height: 99,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                    height: 445,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0,0.0),
                              blurRadius:13,
                              color: Color.fromRGBO(0, 0, 0, 0.25)
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                //flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/depenses 1.png",width: 39,height: 39),
                                    const Expanded(
                                      //flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "Liste des dépenses :",
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(47, 144, 98, 1)
                                          ),
                                          //overflow: TextOverflow.visible,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(child: rechercheEtTrier())
                            ],
                          ),
                        ),
                        const Divider(
                          height: 15,
                          color: Colors.white,
                        ),
                        Consumer<DepenseService>(
                            builder: (context,depenseService,child){
                              return FutureBuilder <List<DepenseClass>>(
                                  future: _futureListDepense,
                                  builder: (context, snapshot){
                                    depenseService.action="all";
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return const CircularProgressIndicator();
                                    }

                                    if(snapshot.hasError){
                                      return Center(
                                        child: Text(snapshot.error.toString().replaceAll("Exception:", "")),
                                      );
                                    }

                                    if(!snapshot.hasData){
                                      return const Center(child:Text("Aucune donnée trouvée !"));
                                    }else{
                                      depenses = snapshot.data;
                                      return Expanded(
                                        child: ListView.builder(
                                            itemCount: depenses!.length,
                                            itemBuilder: (context,index){
                                              return createCardBudget(depenses![index].description!, index,depenses![index]);
                                            }
                                        ),
                                      );
                                    }

                                  }
                              );
                            }
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }


  //Card pour la liste des budget
  createCardBudget(String titre,int index,DepenseClass depense){
    return GestureDetector(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Depense(dedepenses: depense)));},
      child: Container(
        margin: index == 0 ? const EdgeInsets.only(bottom: 15,top: 15) : const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0.0,0.0),
                  blurRadius: 6,
                  color: Color.fromRGBO(0, 0, 0, 0.25)
              ),
            ],
            borderRadius: BorderRadius.circular(17)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Image.asset("assets/images/depenses 1.png",width: 33,height: 33),
                      ),
                      Expanded(
                          child: Text(titre,style: const TextStyle(fontWeight: FontWeight.bold),overflow:TextOverflow.visible,textAlign: TextAlign.center,)
                      )
                    ],
                  ),
                )
            ),
            /*Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){},
                    icon: Image.asset("assets/images/edit_icon (2).png") ),
                IconButton(onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 15),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/budget.png",width: 53,height: 53),
                                    const Expanded(
                                      child: Text(
                                        "Voulez-vous vraiment supprimer cet budget ?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(47, 144, 98, 1)
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                      ),
                                    )
                                  ],
                                ),
                                Text(titre,textAlign: TextAlign.center,overflow:TextOverflow.visible),
                                const Divider(
                                  color: Colors.white,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Provider.of<BudgetService>(context,listen: false).deleteBudgetById("supprimer/${budget.idBudget}");
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16)
                                          ),
                                          color: Colors.red,
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                            child: Text(
                                              "OUI",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: (){Navigator.pop(context);},
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            color: const Color.fromRGBO(47, 144, 98, 1),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                              child: Text(
                                                "NON",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        )
                    )
                ),
                    icon: Image.asset("assets/images/icon_poubelle.png"))
              ],
            ),
          )*/
          ],
        ),
      ),
    );
  }

  //Widget recherche et trier

  rechercheEtTrier(){
    final formKey = GlobalKey<FormState>();
    String description = "";

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: (){
            setState(() {
              _futureListDepense = depenseService.getDepenseByIdBudget(widget.budget.idBudget!);
            });
          },
          icon: const Icon(Icons.restart_alt,color: Color.fromRGBO(47, 144, 98, 1),size: 28)),
        IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0),topRight: Radius.circular(32.0)),
                            color: Color.fromRGBO(47, 144, 98, 1)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Image.asset("assets/images/depenses 1.png",width: 53,height: 53),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Rechercher une dépense",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          margin: const EdgeInsets.only(top: 15,bottom: 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0),bottomRight: Radius.circular(32.0)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 8.0,
                                          color: Color.fromRGBO(0, 0, 0, 0.25)
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Form(
                                      key: formKey,
                                      child: Expanded(
                                        child: TextFormField(
                                          validator: (value){
                                            if(value == null || value.isEmpty){
                                              return "Veuillez saisir une description";
                                            }
                                            description = value;
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: IconButton(
                                        onPressed: (){
                                          if (formKey.currentState!.validate()){
                                            Provider.of<BudgetService>(context,listen: false).applySearch(description);
                                            setState(() {
                                              _futureListDepense = depenseService.searchDepenseByDesc(utilisateur.idUtilisateur);
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        icon: Image.asset(
                                            "assets/images/depenses 1.png",
                                            width: 28,
                                            height: 28
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                      onTap: (){Navigator.pop(context);},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        color: Colors.red,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                          child: Text(
                                            "FERMER",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                              )
                            ],
                          )
                      )
                    ],
                  ),
                )),
            icon: Image.asset(
                "assets/images/icon_search.png",
                width: 20,
                height: 20
            )
        ),
        IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(32.0),topRight: Radius.circular(32.0)),
                            color: Color.fromRGBO(47, 144, 98, 1)
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3),
                              child: Image.asset("assets/images/depenses 1.png",width: 53,height: 53),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Trier par mois et année",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          margin: const EdgeInsets.only(top: 15,bottom: 15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0),bottomRight: Radius.circular(32.0)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.only(bottom: 15.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(13),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 8.0,
                                          color: Color.fromRGBO(0, 0, 0, 0.25)
                                      )
                                    ]
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: TextFormField(
                                          controller: inputController,
                                          readOnly: true,
                                        )
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: IconButton(
                                          onPressed: () => _selectDate(context),
                                          icon: const Icon(Icons.calendar_month,color: Color.fromRGBO(47, 144, 98, 1),size: 30)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                      onTap: (){
                                        Provider.of<BudgetService>(context,listen: false).applyTrie(inputController.text);
                                        setState(() {
                                          _futureListDepense = depenseService.sortByMonthAndYear(utilisateur.idUtilisateur);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        color: const Color.fromRGBO(47, 144, 98, 1),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                          child: Text(
                                            "TRIER",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: GestureDetector(
                                      onTap: (){Navigator.pop(context);},
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        color: Colors.red,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                                          child: Text(
                                            "FERMER",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                              )
                            ],
                          )
                      )
                    ],
                  ),
                )),
            icon: Image.asset(
                "assets/images/icon_trie.png",
                width: 21,
                height: 17
            )
        )
      ],
    );
  }
}
