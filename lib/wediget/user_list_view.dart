import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  String? imageUrl;
  String? name;
  String? message;
  String? timeStamp;

  UsersListView(this.imageUrl, this.name, this.message, this.timeStamp,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Image.asset(imageUrl ?? 'lib/assets/images/profile.png'),
              radius: 25,
            ),
            title: Text(
              name ?? 'FullName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.done_all),
                const SizedBox(width: 3),
                Text(
                  message ?? 'Last Message',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(timeStamp ?? 'recently'),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 80, right: 20),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
