// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myblogapp/theme/color.dart';

class AddBlogPage extends StatelessWidget {
  const AddBlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                        color: grey.withOpacity(0.8),
                        shape: BoxShape.circle,
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
            Container(
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
          ],
        ),
      ),
    );
  }
}
