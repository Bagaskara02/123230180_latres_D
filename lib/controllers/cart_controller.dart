import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  late Box<CartItem> _cartBox;
  var cartItems = <CartItem>[].obs;

  String get _currentUser => Get.find<AuthController>().username.value;

  @override
  void onInit() {
    super.onInit();
    _cartBox = Hive.box<CartItem>('cartBox');
    loadCartItems();
  }

  void loadCartItems() {
    cartItems.value = _cartBox.values
        .where((item) => item.username == _currentUser)
        .toList();
  }

  Future<void> addToCart(Product product, int quantity) async {
    CartItem? existing;
    for (var item in _cartBox.values) {
      if (item.productId == product.id && item.username == _currentUser) {
        existing = item;
        break;
      }
    }

    if (existing != null) {
      existing.quantity = quantity;
      await existing.save();
    } else {
      await _cartBox.add(CartItem(
        productId: product.id,
        title: product.title,
        price: product.price,
        thumbnail: product.thumbnail,
        quantity: quantity,
        username: _currentUser,
      ));
    }
    loadCartItems();
  }

  Future<void> removeFromCart(CartItem item) async {
    await item.delete();
    loadCartItems();
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
