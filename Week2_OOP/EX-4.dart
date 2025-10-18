enum OrderStatus {
  delivered,
  pickupAtStore,
  notDelivered
}

class Product {
  final String _name;
  final double _price;
  final int _quantity;

  Product({required String name, required double price, required int quantity})
      : _name = name,
        _price = price,
        _quantity = quantity;

  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
}

class Customer {
  final String _name;
  final int _phoneNumber;
  final int _age;
  final int _id;
  final String _address;

  Customer({
    required String name,
    required int phoneNumber,
    required int age,
    required int id,
    required String address,
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _age = age,
        _id = id,
        _address = address;

  String get name => _name;
  int get phoneNumber => _phoneNumber;
  int get age => _age;
  int get id => _id;
  String get address => _address;
}

class Order {
  final int _orderID;
  final Customer _customer;
  final List<Product> _items = [];
  OrderStatus _orderStatus;

  Order({
    required int orderID,
    required Customer customer,
    OrderStatus orderStatus = OrderStatus.notDelivered,
  })  : _orderID = orderID,
        _customer = customer,
        _orderStatus = orderStatus;
  
  int get orderID => _orderID;
  Customer get customer => _customer;
  List<Product> get items => _items;
  OrderStatus get orderStatus => _orderStatus;

  // Add product to order
  void addProduct(Product product, int quantity, {required OrderStatus status}) {
    _items.add(Product(name: product.name, price: product.price, quantity: quantity));
    _orderStatus = status;
  }

  // Calculate total amount
  double getTotalAmount() {
    double total = 0.0;
    for (var product in items) {
      total += product.price * product.quantity;
    }
    return total;
  }
}

class Shop {
  final String _name;
  final String _location;
  List<Customer> _customers = [];
  List<Product> _products = [];
  List<Order> _orders = [];

  Shop({required String name, required String location})
      : _name = name,
        _location = location;

  String get name => _name;
  String get location => _location;
  List<Customer> get customers => _customers;
  List<Product> get products => _products;
  List<Order> get orders => _orders;

  // create order for a customer
  Order createOrder(Customer customer, int orderID) {
    var newOrder = Order(orderID: orderID, customer: customer);
    _orders.add(newOrder);
    return newOrder;
  }

  String getOrderStatus(Order order) {
    switch (order.orderStatus) {
      case OrderStatus.delivered:
        return "Order #${order.orderID} for ${order.customer.name} has been delivered to ${order.customer.address}";
      case OrderStatus.pickupAtStore:
        return "Order #${order.orderID} for ${order.customer.name} is ready for pickup at $location";
      case OrderStatus.notDelivered:
        return "Order #${order.orderID} for ${order.customer.name} has not been processed yet";
    }
  }
}

void main() {
  Shop s1 = Shop(name: "Book Store", location: "CADT");

  // add products
  Product p1 = Product(name: "Pen", price: 1, quantity: 10);
  Product p2 = Product(name: "Pencil", price: 0.5, quantity: 20);
  Product p3 = Product(name: "Book", price: 10, quantity: 5);

  s1.products.addAll([p1, p2, p3]);

  Customer c1 = Customer(
    name: "Sok", 
    phoneNumber: 012345678, 
    age: 20, 
    id: 1, 
    address: "Preak Leap, Phnom Penh"
  );
  
  Customer c2 = Customer(
    name: "Dara", 
    phoneNumber: 07346274632, 
    age: 18, 
    id: 2, 
    address: "Angkor Wat, Siem Reap"
  );
  
  s1.customers.addAll([c1, c2]);

  // create order for customer 1
  Order order1 = s1.createOrder(c1, 1);
  order1.addProduct(p1, 2, status: OrderStatus.delivered);
  order1.addProduct(p3, 1, status: OrderStatus.delivered);

  print("Order ${order1.orderID} for ${c1.name}:");
  print("Total amount: \$${order1.getTotalAmount()}");
  print(s1.getOrderStatus(order1));
  print("");

  // create order for customer 2
  Order order2 = s1.createOrder(c2, 2);
  order2.addProduct(p2, 3, status: OrderStatus.pickupAtStore);

  print("Order ${order2.orderID} for ${c2.name}:");
  print("Total amount: \$${order2.getTotalAmount()}");
  print(s1.getOrderStatus(order2));
}