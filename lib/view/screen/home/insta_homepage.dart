import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/bottomNavigationBar.dart';
import '../../../controller/theme_controller.dart';
import '../../../utils/userlist.dart';
import 'componens/user.dart';
import 'home.dart';

class InstagramHomepage extends StatelessWidget {
  final BottomNavController _bottomNavController =
  Get.put(BottomNavController());
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.camera_alt_outlined),
        title: Text(
          'Instagram',
          style: GoogleFonts.greatVibes(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 1,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              Get.to(HomeScreen());
            },
          ),
          IconButton(
            icon: Icon(
              _themeController.isDarkMode.value
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
            ),
            onPressed: () {
              _themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserStory(users: users[index]);
                },
              ),
            ),
            const Divider(height: 1, color: Colors.white60),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/img/mesu2.jpeg'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'meshvapatel_30',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Tokyo, Japan'),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
            Container(

              height: 350,
              width: double.infinity,
              child: Image.asset(
                'assets/img/Post.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Liked by craig_love and 44,686 others',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'meshvapatel_30 ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text:
                        'The game in Japan was amazing and I want to share some photos'
                       ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text('View all 200 comments',
                style: TextStyle(color: Colors.grey),
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          currentIndex: _bottomNavController.selectedIndex.value,
          onTap: (int index) {
            _bottomNavController.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(

              icon: Icon(Icons.home_filled),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage('assets/img/mesu2.jpeg')),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
