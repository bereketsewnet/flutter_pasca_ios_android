import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class UsersChatListView extends StatelessWidget {
  UsersChatListView({
    super.key,
    required this.users,
  });

  Map users;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                users['imageUrl'] ?? 'lib/assets/images/profile.png',
              ),
              radius: 30,
            ),
            title: Text(
              users['name'] ?? 'FullName',
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
                  users['message'] ?? 'Last Message',
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(users['timeStamp'] ?? 'recently'),
                const CircleAvatar(
                  child: Text('1'),
                  backgroundColor: CustomColors.fourthColor,
                  radius: 10,
                ),
              ],
            ),
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
