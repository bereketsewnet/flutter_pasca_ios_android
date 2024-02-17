import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/custom_colors/colors.dart';
import '../pages/common_page/book_collections_each_view.dart';

class BookCollectionModule extends StatelessWidget {
  BookCollectionModule(this.result, {super.key});

  Map<dynamic, dynamic> result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: CustomColors.secondaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 25,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BooksCollectionsEachView(
                bookName: result['bookName'],
                bookUrl: result['bookUrl'],
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 20,
          child: Image.asset('lib/assets/images/book_collections_icons.png'),
        ),
        title: Text(
          result['bookName'],
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: CustomColors.thirdColor),
        ),
      ),
    );
  }
}
