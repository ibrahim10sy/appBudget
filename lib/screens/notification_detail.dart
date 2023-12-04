import 'package:flutter/material.dart';
import 'package:ika_musaka/model/NotificationModel.dart';

class NotificationDetailScreen extends StatefulWidget {
  final NotificationModel notificationM;

  const NotificationDetailScreen({Key? key, required this.notificationM})
      : super(key: key);

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Détails de la Notification',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            Color.fromRGBO(47, 144, 98, 1), // Customize the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notificationM.texte,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold, // Make the text bold
                color: Colors.black, // Customize text color
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${widget.notificationM.date}',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic, // Make the text italic
                color: Colors.grey, // Customize text color
              ),
            ),
            // Add other details with appropriate styling
          ],
        ),
      ),
    );
  }
}
