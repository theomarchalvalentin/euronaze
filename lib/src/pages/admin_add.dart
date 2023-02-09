import 'package:flutter/material.dart';
import 'package:projet_dac/src/api/product_model.dart';
import '../api/api.dart';
import '../api/category_model.dart';
import '../widgets/theadminappbar.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

//cas ou plusieurs modifs

class AdminAdd extends StatefulWidget {
  const AdminAdd({super.key});

  @override
  State<StatefulWidget> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  final _formKey = GlobalKey<FormState>();
  String fileName = "None";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  int? selectedCategory;

  // Product? product;

  Uint8List? fileUpload;

  @override
  void initState() {
    super.initState();
  }

  _reset() {
    setState(() {
      nameController.text = "";
      descriptionController.text = "";
      imageController.text = "";
      priceController.text = "";
      selectedCategory = null;
      fileName = "None";
      fileUpload = null;
    });
  }

  final List<DropdownMenuItem<int>> _dropdownItems =
      listCategories.map((category) {
    return DropdownMenuItem<int>(
      value: category['categoryId'],
      child: Text(category['categoryName']),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height - 80;
    return Scaffold(
        appBar: AdminAppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            constraints: BoxConstraints(minHeight: height),
            //height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/city.jpg"),
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(40.0),
                constraints: const BoxConstraints(
                    minHeight: 560, minWidth: 500, maxWidth: 600),
                //height: 560,
                //width: width * 0.4,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(227, 197, 240, 244)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const Text(
                        "Add a product :",
                        style: TextStyle(
                          color: Color.fromARGB(255, 70, 70, 71),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Product name',

                          //hintStyle: Color.fromARGB(255, 3, 140, 129),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        maxLines: 5,
                        controller: descriptionController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                            labelText: 'Product Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          hint: const Text("Choose a category"),
                          value: selectedCategory,
                          items: _dropdownItems,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                        ),
                      ),
                      TextFormField(
                        controller: imageController,
                        decoration: const InputDecoration(
                          labelText: 'Image link',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "CSV selected: $fileName",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await _selectFile();
                              },
                              icon: const Icon(
                                Icons.upload_file_outlined,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                      TextFormField(
                        controller: priceController,
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null) {
                            return 'Please enter a number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //String? result; result= await if necessary
                            if (fileUpload != null) {
                              try {
                                await Api.postProduct(
                                    nameController.text,
                                    descriptionController.text,
                                    selectedCategory!,
                                    imageController.text,
                                    double.parse(priceController.text),
                                    fileUpload!);
                                _reset();
                                if (context.mounted) {
                                  // mouai
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Successfully Modified')),
                                  );
                                }
                              } on NoTokenExeption {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No Token found, please log again')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Unabled to Modify, please make sure informations are correct and try again')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Invalid .csv, please select a valid .csv and try again')),
                              );
                            }
                          }
                        },
                        child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(child: Text('Save'))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ["csv"], type: FileType.custom);

    if (result != null) {
      fileUpload = result.files.single.bytes!;
      fileName = result.files.single.name;
    }
    setState(() {});
  }
}
