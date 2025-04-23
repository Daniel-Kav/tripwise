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

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Hiking Backpack',
      description: 'Durable 40L hiking backpack with rain cover',
      price: 89.99,
      imageUrl: 'https://example.com/backpack.jpg',
      category: 'Equipment',
    ),
    Product(
      id: '2',
      name: 'Camping Tent',
      description: '2-Person waterproof tent for outdoor camping',
      price: 199.99,
      imageUrl: 'https://example.com/tent.jpg',
      category: 'Equipment',
    ),
    Product(
      id: '3',
      name: 'Trekking Poles',
      description: 'Adjustable aluminum trekking poles',
      price: 45.99,
      imageUrl: 'https://example.com/poles.jpg',
      category: 'Accessories',
    ),
    Product(
      id: '4',
      name: 'Water Bottle',
      description: '1L insulated stainless steel water bottle',
      price: 24.99,
      imageUrl: 'https://example.com/bottle.jpg',
      category: 'Accessories',
    ),
  ];

  String _selectedCategory = 'All';

  List<Product> get filteredProducts {
    if (_selectedCategory == 'All') {
      return products;
    }
    return products.where((product) => product.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  _showCart(context);
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) => Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'All',
                  'Equipment',
                  'Accessories',
                ].map((category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                )).toList(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey[400],
                          ),
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
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<CartProvider>().addItem(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} added to cart'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: const Text('Add to Cart'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Consumer<CartProvider>(
        builder: (context, cart, child) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: cart.items.isEmpty
                    ? const Center(
                        child: Text('Your cart is empty'),
                      )
                    : ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                cart.removeItem(item);
                              },
                            ),
                          );
                        },
                      ),
              ),
              if (cart.items.isNotEmpty) ...[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement checkout
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Checkout functionality coming soon!'),
                        ),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
