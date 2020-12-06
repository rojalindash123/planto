import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planto/db/category.dart';
import 'package:planto/db/product.dart';
import 'package:planto/db/type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  categoryService _categoryService = categoryService();
  productServices productService = productServices();
  typeService _typeService = typeService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  String _currentCategory;
  List<DocumentSnapshot> types = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> typesDropDown = <DropdownMenuItem<String>>[];
  String _currentType;
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  File _image1;
  File _image2;
  File _image3;
  bool isloading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  @override
  void initState() {
    _getCategories();
    categoriesDropDown = getCategoriesDropdown();
    getCategoriesDropdown();
    _getTypes();
    typesDropDown = getTypesDropdown();
    getTypesDropdown();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(categories[i].data['category']),
                value: categories[i].data['category']));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getTypesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < types.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(types[i].data['type']),
                value: types[i].data['type']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        // leading: Icon(
        //   Icons.close,
        //   color: black,
        // ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isloading
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                                borderSide: BorderSide(
                                    color: grey.withOpacity(0.5), width: 2.5),
                                onPressed: () {
                                  _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      1);
                                },
                                child: _displayChild1()),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    2);
                              },
                              child: _displayChild2(),
                              // child: Padding(
                              //   padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
                              //   child: new Icon(
                              //     Icons.add,
                              //     color: grey,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    3);
                              },
                              child: _displayChild3(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'enter a product name with 10 characters at maximum',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Product name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter the product name';
                          } else if (value.length > 10) {
                            return 'Product name cant have more than 10 letters';
                          }
                        },
                      ),
                    ),

                    // Visibility(
                    //   visible: _currentCategory != null || _currentCategory == '',
                    //   child: Text(_currentCategory ?? "null",
                    //       style: TextStyle(color: red)),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TypeAheadField(
                    //     textFieldConfiguration: TextFieldConfiguration(
                    //         autofocus: false,
                    //         decoration: InputDecoration(hintText: 'add category')),
                    //     suggestionsCallback: (pattern) async {
                    //       return await _categoryService.getSuggestions(pattern);
                    //     },
                    //     itemBuilder: (context, suggestion) {
                    //       return ListTile(
                    //         leading: Icon(Icons.category),
                    //         title: Text(suggestion['category']),
                    //       );
                    //     },
                    //     onSuggestionSelected: (suggestion) {
                    //       setState(() {
                    //         _currentCategory = suggestion['category'];
                    //       });
                    //     },
                    //   ),
                    // ),

                    Row(
                      children: <Widget>[
                        Text(
                          'Category',
                          style: TextStyle(color: red),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            items: categoriesDropDown,
                            onChanged: changeSelectedCategory,
                            value: _currentCategory,
                          ),
                        ),
                        Text(
                          'Type',
                          style: TextStyle(color: red),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            items: typesDropDown,
                            onChanged: changeSelectedType,
                            value: _currentType,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Quantity'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter quantity';
                          }
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: 'Price'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'You must enter price';
                          }
                        },
                      ),
                    ),
                    //            select brand

                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add product'),
                      onPressed: () {
                        uploadProduct();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropdown();
      _currentCategory = categories[0].data['category'];
      print(categories.length);
    });
  }

  _getTypes() async {
    List<DocumentSnapshot> data = await _typeService.gettypes();
    print(data.length);
    setState(() {
      types = data;
      typesDropDown = getTypesDropdown();
      _currentType = types[0].data['type'];
      print(types.length);
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory);
  }

  changeSelectedType(String selectedType) {
    setState(() => _currentType = selectedType);
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // return Padding(
      //   padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
      //   child: Image.file(_image1),
      // );
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      // return Padding(
      //   padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
      //   child: Image.file(_image3),
      // );
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void uploadProduct() async {
    final documentId = await inputData();
    if (_formKey.currentState.validate()) {
      setState(() => isloading = true);
      if (_image1 != null && _image2 != null && _image3 != null) {
        String imageUrl1;
        String imageUrl2;
        String imageUrl3;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture1 =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        final String picture2 =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        final String picture3 =
            "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 =
            storage.ref().child(documentId).putFile(_image1);
        StorageUploadTask task2 =
            storage.ref().child(documentId).putFile(_image2);
        StorageUploadTask task3 =
            storage.ref().child(picture3).putFile(_image3);
        StorageTaskSnapshot snapshot1 =
            await task1.onComplete.then((snapshot) => snapshot);
        StorageTaskSnapshot snapshot2 =
            await task2.onComplete.then((snapshot) => snapshot);
        task3.onComplete.then((snapshot3) async {
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          imageUrl2 = await snapshot2.ref.getDownloadURL();
          imageUrl3 = await snapshot3.ref.getDownloadURL();
          List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];
          // productService.uploadProduct(
          //   productName: productNameController.text,
          //   price: double.parse(priceController.text),
          //   quantity: int.parse(quantityController.text),
          //   category: _currentCategory,
          //   type: _currentType,
          //   // images: imageList
          // );
          final documentId = await inputData();
          Firestore.instance
              .collection('sellers')
              .document(documentId)
              .collection('products')
              .document()
              .setData(
            {
              'pname': productNameController.text,
              'pcat': _currentCategory,
              'pPrice': double.parse(priceController.text),
              'pQuantity': int.parse(quantityController.text),
              'pType': _currentType,
              'pImage': imageList
            },
          );
          Firestore.instance.collection('stocks').document(documentId).setData({
            'pname': productNameController.text,
            'pcat': _currentCategory,
            'pPrice': double.parse(priceController.text),
            'pQuantity': int.parse(quantityController.text),
            'pType': _currentType,
            'pImage': imageList
          });
          _formKey.currentState.reset();
          setState(() {
            isloading = false;
          });
          Fluttertoast.showToast(msg: 'Products added');
          Navigator.pop(context);
        });
      } else {
        setState(() => isloading = false);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
