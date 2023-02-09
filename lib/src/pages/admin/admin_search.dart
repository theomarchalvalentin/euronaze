import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/appbars/app_bar.dart';
import 'package:projet_dac/src/widgets/product_card.dart';

import '../../api/api.dart';
import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widgets/appbars/admin_appbar.dart';

List<String> listCat = listCategories
    .map((category) => category['categoryName'].toString())
    .toList();

class AdminSearch extends StatefulWidget {
  static const routeName = '/search';
  const AdminSearch({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  int selectedCategory = 0;
  String characters = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _search() async {
    try {
      if (characters.length > 1 || selectedCategory != 0) {
        var results = await Api.searchProduct(selectedCategory, characters);
        setState(() {
          _filteredProducts = results;
        });
      } else {
        _filteredProducts = [];
      }
    } on NoTokenExeption {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found, please log again')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to search')),
      );
    }
  }

  final List<DropdownMenuItem<int>> _dropdownItems = [
        const DropdownMenuItem(
          value: 0,
          child: Text('All'),
        ),
      ] +
      listCategories.map((category) {
        return DropdownMenuItem<int>(
          value: category['categoryId'],
          child: Text(category['categoryName']),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    // _buildDropdownItems();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AdminAppBar(),
      //bottomSheet: const SizedBox(height: 120, child: CustomFooter()),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 80,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      text: 'Search ',
                                      style: GoogleFonts.varela(
                                          textStyle: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      )),
                                      children: [
                                        TextSpan(
                                          text: 'for products: ',
                                          style: GoogleFonts.varela(
                                              textStyle: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xFF263b5e),
                                          )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rechercher par nom:',
                                      style: GoogleFonts.varela(
                                          textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      )),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        child: TextField(
                                          controller: _searchController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            iconColor: null,
                                            focusColor: null,
                                            fillColor: null,
                                            hoverColor: null,
                                            prefixIconColor: null,
                                            hintText: 'Rechercher',
                                            prefixIcon: Icon(Icons.search),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              characters =
                                                  _searchController.text;
                                            });
                                            _search();
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      'Filter by category',
                                      style: GoogleFonts.varela(
                                          textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF263b5e),
                                      )),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: DropdownButton(
                                        value: selectedCategory,
                                        items: _dropdownItems,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedCategory = value!;
                                          });
                                          _search();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.04,
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: _filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    return AdminProductCard(
                                        product: _filteredProducts[index],
                                        callback: _search);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class AdminProductCard extends StatelessWidget {
  final Product product;
  final Future<void> Function() callback;

  const AdminProductCard(
      {super.key, required this.product, required this.callback});

  @override
  Widget build(BuildContext context) {
    int id = product.productId;
    return GestureDetector(
      onTap: () => context.go('/modifyproduct/$id'),
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                  product.productImg,
                ),
              ),
              const Spacer(),
              categoryTag(product.categoryId),
              const Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          product.productName,
                          style: GoogleFonts.varela(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Color(0xFF263b5e),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Text(
                          "\$${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () async {
                  try {
                    await Api.deleteProduct(product.productId);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Deletion Success')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Deletion Error')),
                    );
                  }
                  callback(); //await
                },
                icon: const Icon(Icons.delete_forever_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
