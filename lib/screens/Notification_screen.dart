import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ika_musaka/model/NotificationModel.dart';
import 'package:ika_musaka/model/utilisateur.dart';
import 'package:ika_musaka/provider/UtilisateurProvider.dart';
import 'package:ika_musaka/screens/notification_detail.dart';
import 'package:ika_musaka/services/notificationService.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notif;
  late List<NotificationModel> listeNotif = [];
  var notificationService = NotificationService();
  late Utilisateur utilisateurs;

  @override
  void initState() {
    utilisateurs =
        Provider.of<UtilisateurProvider>(context, listen: false).utilisateur!;
    _notif = fetchNotif(utilisateurs.idUtilisateur);
    super.initState();
  }

  Future<List<NotificationModel>> fetchNotif(int idUtilisateur) async {
    try {
      final notificationsM =
          await notificationService.getNotifForUser(idUtilisateur);
      setState(() {
        listeNotif = notificationsM;
      });
      return notificationsM;
    } catch (error) {
      print('Erreur lors de la récupération des notifications: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, top: 30, right: 15.0, bottom: 15.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0.0, 0.0),
                              blurRadius: 7.0,
                              color: Color.fromRGBO(0, 0, 0,
                                  0.25) //Color.fromRGBO(47, 144, 98, 1)
                              )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<UtilisateurProvider>(
                            builder: (context, utilisateurProvider, child) {
                              final utilisateur =
                                  utilisateurProvider.utilisateur;
                              return Row(
                                children: [
                                  utilisateur?.photos == null ||
                                          utilisateur?.photos?.isEmpty == true
                                      ? CircleAvatar(
                                          backgroundColor: const Color.fromRGBO(
                                              240, 176, 2, 1),
                                          radius: 30,
                                          child: Text(
                                            "${utilisateur!.prenom.substring(0, 1).toUpperCase()}${utilisateur.nom.substring(0, 1).toUpperCase()}",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2),
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              utilisateur!.photos!),
                                          radius: 30,
                                        ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      "${utilisateur.prenom.toUpperCase()} ${utilisateur.nom.toUpperCase()}",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationScreen()));
                                },
                                child: badges.Badge(
                                  position: badges.BadgePosition.topEnd(
                                      top: -2, end: -2),
                                  badgeContent: Text(
                                    "${listeNotif.length}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  child: const Icon(
                                    Icons.notifications,
                                    color: Color.fromRGBO(240, 176, 2, 1),
                                    size: 40,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )),
                Stack(
                  alignment: const Alignment(0.9, -0.8),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Notifications",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ]),
                    Image.asset(
                      "assets/images/Group 49.png",
                      width: 150,
                      height: 99,
                      scale: 1,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              height: 445,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.25))
                  ]),
              child: Consumer<NotificationService>(
                builder: (context, notifService, child) {
                  return FutureBuilder(
                    future: _notif,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("Erreur : ${snapshot.error}"),
                        );
                      } else if (!snapshot.hasData || listeNotif.isEmpty) {
                        return const Center(
                          child: Text("Aucune notification trouvée"),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: listeNotif.length,
                          itemBuilder: (context, index) {
                            final notificationList = listeNotif[index];
                            return Material(
                              child: ListTile(
                                shape: BeveledRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                // visualDensity: VisualDensity(vertical: 4),
                                tileColor:
                                    const Color.fromARGB(255, 242, 244, 247),
                                title: Text(
                                  notificationList.texte.substring(0, 10),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(notificationList.date),
                                leading: Image.asset(
                                  "assets/images/clock.png",
                                  width: 30,
                                  height: 30,
                                  scale: 0.9,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationDetailScreen(
                                        notificationM: notificationList,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
