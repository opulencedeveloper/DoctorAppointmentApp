import "dart:io";

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart';

import '../provider/profile_list.dart';
import '../screens/auth_screen.dart';
import '../provider/auth.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  ProfileTabState createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    // final appDir = await syspaths.getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // final savedImage = await File(imageFile.path).copy("${appDir.path}/$fileName");
    // final path = "files/${imageFile.name}";
    // final fileName = XFile(imageFile.path);

    // final ref = FirebaseStorage.instance.ref().child(path);
    // ref.putFile(fileName as File);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context).colorScheme;
    final profileData = Provider.of<ProfileList>(context, listen: false);
    final profileItems = profileData.items;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: mediaQuery.size.height - mediaQuery.padding.top - kBottomNavigationBarHeight,
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Badge(
                    animationType: BadgeAnimationType.fade,
                    //toAnimate: false,
                    badgeContent: IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.add_a_photo),
                      onPressed: _takePicture,
                    ),
                    badgeColor: theme.secondary,
                    position: BadgePosition.bottomEnd(),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 53,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 52,
                        backgroundImage: _storedImage != null
                            ? FileImage(_storedImage as File)
                            : const AssetImage(
                                "assets/images/avatar.png",
                              ) as ImageProvider,
                        // child: _storedImage == null
                        //     ? Icon(
                        //         Icons.account_circle,
                        //         size: 100,
                        //         color: theme.primaryColor,
                        //       )
                        //     : null,
                      ),
                    ),
                  ),
                  //CircleAvatar(radius: 50),
                  const SizedBox(height: 25),
                  const Text('App Developer: Victor Amobi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  const Text('Email: victorkudos@gmail.com', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      height: 335,
                      //color: Colors.blue,
                      // decoration: const BoxDecoration(
                      //    borderRadius: BorderRadius.circular(10),
                      // ),
                      child: ListView.builder(
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileItems.length,
                        itemBuilder: (ctx, index) => Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(left: 2),
                            leading: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      //offset: Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: profileItems[index].first),
                            title: Text(profileItems[index].second, style: const TextStyle(fontSize: 17)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      )),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  GestureDetector(
                      child: const SizedBox(
                          height: 50,
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 2),
                            leading: Icon(Icons.logout),
                            title: Text('Log out'),
                          )),
                      onTap: () {
                        Provider.of<Auth>(context, listen: false).logout();
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
