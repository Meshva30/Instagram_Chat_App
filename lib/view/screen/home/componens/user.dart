import 'package:flutter/material.dart';

class Users {
final String name;
final String img;

Users({required this.name, required this.img});
}

class UserStory extends StatelessWidget {
  final Users users;

  UserStory({required this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: users.img.startsWith('assets/')
                    ? AssetImage(users.img)
                    : NetworkImage(users.img) as ImageProvider,
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            users.name,

          ),
        ],
      ),
    );
  }
}
