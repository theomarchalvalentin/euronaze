class Product {
  final int productId;
  final String productName;
  final productDescription =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  final String categoryId;
  final String productImg;
  final productDataLink = "http://www.google.com/";
  final price = "100";

  const Product(
      this.categoryId, this.productId, this.productName, this.productImg);
}

const bullAssetsImages = <String>[
  'assets/images/teslajpg.jpg',
  'assets/images/Dogecoin_logo.jpg',
  'assets/images/isharespng.png',
  'assets/images/euronaze.png',
];

final bullAssetsNames = <String>[
  'Tesla',
  'Dogecoin',
  'iShares',
  'Euronaze',
];

final bearAssetsImages = <String>[
  'assets/images/ftx.jpg',
  'assets/images/creditsuisse.png',
  'assets/images/pfizer.png',
  'assets/images/renault.jpg',
];

final bearAssetsNames = <String>[
  'FTX Token',
  'Crédit Suisse',
  'Pfizer',
  'Renault',
];

final dummyProducts = <Product>[
  Product('1', 0, bearAssetsNames[0], bearAssetsImages[0]),
  Product('1', 1, bearAssetsNames[1], bearAssetsImages[1]),
  Product('2', 2, bearAssetsNames[2], bearAssetsImages[2]),
  Product('2', 3, bearAssetsNames[3], bearAssetsImages[3]),
];

class Category {
  final String categoryId;
  final String categoryName;
  final String imgPath;
  final String categoryDescription;

  const Category(this.categoryId, this.categoryName, this.categoryDescription,
      this.imgPath);
}

const String stocksCategoryDescription =
    "Stocks are like a rollercoaster ride, the highs can be exhilarating, but the lows can make you want to throw up. But if you're willing to stomach the ups and downs, you might just strike it rich.";
const String stocksImgPath = "assets/images/stockscar.jpg";

const String fxCategoryDescription =
    "FX, or Foreign Exchange, is like the game of musical chairs with currencies, where the value of one currency rises as another falls, and traders try to navigate the shifting exchange rates to make a profit, like a high stakes game of currency roulette. ";

const String fxImgPath = "assets/images/fxcar.jpg";

const String fixedIncomeCategoryDescription =
    "Fixed Income is like a trusty savings account, providing a stable stream of income in the form of bonds or other debt instruments, offering stability in an unpredictable investment world, like a life raft in stormy financial seas.";
const String fixedIncomeImgPath = "assets/images/bondscar.jpeg";

const String indexesCategoryDescription =
    "Indexes are like the scorecard of the stock market, they keep track of the performance of a group of stocks, giving you a snapshot of the market's overall health and direction, like a GPS for your investment journey.";
const String indexesImgPath = "assets/images/etf.jpg";

const List<String> categoriesNames = [
  'Stocks',
  'FX',
  'Fixed Income',
  'Indexes'
];
const List<String> categoriesImg = [
  "assets/images/stockscar.jpg",
  "assets/images/fxcar.jpg",
  "assets/images/bondscar.jpeg",
  "assets/images/etf.jpg"
];

const List<Map> listCategories = [
  {
    'categoryId': '1',
    'categoryName': 'Stocks',
    'categoryDescription': stocksCategoryDescription,
    'categoryImg': stocksImgPath
  },
  {
    'categoryId': '2',
    'categoryName': 'FX',
    'categoryDescription': fxCategoryDescription,
    'categoryImg': fxImgPath
  },
  {
    'categoryId': '3',
    'categoryName': 'Fixed Income',
    'categoryDescription': fixedIncomeCategoryDescription,
    'categoryImg': fixedIncomeImgPath
  },
  {
    'categoryId': '4',
    'categoryName': 'Indexes',
    'categoryDescription': indexesCategoryDescription,
    'categoryImg': indexesImgPath
  },
];
