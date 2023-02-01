class Product {
  final int productId;
  final String productName;
  final String productDescription;
  final String productData;
  final int categoryId;

  const Product(this.categoryId, this.productData, this.productDescription,
      this.productId, this.productName);
}

class Category {
  final int categoryId;
  final String categoryName;
  final String imgPath;
  final String categoryDescription;

  const Category(this.categoryId, this.categoryName, this.categoryDescription,
      this.imgPath);
}

const String stocksCategoryDescription =
    "Stocks are like a rollercoaster ride, the highs can be exhilarating, but the lows can make you want to throw up. But if you're willing to stomach the ups and downs, you might just strike it rich.";
const String stocksImgPath = "assets/images/stockscar.jpg";

const String FXCategoryDescription =
    "FX, or Foreign Exchange, is like the game of musical chairs with currencies, where the value of one currency rises as another falls, and traders try to navigate the shifting exchange rates to make a profit, like a high stakes game of currency roulette. ";

const String FXImgPath = "assets/images/fxcar.jpg";

const String fixedIncomeCategoryDescription =
    "Fixed Income is like a trusty savings account, providing a stable stream of income in the form of bonds or other debt instruments, offering stability in an unpredictable investment world, like a life raft in stormy financial seas.";
const String fixedIncomeImgPath = "assets/images/bondscar.jpeg";

const String indexesCategoryDescription =
    "Indexes are like the scorecard of the stock market, they keep track of the performance of a group of stocks, giving you a snapshot of the market's overall health and direction, like a GPS for your investment journey.";
const String indexesImgPath = "assets/images/etf.jpg";

const List<String> CategoriesNames = [
  'Stocks',
  'FX',
  'Fixed Income',
  'Indexes'
];
const List<String> CategoriesImg = [
  "assets/images/stockscar.jpg",
  "assets/images/fxcar.jpg",
  "assets/images/bondscar.jpeg",
  "assets/images/etf.jpg"
];

const List<Category> listCategories = [
  Category(1, 'Stocks', stocksCategoryDescription, stocksImgPath),
  Category(2, 'FX', FXCategoryDescription, FXImgPath),
  Category(
      3, 'Fixed Income', fixedIncomeCategoryDescription, fixedIncomeImgPath),
  Category(4, 'Indexes', indexesCategoryDescription, indexesImgPath),
];
