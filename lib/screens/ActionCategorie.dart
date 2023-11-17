// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ika_musaka/provider/CategoriesProvider.dart';
import 'package:ika_musaka/screens/CategorieService.dart';
import 'package:provider/provider.dart';

import '../model/utilisateur.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class DialogHelper {
  static get id => null;
  late Utilisateur utilisateur;

  static void showModifyCategoryDialog(BuildContext context,int index,dynamic categorieM) {
    final myController = TextEditingController();
    myController.text = categorieM["titre"]; 
    print(categorieM["titre"]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(31),
        ),
        titlePadding: const EdgeInsets.only(top: 0, left: 0),
        title: Container(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: const Image(
                  image: AssetImage('assets/images/img.png'),
                ),
              ),
              Container(
                padding:const  EdgeInsets.only(left: 5, right: 7),
                child:const  Icon(
                  Icons.edit_sharp,
                  color: Color.fromARGB(255, 233, 85, 0),
                  // color: Color.fromARGB(255, 233, 85, 0),
                ),
              ),
              const Text(
                
                'Modifier la Catégorie ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F9062),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nom',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          hintText: "catégorie",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () async{
                        categorieM['titre'] = myController.text;
                        await Provider.of<CategorieService>(context, listen: false).updateCategorie(context: context,index: index,categorie:categorieM); 
                        // Votre logique lorsque le bouton est pressé
                        if (_formKey.currentState!.validate()) {
                          print("deuxieme étapes");
                          _formKey.currentState!.save();
                        }
                        Navigator.of(context).pop(); // Ferme la boîte de dialogue
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Modifier",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        // Votre logique lorsque le bouton d'annulation est pressé
                        Navigator.of(context)
                            .pop(); // Ferme la boîte de dialogue
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        backgroundColor: const Color.fromARGB(
                            255, 230, 10, 10), // Couleur du bouton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Annuler",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   static void showDeleteCategoryDialog(BuildContext context,int idCategorie,index,  Utilisateur utilisateur) {
     CategoriesProvider categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: const EdgeInsets.only(top: 0, left: 0),
        title: Container(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 8, left: 10),
                child: const Image(
                  image: AssetImage('assets/images/img.png'),
                ),
              ),
              const Center(
                child: Text(
                  'Voulez-vous supprimer cette catégorie ?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F9062),
                  ),
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nom de la catégorie',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Votre logique lorsque le bouton "NON" est pressé
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      backgroundColor: const Color.fromARGB(
                          255, 230, 10, 10), // Couleur du bouton "NON"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    child: const Text(
                      "NON",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                                          
                      try{
                       //String title = titre_controller.text;
                       await Provider.of<CategorieService>(context,listen : false).suppresion(id: idCategorie, titre:'titre', utilisateur:utilisateur); 
                       categoriesProvider.removeCategory(index);
                      
                      }catch (e){
                        debugPrint('non supprimer');
                      }
                      Navigator.of(context).pop(); // Ferme la boîte de dialogue
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                      backgroundColor:
                          const Color(0xFF2F9062), // Couleur du bouton "OUI"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    child: const Text(
                      "OUI",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  static _chargerCategories() {}
}

class ActionCategory extends StatefulWidget {
  const ActionCategory({Key? key}) : super(key: key);

  @override
  State<ActionCategory> createState() => _ActionCategoryState();
}

class _ActionCategoryState extends State<ActionCategory> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
