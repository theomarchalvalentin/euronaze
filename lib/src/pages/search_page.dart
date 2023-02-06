import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_dac/src/models/datamodel.dart';
import 'package:projet_dac/src/widgets/custom_footer.dart';
import 'package:projet_dac/src/widgets/homepage/home_search_bar.dart';
import 'package:projet_dac/src/widgets/theappbar.dart';
import 'package:projet_dac/src/widgets/dropdown.dart';
import 'package:projet_dac/src/widgets/product_card.dart';

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
  final List<String> categories = <String>['One', 'Two', 'Three', 'Four'];
  final List<Product> products = dummyProducts;

  @override
  void initState() {
    super.initState();
    _filteredProducts = products;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.015,
                    MediaQuery.of(context).size.width * 0.015,
                    MediaQuery.of(context).size.width * 0.015,
                    0),
                child: Wrap(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
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
                    ),
                    const SizedBox(
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
                    const SizedBox(
                      height: 100,
                    ),
                    const Divider(
                      color: Color(0xFF263b5e),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.33,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Search by name :",
                                  style: GoogleFonts.varela(
                                      textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF263b5e),
                                  )),
                                ),
                                HomeSearchBar(
                                    screenSize: MediaQuery.of(context).size),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  "Filter by category :",
                                  style: GoogleFonts.varela(
                                      textStyle: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF263b5e),
                                  )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomDropdownButton(list: categories)
                              ],
                            )),
                        const SizedBox(
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
              const CustomFooter()
            ],
          ),
        ));
  }
}
