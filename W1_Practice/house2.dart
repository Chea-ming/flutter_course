class Roof {
  String type;
  Roof(this.type);
}

class Window {
  String color;
  int amount;
  Window(this.color, this.amount);
}

class Door {
  String placement;
  Door(this.placement);
}

class Room {
  String room;
  Room(this.room);
}

class House {
  String address;
  List<Room> rooms = [];
  List<Window> windows = [];
  List<Door> doors = [];
  House(this.address);
  void addRoom(Room newRoom) {
    rooms.add(newRoom);
  }

  void addWindow(Window newWindow) {
    this.windows.add(newWindow);
  }

  void addDoors(Door newDoor) {
    this.doors.add(newDoor);
  }
}

void main() {
  
}
