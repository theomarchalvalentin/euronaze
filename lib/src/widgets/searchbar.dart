import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/homepage/featured_headings.dart';
import 'package:projet_dac/src/widgets/homepage/greeting_text.dart';
import 'package:projet_dac/src/widgets/homepage/home_search_bar.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';

import '../pages/product_details_screen.dart';

class SearchPage extends StatefulWidget {
  final List<Product> products = dummyProducts;
  static const routeName = '/search';
  SearchPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = widget.products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomSheet: SizedBox(height: 130, child: const CustomFooter()),
      body: SingleChildScrollView(
          child: SearchPageBody(filteredProducts: _filteredProducts)),
    );
  }
}

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({
    super.key,
    required List<Product> filteredProducts,
  }) : _filteredProducts = filteredProducts;

  final List<Product> _filteredProducts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.015,
              MediaQuery.of(context).size.width * 0.015,
              MediaQuery.of(context).size.width * 0.015,
              MediaQuery.of(context).size.width * 0.015),
          child: Container(
            // constraints: BoxConstraints(
            //     maxWidth: MediaQuery.of(context).size.width,
            //     maxHeight: MediaQuery.of(context).size.height),
            child: Wrap(
              children: [
                Align(
                  child: Text(
                    "Search Products",
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                  ),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  // ignore: sort_child_properties_last
                  child: Text(
                    " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus eu sollicitudin tortor, eget semper turpis. Curabitur eget velit in leo pellentesque finibus. Nunc ultrices, enim fermentum facilisis interdum, dui odio luctus sapien, eu volutpat elit nulla vitae odio. Duis dui urna, volutpat a posuere at, vulputate nec erat. Ut in massa efficitur lacus convallis sodales. Etiam neque orci, maximus ut lacus ac, auctor gravida risus. Morbi ultrices urna vel lacus tempor auctor. \nCurabitur porttitor porta enim a viverra. In ornare, tellus et aliquet blandit, enim velit commodo ante, id rutrum lorem elit et felis. Phasellus varius dignissim felis, a venenatis sapien convallis sit amet. Pellentesque suscipit nisi eget ipsum lacinia venenatis. Quisque volutpat nunc vitae est auctor posuere. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Cras elementum nunc diam, eget ultricies lorem ullamcorper nec. ",
                    style: GoogleFonts.varela(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.normal,
                      color: Color(0xFF263b5e),
                    )),
                  ),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 100,
                ),
                const Divider(
                  color: Color(0xFF263b5e),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.33,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HomeSearchBar(
                                screenSize: MediaQuery.of(context).size),
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Filter results : ",
                              style: GoogleFonts.varela(
                                  textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                color: Color(0xFF263b5e),
                              )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FilterList()
                          ],
                        )),
                    SizedBox(
                      width: 200,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product: _filteredProducts[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(ProductScreenDetails.routeName, arguments: product),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.network(
                  product.productImg,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${product.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
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

class FilterBlock extends StatelessWidget {
  final String text;

  const FilterBlock({Key? key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class FilterList extends StatelessWidget {
  final List<String> filters = ['Crypto', 'FX', 'Stocks', 'Automotive'];

  FilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filters.map((filter) => FilterBlock(text: filter)).toList(),
    );
  }
}
