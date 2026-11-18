const canteenMenu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class LineItem {
  final String itemName;
  final double unitPrice;
  final int quantity;

  LineItem(this.itemName, this.unitPrice, this.quantity);

  double get lineTotal => unitPrice * quantity;
}

LineItem createLineItem(String itemName, int quantity) {
  final price = canteenMenu[itemName];
  
  if (price == null) {
    throw ArgumentError('Error: "$itemName" is not on the menu.');
  }
  
  return LineItem(itemName, price, quantity);
}

double computeGrandTotal(List<LineItem> cartItems) {
  return cartItems.fold(0.0, (acc, current) => acc + current.lineTotal);
}

void generateReceipt(List<LineItem> cartItems, {String? patron}) {
  final customerName = patron ?? 'Guest';
  print('Order for $customerName');

  for (var entry in cartItems) {
    String desc = '${entry.quantity} x ${entry.itemName}';
    String cost = entry.lineTotal.toStringAsFixed(2);
    print('${desc.padRight(18)}${cost.padLeft(7)}');
  }

  double subTotalAmount = computeGrandTotal(cartItems);
  print('${'Subtotal'.padRight(18)}${subTotalAmount.toStringAsFixed(2).padLeft(7)}');

  double finalPayable = subTotalAmount;

  if (subTotalAmount >= 300.0) {
    double discountVal = subTotalAmount * 0.10;
    finalPayable = subTotalAmount - discountVal;
    String discountStr = '-${discountVal.toStringAsFixed(2)}';
    print('${'Discount 10%'.padRight(18)}${discountStr.padLeft(7)}');
  }

  print('${'Total'.padRight(18)}${finalPayable.toStringAsFixed(2).padLeft(7)}');
}

void main() {
  var orderOne = [
    createLineItem('Adobo rice', 3),
    createLineItem('Iced tea', 1),
    createLineItem('Turon', 3),
  ];
  generateReceipt(orderOne);

  print('');

  var orderTwo = [
    createLineItem('Adobo rice', 1),
    createLineItem('Iced tea', 2),
  ];
  generateReceipt(orderTwo, patron: 'Juan');
}