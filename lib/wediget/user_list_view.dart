import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pasca/assets/custom_colors/colors.dart';

class UsersListView extends StatelessWidget {
  UsersListView({
    super.key,
    required this.users,
  });

  Map users;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: CustomColors.thirdColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              users['imageUrl'] ??
                  'https://www.catholicsingles.com/wp-content/uploads/2020/06/blog-header-3.png',
            ),
            backgroundColor: CustomColors.thirdColor,
            radius: 30,
          ),
          title: Text(
            users['name'] ?? 'FullName',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColors.primaryColor),
          ),
          subtitle: Row(
            children: [
              const SizedBox(width: 3),
              Text(
                users['type'],
                style: TextStyle(
                  color: CustomColors.secondaryColor,
                ),
              ),
            ],
          ),
          trailing: Text(
            users['grade'] ?? 'Grade',
            style: TextStyle(color: CustomColors.secondaryColor),
          ),
        ),
      ),
    );
  }
}
