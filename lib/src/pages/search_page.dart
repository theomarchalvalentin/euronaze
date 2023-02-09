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

class SearchPage extends StatefulWidget {
  static const routeName = '/search';
  const SearchPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

      appBar: CustomAppBar(),
      //bottomSheet: const SizedBox(height: 120, child: CustomFooter()),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 80,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxHeight: 100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Lottie.asset(
                                              'assets/images/rocket.json'),
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: ' Search ',
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
                                                      textStyle:
                                                          const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    color: Color(0xFF263b5e),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                      'Search by name:',
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
                                            hintText: 'Search',
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
                        SearchResults(filteredProducts: _filteredProducts),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({
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
                      return SearchProductCard(
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
                      Icons.search,
                      color: const Color(0xFF263b5e).withOpacity(0.6),
                    ),
                    Text(
                      'Begin typing\nto see results...',
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
