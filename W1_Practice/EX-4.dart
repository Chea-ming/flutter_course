void main() {
  // Map of pizza prices
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  // Example order
  const orders = ['margherita', 'pepperoni', 'pineapple'];

  // Your code
  double cost = 0;
  List<String>? notOnMenu = [];

  for(String order in orders){
    bool onMenu = false;
    pizzaPrices.forEach((key, value) {
      if(order == key){
        cost += value;
        onMenu = true;
      }
    });
    if(onMenu == false) {
      notOnMenu.add(order);
    }
  }

  print('Total: \$$cost');
  print('[' + notOnMenu.join(', ') + ']: not on the menu');
}
