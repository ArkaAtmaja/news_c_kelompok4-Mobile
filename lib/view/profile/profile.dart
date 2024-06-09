import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:news_c_kelompok4/client/auth.dart';
import 'package:news_c_kelompok4/model/user_model.dart';
import 'package:news_c_kelompok4/view/settings/settings.dart';
import 'package:news_c_kelompok4/view/about/about.dart';
import 'package:news_c_kelompok4/view/payments/body.dart';
import 'dart:io';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  bool _isEditing = false;
  bool _isPasswordVisible = false;
  late String username = 'NULL';
  String selectedImagePath = '';
  String ImgProfile = '';
  String ImgSampul = '';
  int userID = 0;

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController noTelpController;
  late TextEditingController tanggalLahirController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    loadUserData();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    tanggalLahirController = TextEditingController();
    noTelpController = TextEditingController();
    genderController = TextEditingController();
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('username');

    Navigator.pushReplacementNamed(context, 'LoginView');
  }

  Future<void> editProfile(BuildContext context) async {
    setState(() {
      _isEditing = true;
    });
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
      // userID = widget.userId;
    });
  }

  Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<Map<String, dynamic>> _getUserData() async {
    return await UserClient.getUserByUsername(username);
  }

  Future<void> _updateUserData() async {
    saveUsername(usernameController.text);
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String date = tanggalLahirController.text;
    String noTelp = noTelpController.text;
    String gender = genderController.text;
    String imgProfile = ImgProfile;
    String imgSampul = ImgSampul;

    User input = User(
      id: userID,
      username: username,
      email: email,
      password: password,
      noTelp: noTelp,
      tanggalLahir: date,
      gender: gender,
      imgProfile: imgProfile,
      imgSampul: imgSampul,
    );
    await UserClient.update(input);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data diri berhasil diperbarui!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _saveUserData() async {
    _updateUserData();

    setState(() {
      _isEditing = false;
    });
  }

  Future selectImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.h),
          ),
          child: Container(
            height: 30.h,
            child: Padding(
              padding: EdgeInsets.all(3.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print('Image_path: -');
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(3.h),
                              child: Icon(Icons.browse_gallery),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            print('Image_path: -');
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(3.h),
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildReadOnlyProfile() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                  // decoration: BoxDecoration(),
                  // child: selectedImagePath2.isNotEmpty
                  //     ? Image.file(
                  //         File(selectedImagePath2),
                  //         height: 20.h,
                  //         width: 100.w,
                  //         fit: BoxFit.fill,
                  //       )
                  //     : imageSampul.isNotEmpty
                  //         ? Image.file(
                  //             File(imageSampul),
                  //             height: 20.h,
                  //             width: 200.w,
                  //             fit: BoxFit.fill,
                  //           )
                  //         : Image.asset(
                  //             'lib/images/cuaca.jpg',
                  //             height: 20.h,
                  //             width: 100.w,
                  //             fit: BoxFit.fill,
                  //           ),
                  ),
              //Positioned(
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(150.sp),
              //   child: selectedImagePath.isNotEmpty
              //       ? Image.file(
              //           File(selectedImagePath),
              //           height: 15.h,
              //           width: 35.w,
              //           fit: BoxFit.fill,
              //         )
              //       : //imageProfile.isNotEmpty
              //           ? Image.file(
              //               //File(imageProfile),
              //               height: 15.h,
              //               width: 35.w,
              //               fit: BoxFit.fill,
              //             )
              //           : Container(
              //               decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(150.sp),
              //               ),
              //               child: Image.asset(
              //                 'lib/images/fotoProfil/user1.jpg',
              //                 height: 15.h,
              //                 width: 35.w,
              //                 fit: BoxFit.fill,
              //               ),
              //             ),
              // ),
              //),
            ],
          ),
          SizedBox(height: 3.h),
          Padding(
            padding:
                EdgeInsets.only(left: 45.sp), // Adjusted for manual shifting
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                username,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 40.sp), // Adjusted for manual shifting
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                emailController.text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text('Posts', style: Theme.of(context).textTheme.headlineSmall),
          Text('100+', style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: 20.sp),
          SizedBox(height: 3.h),
          SizedBox(
            width: 50.w, // Adjusted for responsive sizing
            child: ElevatedButton(
              onPressed: () {
                editProfile(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 144, 141, 149),
                shape: StadiumBorder(),
              ),
              child: Row(
                children: [
                  Icon(Icons.edit_outlined,
                      color: Color.fromARGB(255, 250, 249, 249)),
                  SizedBox(width: 6.w),
                  Text('Edit Profile',
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 249, 249))),
                  SizedBox(width: 7.w),
                  Icon(LineAwesomeIcons.angle_right),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 144, 141, 149),
                shape: StadiumBorder(),
              ),
              child: Row(
                children: [
                  Icon(Icons.announcement,
                      color: Color.fromARGB(255, 250, 249, 249)),
                  SizedBox(width: 6.w),
                  Text('About',
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 249, 249))),
                  SizedBox(width: 15.w),
                  Icon(LineAwesomeIcons.angle_right),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PembayaranViewList()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 144, 141, 149),
                shape: StadiumBorder(),
              ),
              child: Row(
                children: [
                  Icon(Icons.settings,
                      color: Color.fromARGB(255, 250, 249, 249)),
                  SizedBox(width: 6.w),
                  Text('Settings',
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 249, 249))),
                  SizedBox(width: 11.w),
                  Icon(LineAwesomeIcons.angle_right),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 168, 28, 133),
                shape: StadiumBorder(),
              ),
              child: Row(
                children: [
                  Icon(Icons.monetization_on_rounded,
                      color: Color.fromARGB(255, 250, 249, 249)),
                  SizedBox(width: 6.w),
                  Text('PRO',
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 249, 249))),
                  SizedBox(width: 17.w),
                  Icon(LineAwesomeIcons.angle_right),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: ElevatedButton(
              onPressed: () {
                logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 144, 141, 149),
                shape: StadiumBorder(),
              ),
              child: Row(
                children: [
                  Icon(Icons.logout, color: Color.fromARGB(255, 250, 249, 249)),
                  SizedBox(width: 6.w),
                  Text('Logout',
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 249, 249))),
                  SizedBox(width: 13.w),
                  Icon(LineAwesomeIcons.angle_right),
                ],
              ),
            ),
          ),
          // Other profile options/buttons
          // ...
        ],
      ),
    );
  }

  Widget buildEditProfile() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                // child: selectedImagePath2.isNotEmpty
                //     ? Image.file(
                //         File(selectedImagePath2),
                //         height: 20.h,
                //         width: 100.w,
                //         fit: BoxFit.fill,
                //       )
                //     : imgSampul.isNotEmpty
                //         ? Image.file(
                //             File(imgSampul),
                //             height: 20.h,
                //             width: 200.w,
                //             fit: BoxFit.fill,
                //           )
                //         : Image.asset(
                //             'lib/images/cuaca.jpg',
                //             height: 20.h,
                //             width: 100.w,
                //             fit: BoxFit.fill,
                //           ),
              ),
              Positioned(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.sp),
                  child: selectedImagePath.isNotEmpty
                      ? Image.file(
                          File(selectedImagePath),
                          height: 15.h,
                          width: 35.w,
                          fit: BoxFit.fill,
                        )
                      // // : imgProfile.isNotEmpty
                      // //     ? Image.file(
                      // //         File(imgProfile),
                      //         height: 15.h,
                      //         width: 35.w,
                      //         fit: BoxFit.fill,
                      //       )
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150.sp),
                          ),
                          child: Image.asset(
                            'lib/images/fotoProfil/user1.jpg',
                            height: 15.h,
                            width: 35.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 120,
                right: 120.0,
                child: InkWell(
                  onTap: () {
                    //modalProfilImage(context);
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(195, 109, 92, 92),
                    size: 40.0,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 5.0,
                child: InkWell(
                  onTap: () {
                    //modalCoverImage(context);
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.teal,
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'You cannot change your username',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 3.0.h),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'You cannot change your email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 3.0.h),
          TextFormField(
            controller: passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
          ),
          SizedBox(height: 3.0.h),
          TextFormField(
            key: const ValueKey('tanggalLahir'),
            controller: tanggalLahirController,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setState(() {
                  tanggalLahirController.text =
                      pickedDate.toLocal().toString().split(' ')[0];
                });
              }
            },
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.calendar_today),
              labelText: 'Tanggal',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      tanggalLahirController.text =
                          pickedDate.toLocal().toString().split(' ')[0];
                    });
                  }
                },
              ),
            ),
            validator: (value) =>
                value == '' ? 'Masukkan tanggal lahir!' : null,
          ),
          SizedBox(height: 3.0.h),
          TextFormField(
            controller: noTelpController,
            decoration: InputDecoration(
                labelText: 'Nomor Telepon',
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )),
          ),
          SizedBox(height: 3.0.h),
          TextFormField(
            controller: genderController,
            decoration: InputDecoration(
              labelText: 'Gender',
              prefixIcon: Icon(Icons.transgender_sharp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          SizedBox(height: 3.0.h),
          ElevatedButton(
            onPressed: _saveUserData,
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Set the background color to green
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 1.h), // Adjust the padding for size
            ),
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: 15.sp, // Adjust the font size
                color: Colors.white, // Set the text color to white
              ),
            ),
          ),
          SizedBox(height: 20.sp),

          // Other profile options/buttons in edit mode
          // ...
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30.sp),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userData = snapshot.data;

              if (userData != null && userData['status'] == true) {
                final userDataMap = userData['data'];

                // Set controller values
                usernameController.text = userDataMap['username'] ?? '';
                emailController.text = userDataMap['email'] ?? '';
                passwordController.text = '';
                tanggalLahirController.text = userDataMap['tanggalLahir'] ?? '';
                noTelpController.text = userDataMap['noTelp'] ?? '';
                genderController.text = userDataMap['gender'] ?? '';
                ImgProfile = userDataMap['imgProfile'] ?? '';

                userID = userDataMap['id'] ?? 0;
              } else {
                print('User data is null or status is false');
              }

              return _isEditing ? buildEditProfile() : buildReadOnlyProfile();
            }
          },
        ),
      ),
    );
  }
}
