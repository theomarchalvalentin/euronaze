import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/appbars/app_bar.dart';
import 'package:projet_dac/src/widgets/product_card.dart';

import '../api/api.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

List<String> listCat = listCategories
    .map((category) => category['categoryName'].toString())
    .toList();

class LibraryPage extends StatefulWidget {
  static const routeName = '/libray';
  const LibraryPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  List<Product> products = [];
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _getLibrary();
  }

  _getLibrary() async {
    try {
      var results = await Api.getLibrary();
      setState(() {
        // lock = false;
        products = results;
        _filteredProducts = results;
      });
    } on NoTokenExeption {
      setState(() {
        // lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No token found, please log again')),
      );
    } catch (e) {
      setState(() {
        // lock = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to fetch Library')),
      );
    }
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = products.where((product) {
        if (selectedCategory == 0) {
          return product.productName
              .toLowerCase()
              .contains(query.toLowerCase());
        } else {
          return product.productName
                  .toLowerCase()
                  .contains(query.toLowerCase()) &&
              product.categoryId == selectedCategory;
        }
      }).toList();
    });
  }

  // List<DropdownMenuItem<int>> _dropdownItems = [];

  // void _buildDropdownItems() {
  //   _dropdownItems = [
  //     const DropdownMenuItem(
  //       value: 0,
  //       child: Text('All'),
  //     ),
  //   ];
  //   _dropdownItems.addAll(listCategories.map((category) {
  //     return DropdownMenuItem(
  //       value: category['categoryId'],
  //       child: Text(category['categoryName']),
  //     );
  //   }));
  // }

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

      appBar: CustomAppBar(),
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
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          child: Lottie.asset(
                                              'assets/images/lottielib.json')),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'You own\nthese products: ',
                                            style: GoogleFonts.varela(
                                                textStyle: const TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                              color: Color(0xFF263b5e),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Search by name in your library: ',
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
                                          onChanged: _filterProducts,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                    Text(
                                      'Filter by category: ',
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
                                            _filterProducts(
                                                _searchController.text);
                                          });
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
                        SearchLibrary(filteredProducts: _filteredProducts),
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

class SearchLibrary extends StatelessWidget {
  const SearchLibrary({
    super.key,
    required List<Product> filteredProducts,
  }) : _filteredProducts = filteredProducts;

  final List<Product> _filteredProducts;

  @override
  Widget build(BuildContext context) {
    return _filteredProducts.isNotEmpty
        ? Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return OwnedProductCard(
                          product: _filteredProducts[index]);
                    },
                  ),
                ),
              ),
            ),
          )
        : Flexible(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: const Color(0xFF263b5e).withOpacity(0.6),
                    ),
                    Text(
                      'Your library is empty...',
                      style: GoogleFonts.varela(
                          textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xFF263b5e).withOpacity(0.6),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
