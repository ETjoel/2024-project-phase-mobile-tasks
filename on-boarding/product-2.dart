import 'dart:io';

class Product {
  final String name;
  final String description;
  final double price;

  Product(this.name, this.description, this.price);
}

class ProductManager {
  Map<String, Product> products = {};

  bool addNewProduct() {
    print('Enter the name: ');
    String name = stdin.readLineSync() ?? '';

    print('Enter the description: ');
    String description = stdin.readLineSync() ?? '';

    print('Enter the price: ');
    String temp = stdin.readLineSync() ?? '';

    double price = double.tryParse(temp) ?? 0;
    if (name == '' || description == '' || price == 0) {
      print('Please enter valid data');
      return false;
    }
    products[name] = Product(name, description, price);

    return true;
  }

  void viewAllProducts() {
    print('List of all products: ');
    products.forEach((key, value) {
      print('Product Name: $key');
      print('Product Description: ${value.description}');
      print('Product Price: ${value.price}');
      print('-------------------');
    });
  }

  void viewSingleProduct() {
    print('please enter product name: ');
    String productName = stdin.readLineSync() ?? '';

    if (products.containsKey(productName)) {
      print('Product Name: $productName');
      print('Product Description: ${products[productName]?.description}');
      print('Product Price: ${products[productName]?.price}');
    } else {
      print('Product not found');
    }
  }

  bool editProduct() {
    print('please enter product name: ');
    String productName = stdin.readLineSync() ?? '';

    if (products.containsKey(productName)) {
      print('Enter new name: ');

      String newName = stdin.readLineSync() ?? '';
      print('Enter new description: ');
      String newDescription = stdin.readLineSync() ?? '';
      print('Enter new price: ');
      String temp = stdin.readLineSync() ?? '';
      double newPrice = double.tryParse(temp) ?? 0;
      if (newName == '' || newDescription == '' || newPrice == 0) {
        print('Please enter valid data');
        return false;
      }
      products[newName] = Product(newName, newDescription, newPrice);
      products.remove(productName);
      return true;
    } else {
      print('Product not found');
      return false;
    }
  }

  bool deleteProduct() {
    print('please enter product name: ');
    String productName = stdin.readLineSync() ?? '';

    if (products.containsKey(productName)) {
      products.remove(productName);
      print('Product deleted successfully');
      return true;
    } else {
      print('Product not found');
      return false;
    }
  }
}

void main() {
  ProductManager productManager = ProductManager();
  print('****************************************************');
  print('Welcome to Some random command-line e-commerce app');
  print('****************************************************');

  while (true) {
    print('');
    print('****************************************************');
    print('Enter 1 to add new product');
    print('Enter 2 to view all products');
    print('Enter 3 to view single product');
    print('Enter 4 to edit product');
    print('Enter 5 to delete product');
    print('Enter 6 to exit');
    print('****************************************************');
    print('');
    String? input = stdin.readLineSync();
    if (input == '1') {
      productManager.addNewProduct();
    } else if (input == '2') {
      productManager.viewAllProducts();
    } else if (input == '3') {
      productManager.viewSingleProduct();
    } else if (input == '4') {
      productManager.editProduct();
    } else if (input == '5') {
      productManager.deleteProduct();
    } else if (input == '6') {
      break;
    } else {
      print('Invalid input');
    }
  }
}
