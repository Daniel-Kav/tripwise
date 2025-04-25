import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];
  
  List<Product> get items => [..._items];
  
  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.price);
  }
  
  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }
  
  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shop',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Categories
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('All', true, context),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Cues', false, context),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Balls', false, context),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Accessories', false, context),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Products Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                  children: _buildProductCards(context),
                ),
              ),
            ],
          ),
        ),
      ),
      // Shopping Cart FAB
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to cart screen
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.shopping_cart, color: Colors.white),
          ),
          if (cartProvider.items.isNotEmpty)
            Positioned(
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${cartProvider.items.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, BuildContext context) {
    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[800],
        ),
      ),
      onSelected: (bool selected) {},
      backgroundColor: Colors.grey[200],
      selectedColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      showCheckmark: false,
    );
  }

  List<Widget> _buildProductCards(BuildContext context) {
    final List<Product> products = [
      Product(
        id: '1',
        name: 'Professional Cue',
        description: 'High-quality professional cue',
        price: 199.99,
        category: 'Cues',
        imageUrl: 'assets/images/pro_cue.jpg',
      ),
      Product(
        id: '2',
        name: 'Billiard Ball Set',
        description: 'Complete billiard ball set',
        price: 89.99,
        category: 'Balls',
        imageUrl: 'assets/images/ball_set.jpg',
      ),
      Product(
        id: '3',
        name: 'Premium Chalk',
        description: 'High-quality premium chalk',
        price: 9.99,
        category: 'Accessories',
        imageUrl: 'assets/images/chalk.jpg',
      ),
      // ... Add more products here
    ];

    return products.map((product) {
      return ProductCard(product: product);
    }).toList();
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add the product to cart
        Provider.of<CartProvider>(context, listen: false).addItem(product);
        
        // Show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} added to cart'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).removeItem(product);
              },
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                product.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
