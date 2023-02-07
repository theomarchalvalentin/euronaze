import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';
import 'package:projet_dac/src/widgets/dropdown.dart';
import 'package:projet_dac/src/widgets/product_card.dart';

double listViewTotal(List<Product> products) {
  double total = 0.0;
  products.forEach((element) => total += double.parse(element.price));
  return total;
}

List<String> listCat = listCategories
    .map((category) => category['categoryName'].toString())
    .toList();

class CartPage extends StatefulWidget {
  static const routeName = '/cart';
  const CartPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  final List<Product> products = dummyProducts;
  String selectedCategory = '0';

  @override
  void initState() {
    super.initState();
    _filteredProducts = products;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = products.where((product) {
        if (selectedCategory == '0') {
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

  List<DropdownMenuItem<String>> _dropdownItems = [];

  void _buildDropdownItems() {
    _dropdownItems = [
      const DropdownMenuItem(
        value: '0',
        child: Text('All'),
      ),
    ];
    _dropdownItems.addAll(listCategories.map((category) {
      return DropdownMenuItem(
        value: category['categoryId'],
        child: Text(category['categoryName']),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    _buildDropdownItems();
    return Scaffold(
      appBar: CustomAppBar(),
      bottomSheet: const SizedBox(height: 120, child: CustomFooter()),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
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
                                text: TextSpan(
                                  text: 'Théo, ',
                                  style: GoogleFonts.varela(
                                      textStyle: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF263b5e),
                                  )),
                                  children: [
                                    TextSpan(
                                      text: 'voici votre panier: ',
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
                                  'Rechercher par nom dans le panier: ',
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
                                    width: MediaQuery.of(context).size.width *
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
                                  'Filtrer par catégorie: ',
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
                                        _filterProducts(_searchController.text);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.19,
                        ),
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  child: Column(children: [
                                    Positioned(
                                      right: 5,
                                      child: Text(
                                        'Total : ${listViewTotal(_filteredProducts)}\$',
                                        style: GoogleFonts.varela(
                                            textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF263b5e),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.shade100,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          child: const Text(
                                            '🛒 Valider le panier',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ))),
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
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _filteredProducts.length,
                              itemBuilder: (context, index) {
                                return BasketProductCard(
                                    product: _filteredProducts[index]);
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
      ),
    );
  }
}
