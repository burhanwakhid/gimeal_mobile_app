import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gimeal/config/config.dart';
import 'package:gimeal/core/services/firebase_firestore/FireUserService.dart';
import 'package:gimeal/core/shared_preferences/config_shared_preferences.dart';
import 'package:gimeal/ui/shared/styles.dart';
import 'package:gimeal/ui/widgets/TransparentDivider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  MainSharedPreferences mainSharedPreferences = MainSharedPreferences();
  final ImagePicker imagePicker = ImagePicker();
  File userPhoto;
  FocusNode _phoneFN = FocusNode();
  FocusNode _nameFN = FocusNode();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String idUser = '';

  Future actionEditUser({String idUser, String hp, String nama}) async {
    if (hp[0] == '0') {
      hp = hp.replaceRange(0, 1, '+62');
    }
    await UserServices.editUser(idUser, hp, nama).then((value) {
      Navigator.pop(context);
    });
  }

  Future getSavedData() async {
    mainSharedPreferences.getIdUser().then((value) {
      print(value);
    });
  }

  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        userPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future initForm() async {
    _phoneController.text = await mainSharedPreferences.getHpUser() ?? '';
    _nameController.text = await mainSharedPreferences.getUserName() ?? '';
    idUser = await mainSharedPreferences.getIdUser();
  }

  @override
  void initState() {
    this.initForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _phoneFN.unfocus();
        _nameFN.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.grey,
          ),
          title: Text(
            'Edit Profil',
            style: TextStyling(color: Colors.grey)..bold(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRUj_RjV66y5BZlTyn3GZVKy7Ioc09fe9acw&usqp=CAU',
                        ),
                      ),
                      Visibility(
                        visible: userPhoto != null,
                        child: Icon(Icons.arrow_right_alt_outlined),
                      ),
                      userPhoto != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              backgroundImage: FileImage(
                                userPhoto,
                              ),
                            )
                          : SizedBox(
                              width: 1,
                            ),
                    ],
                  ),
                  TransparentDivider(),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50))),
                    onPressed: () {
//                      this.getImage();
                    },
                    color: kMainColor,
                    child: Text(
                      'Ubah Foto',
                      style: TextStyling(color: Colors.white),
                    ),
                  ),
                  TransparentDivider(),
                  TextFormField(
                    focusNode: _nameFN,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Nama'),
                    onFieldSubmitted: (value) {
                      _phoneFN.requestFocus();
                    },
                  ),
                  TransparentDivider(),
                  TextFormField(
                    focusNode: _phoneFN,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor tidak boleh kosong';
                      } else if (value.length < 9 || value.length > 15) {
                        return 'Nomor tidak Valid';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _phoneController,
                    decoration: InputDecoration(
                        labelText: 'Nomor Hp',
                        hintText: 'Contoh +6281666777888'),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50), right: Radius.circular(50))),
                onPressed: () {
                  this.actionEditUser(
                      idUser: this.idUser,
                      hp: _phoneController.text,
                      nama: _nameController.text);
                },
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                color: kAccentColor,
                child: Text(
                  'Simpan Perubahan',
                  style: TextStyling(color: Colors.white)..big(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
