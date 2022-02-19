// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_final_fields, unused_field, unused_element

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myblogapp/model/blog.dart';
import 'package:myblogapp/model/user.dart';
import 'package:myblogapp/theme/color.dart';
import 'package:myblogapp/viewmodel/view_model.dart';
import 'package:myblogapp/widget/pd_alert_dialog.dart';
import 'package:provider/provider.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({Key? key, required this.currentUser}) : super(key: key);
  final MyUser? currentUser;

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  File? _yeniImage;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  _blogFotoEkle(ImageSource source) async {
    var _pickedFoto = await _picker.pickImage(source: source);

    setState(() {
      _yeniImage = File(_pickedFoto!.path);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel _userModel = Provider.of<UserModel>(context);
    MyUser? _currentUser = widget.currentUser;
    return Scaffold(
      backgroundColor: grey2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: grey.withOpacity(0.2),
        leading: IconButton(
          splashRadius: 24,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
          color: black,
        ),
        title: Text(
          "Add New Blog",
          style: TextStyle(
            color: black,
            fontSize: 17,
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 24,
            onPressed: () {},
            icon: Icon(
              Icons.attachment,
            ),
            color: black,
          ),
          IconButton(
            splashRadius: 24,
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
            color: black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 170,
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text("Kameradan Çek"),
                                onTap: () {
                                  _blogFotoEkle(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text("Galeriden Seç"),
                                onTap: () {
                                  _blogFotoEkle(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _yeniImage == null
                                ? NetworkImage(
                                    "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png")
                                : FileImage(_yeniImage!) as ImageProvider,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 120,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: black,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      splashRadius: 24,
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        color: white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Blog Title",
                  hintText: "Add Blog Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: _descController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "Blog Description",
                  hintText: "Add Blog Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_titleController.text.isEmpty ||
                    _descController.text.isEmpty ||
                    _yeniImage == null) {
                  _titleController.clear();
                  _descController.clear();

                  PDAlertDialog(
                    baslik: "Alanlar boş olamaz",
                    icerik: "Blog Eklenemedi.",
                    anaButonYazisi: "Tamam",
                    icon: "assets/icons/errors.svg",
                    color: Colors.greenAccent,
                  ).goster(context);
                } else {
                  _addBlog(context);
                }
                debugPrint("image : " + _yeniImage.toString());
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(width: 8),
                    Text(
                      "Save Blog",
                      style: TextStyle(
                        color: black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.save,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _blogFotoAdd(BuildContext context) async {
    if (_yeniImage != null) {
      int rastgeleSayi = Random().nextInt(999999999);
      final UserModel _userModel =
          Provider.of<UserModel>(context, listen: false);

      var url =
          await _userModel.uploadFileBlog(rastgeleSayi.toString(), _yeniImage);

      debugPrint("gelen url : " + url);
      return url;
    } else {
      return "";
    }
  }

  Future<void> _addBlog(BuildContext context) async {
    final UserModel _userModel = Provider.of<UserModel>(context, listen: false);
    var url = await _blogFotoAdd(context);
    int rastgeleSayi = Random().nextInt(999999999);
    Blog _kaydedilecekBlog = Blog(
      blogTitle: _titleController.text,
      blogDesc: _descController.text,
      writerID: widget.currentUser!.userID,
      blogID: rastgeleSayi.toString(),
      blogImageUrl: url.toString(),
      blogComment: "0",
      blogLikes: 0,
      blogShare: "0",
      blogDate: Timestamp.now(),
    );
    var sonuc = await _userModel.saveBlog(_kaydedilecekBlog);
    if (sonuc) {
      debugPrint(_kaydedilecekBlog.toString());
      Navigator.pop(context);
      PDAlertDialog(
        baslik: "Başarılı",
        icerik: "Blog Eklendi.",
        anaButonYazisi: "Tamam",
        icon: "assets/icons/complete.svg",
        color: Colors.greenAccent,
      ).goster(context);
    }
  }
}
