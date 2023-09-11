import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ApiService.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Store App'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                CarouselSlider(
                  items: snapshot.data!.map((product) {
                    return Image.network(product.image, fit: BoxFit.cover);
                  }).toList(),
                  options: CarouselOptions(height: 200.0),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          0.9, // Adjust this value to control item size
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to product details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                product: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Image.network(
                                snapshot.data![index].image,
                                height: 350,
                                width: 350,
                              ),
                              Text(snapshot.data![index].title),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text('Error loading products');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(product.image),
            Text(product.title),
            Text('\$${product.price.toStringAsFixed(2)}'),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
