import 'package:flutter/material.dart';
import '../widgets/theappbar.dart';
import '../widgets/dropdown.dart';

//cas ou plusieurs modifs

class AdminAdd extends StatefulWidget {
  static const routeName = '/admin_add';
  const AdminAdd({super.key});

  @override
  State<StatefulWidget> createState() => _AdminAddState();
}

class _AdminAddState extends State<AdminAdd> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: FractionallySizedBox(
              widthFactor: 0.7,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(40.0),
                height: 500,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(255, 197, 240, 244)),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Add new product",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Product name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: lastNameController,
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
                    CustomDropdownButton(
                      list: list,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Image link'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
