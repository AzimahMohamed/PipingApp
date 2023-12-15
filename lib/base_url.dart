import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsk_sivil_app_new/landing_page.dart';

class Basedurl extends StatefulWidget {
  Basedurl({this.url});
  final url;

  @override
  _BasedurlState createState() => _BasedurlState();
}

class _BasedurlState extends State<Basedurl> {
  Future<File> uploadimage;
  Image imageFromPreferences;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      uploadimage = ImagePicker.pickImage(source: source);
    });
  }

  Future<void> uploadImage(String baseUrl) async {
  }

  final _formKey = GlobalKey<FormState>();
  String typeBaseUrl = '';
  String typeBaseGallery = '';

  final List<String> base_url = [
    'intec-erp',
    'tsk-erp',
    'tsk-cp-erp',
    'tsk-bsm-erp',
    'ame-erp'
  ];

  /*loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }*/

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: uploadimage,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          //Utility.saveImageToPreferences(
           //   Utility.base64String(snapshot.data.readAsBytesSync()));
          return Image.file(
            snapshot.data,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "APP SETTINGS",
            style: TextStyle(color: Color(0xFF000000)),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.menu,
              color: Color(0xFF000000),
            ),
            //onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center, //content alignment to center
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'App_base_url (app link)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: widget.url == null ? 'app_base_url' : '${widget.url}' ,
                            errorStyle: TextStyle(color: Colors.red)),
                        autofocus: true,
                        onSaved: (value) => typeBaseUrl = value,
                        onChanged: (value) {
                          setState(() => typeBaseUrl = value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /*Text(
                        'App_base_url_gallery (app gallery)',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'app_base_url_gallery',
                            errorStyle: TextStyle(color: Colors.white)),
                        items: base_url.map((dishes) {
                          return DropdownMenuItem(
                            value: dishes,
                            child: Text('$dishes'),
                          );
                        }).toList(),
                        autofocus: true,
                        onSaved: (value) => typeBaseGallery = value,
                        onChanged: (value) {
                          setState(() => typeBaseGallery = value);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Upload Company Logo',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      FlatButton(
                            onPressed: () async {
                              pickImageFromGallery(ImageSource.gallery);
                            },
                            child: Text('Select Picture'),
                            color: Color(0xFF8E9DA8),
                      ),
                      imageFromGallery(),*/
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print('Pref: $typeBaseUrl');
                            //loadImageFromPreferences();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => landingPage(url: typeBaseUrl),
                              ),
                            );
                          }

                          /*if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            StorageReference storageRef = FirebaseStorage.instance
                                .ref().child('recipePhoto/${Path.basename(image.path)}');
                            StorageUploadTask uploadTask = storageRef.putFile(image);
                            await uploadTask.onComplete;

                            storageRef.getDownloadURL().then((fileURL) async {
                              _imageURL = fileURL;

                              if(_imageURL != null) {
                                await DatabaseService(uid:uid).getUserRecipe(
                                    titleRecipe: titleRecipe,
                                    totalServing: totalServing,
                                    typeCuisine: typeCuisine,
                                    infoNutrition: _infoNutrition,
                                    imageRecipe: _imageURL,
                                    subIngredients: _subingredients,
                                    subStep: _substep
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => myRecipes(),
                                  ),
                                );
                              }
                            });
                            //DatabaseService().uploadImage(image);
                          }*/
                        },
                        child: Text('Save'),
                        //color: Color(0xFF186094),
                      ),
                      null == imageFromPreferences ? Container() : imageFromPreferences,
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
