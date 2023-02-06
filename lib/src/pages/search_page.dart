import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';
import 'package:projet_dac/src/widgets/dropdown.dart';
import 'package:projet_dac/src/widgets/product_card.dart';

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
      DropdownMenuItem(
        child: Text('All'),
        value: '0',
      ),
    ];
    _dropdownItems.addAll(listCategories.map((category) {
      return DropdownMenuItem(
        child: Text(category['categoryName']),
        value: category['categoryId'],
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    _buildDropdownItems();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProducts,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
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
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(product: _filteredProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
