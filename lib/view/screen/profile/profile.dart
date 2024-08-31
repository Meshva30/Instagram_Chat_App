import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pr_8_chat_app/utils/userlist.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@meshva_patel30'),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          Icon(Icons.add_box_outlined),
          SizedBox(width: 10),
          Icon(Icons.menu),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/img/mesu2.jpeg'), // Replace with your image asset
                  ),
                  SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn('13', 'posts'),
                        SizedBox(
                          width: 10,
                        ),
                        _buildStatColumn('284', 'followers'),
                        SizedBox(
                          width: 10,
                        ),
                        _buildStatColumn('247', 'following'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('!! meshu!!', style: TextStyle(fontSize: 16)),
                  Text('@meshva_patel30', style: TextStyle(fontSize: 14)),
                  Text(
                      'Meshvapate🥰\nBca 🖥️💻\nWish me on 30/4 🎉🎉🎉\nLife is very precious there...',
                      style: TextStyle(fontSize: 14)),
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text('Edit profile')),
                      TextButton(
                          onPressed: () {}, child: Text('Share profile')),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildHighlight('me😍🥰', 'assets/img/mesu4.jpeg'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildHighlight('🙏', 'assets/img/mesu4.jpeg'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildHighlight('sisters🥰😘', 'assets/img/mesu4.jpeg'),
                  SizedBox(
                    width: 10,
                  ),
                  _buildHighlight('New', null),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.grid_view_rounded),
                Icon(Icons.slow_motion_video_outlined),
                Icon(Icons.person),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            _buildPostGrid(),
          ],
        ),
      ),
    );
  }

  Column _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Column _buildHighlight(String label, String? imageAsset) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: imageAsset != null ? AssetImage(imageAsset) : null,
          child:
              imageAsset == null ? Icon(Icons.add, color: Colors.white) : null,
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  GridView _buildPostGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 1.0,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[800],
          child: Image.asset(
            users[index].img,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
