import 'package:flutter/material.dart';

class Notificationcard extends StatefulWidget {
  const Notificationcard({super.key});

  @override
  State<Notificationcard> createState() => _NotificationcardState();
}

class _NotificationcardState extends State<Notificationcard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.5,
                  child: Column(
                    children: [
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Close")),
                      ),
                    ],
                  ),
                );
              });
        },
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/igniteimpact.png",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            'Ignite Impact',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'This is the notification message. this is the notification message. '
              //I need to specify the length of the text to be shown in the notification card. the rest will show when the user click on the actual notification

              ),
        ),
      ),
    );
  }
}
