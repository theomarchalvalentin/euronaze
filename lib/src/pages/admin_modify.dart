import 'package:flutter/material.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import '../widgets/theadminappbar.dart';

//cas ou plusieurs modifs

class AdminModify extends StatefulWidget {
  static const routeName = '/admin_add';
  const AdminModify({super.key, required this.productId});
  final String productId;

  @override
  State<StatefulWidget> createState() => _AdminModifyState();
}

class _AdminModifyState extends State<AdminModify> {
  final _formKey = GlobalKey<FormState>();
  String fileName = "None";

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  List<Category> list = dummyCategories;

  Category? selected;

  @override
  Widget build(BuildContext context) {
    Product product = dummyProducts[int.parse(widget.productId)];
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
                child: Column(
                  children: <Widget>[
                    const Text(
                      "Modify a product :",
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
                      child: DropdownButton<Category>(
                        value: selected,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        hint: const Text("Choose a category"),

                        //style: const TextStyle(color: Color.fromARGB(255, 3, 140, 129)),
                        underline: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 156, 156, 156),
                        ),
                        onChanged: (Category? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            selected = value!;
                          });
                        },
                        items: list
                            .map<DropdownMenuItem<Category>>((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.categoryName),
                          );
                        }).toList(),
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
                            onPressed: () {},
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
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(child: Text('Add'))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
