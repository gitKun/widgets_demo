import 'package:scoped_model/scoped_model.dart';

import 'package:my_gallery/demo/shrine/model/product.dart';
import 'package:my_gallery/demo/shrine/model/products_repository.dart';

double _scalesTaxRate = 0.06;
double _shippingCostPerItem = 7.0;

class AppStateModel extends Model {
  // 全部可用的产品
  List<Product> _availableProducts;
  // 当前选中的产品
  Category _selectedCategory = Category.all;
  // 购物车中当前产品的id和数量
  final Map<int, int> _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map<int, int>.from(_productsInCart);

  // 购物车中的总商品数
  int get totalCartQuantity =>
      _productsInCart.values.fold(0, (int v, int e) => v + e);

  Category get selectedCategory => _selectedCategory;
  // 购物车中所有商品的总价。
  double get subtotalCost {
    return _productsInCart.keys
        .map((int id) => _availableProducts[id].price * _productsInCart[id])
        .fold(0.0, (double sum, int e) => sum + e);
  }

  // 购物车中物品的总运费。
  double get shippingCost {
    return _shippingCostPerItem *
        _productsInCart.values.fold(0.0, (num sum, int e) => sum + e);
  }

  // 购物车中物品的销售税
  double get tax => subtotalCost * _scalesTaxRate;
  // 在购物车中订购所有东西的总成本。
  double get totlaCost => subtotalCost + shippingCost + tax;

  // 返回按类别筛选的可用产品列表的副本。
  List<Product> getProducts() {
    if (_availableProducts == null) {
      return <Product>[];
    }
    if (_selectedCategory == Category.all) {
      return List<Product>.from(_availableProducts);
    } else {
      return _availableProducts
          .where((Product p) => p.category == _selectedCategory)
          .toList();
    }
  }

  // 添加到购物车
  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId]++;
    }
    notifyListeners();
  }

  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId]--;
      }
    }
    notifyListeners();
  }

  Product getProductById(int id) {
    return _availableProducts.firstWhere((Product p) => p.id == id);
  }

  void clearCart() {
    _productsInCart.clear();
    notifyListeners();
  }

  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(Category.all);
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }

  @override
  String toString() {
    return 'AppStateModel(totalCost: $totlaCost)';
  }
}
