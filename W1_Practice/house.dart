class House {
  List<Room> rooms = [];
  List<Window> windows = [];
  final Roof roof;
  final Chimney? chimney;
  final Color color;
  final int numFloors;
  final int numDoors;
  final int numBalconies;

  House({required this.numFloors, required this.roof, this.chimney, required this.color, required this.numDoors,
    required this.numBalconies,
  });
}

enum Color {
  RED, GREEN, BLUE
}

class Room {
  final String name;
  final double area;

  Room({required this.name, required this.area});
}

class Window {
  final String type;
  final int num;

  Window({required this.type, required this.num});
}

class Roof {
  final String type;
  final double area;

  Roof({required this.type, required this.area});
}

class Chimney {
  final String material;
  final double height;

  Chimney({required this.material, required this.height});
}

void main() {
  Room livingRoom = Room(name: 'Living Room', area: 300);
  Room bedroom = Room(name: 'Bedroom', area: 200);

  Window window1 = Window(type: 'Awning', num: 2);
  Window window2 = Window(type: 'Casement', num: 2);

  Roof roof = Roof(type: 'Gable', area: 1200);

  Chimney chimney = Chimney(material: 'Brick', height: 15);

  House myHouse = House(numFloors: 2 , roof: roof, chimney: chimney, color: Color.BLUE, numBalconies: 1, numDoors: 2);

  myHouse.rooms.add(livingRoom);
  myHouse.rooms.add(bedroom);
  myHouse.windows.add(window1);
  myHouse.windows.add(window2);
}
