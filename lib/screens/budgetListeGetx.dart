import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ika_musaka/controllers/budgetController.dart';
import 'package:ika_musaka/services/budgetService.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../model/Budget.dart';

class BudgetListeGetx extends StatelessWidget {
  const BudgetListeGetx ({super.key});

  @override
  Widget build(BuildContext context) {
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
                          const Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage: AssetImage("assets/images/avatar.png"),
                                  radius: 30
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  "Hello Hii!!!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
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
                                    const Text(
                                        "Budget total :",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    GetBuilder<BudgetController>(
                                      init: BudgetController(),
                                      builder: (_){
                                        return FutureBuilder<Map<String, dynamic>>(
                                            future: _.future ,
                                            builder: (context, snapshot){
                                              if(snapshot.hasData){
                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${snapshot.data?["Total"]} CFA",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.bold
                                                        )
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
                                                                      "${snapshot.data?["Restant"]}",
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
                                                                      "${snapshot.data?["Total"]-snapshot.data?["Restant"]}",
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
                                                          children: [
                                                            GestureDetector(
                                                              onTap: (){},
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
                                                                        "Ajouter budget",
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
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              }else{
                                                return const CircularProgressIndicator();//const CircularProgressIndicator();
                                              }
                                            }
                                        );
                                      },
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          children: [
                            Image.asset("assets/images/budget.png",width: 39,height: 39),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Liste des budgets :",
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(47, 144, 98, 1)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 30,
                        color: Colors.white,
                      ),
                      GetBuilder<BudgetController>(
                        id: 'listBudgets',
                        init: BudgetController(),
                        builder: (_){
                          return FutureBuilder <List<Budget>>(
                              future: _.futureListBudget,
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return const Center(child:CircularProgressIndicator());
                                }

                                if(snapshot.hasError){
                                  return Center(child:Text(snapshot.error.toString()));
                                }

                                if(!snapshot.hasData){
                                  return const Center(child:Text("Aucune donnée trouvée !"));
                                }
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _.budgets.length,
                                      itemBuilder: (context,index){
                                        return createCardBudget(_.budgets[index].description!, index,_.budgets[index]);
                                      }
                                  );
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

  createCardBudget(String titre,int index,Budget budget){
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
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
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/budget.png",width: 33,height: 33),
                Expanded(child: Text(titre,style: const TextStyle(fontWeight: FontWeight.bold),overflow:TextOverflow.visible))
              ],
            )
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){},
                    icon: Image.asset("assets/images/edit_icon (2).png") ),
                IconButton(onPressed: () =>
                        Get.dialog(Dialog(
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
                                          Get.find<BudgetController>().deleteBudgetById("supprimer/${budget.idBudget}");
                                          Get.back();
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
                                          onTap: (){Get.back();},
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
          )
        ],
      ),
    );
  }
}
