enum Direction { north, east, south, west }
 
void main() {
  // Initial position {7, 3} and facing north
  int x = 7;
  int y = 3;
  Direction direction = Direction.north;

  // Example instruction sequence
  const instructions = "RAALAL";

  // Process the instructions and get the final position and direction
  for (var command in instructions.split('')) {
    if (command == 'R') {
      direction = turnRight(direction);
    } else if (command == 'L') {
      direction = turnLeft(direction);
    } else if (command == 'A') {
      var newPos = advance(x, y, direction);
      x = newPos['x']!;
      y = newPos['y']!;
    }
  }

  // Print the final position and direction
  print("Final position:  x = $x , y = $y");
  print("Facing:  ${direction.name.toUpperCase()}");
}

Direction turnRight(Direction direction){
  switch (direction){
    case Direction.north:
      return Direction.east;
    case Direction.east:
      return Direction.south;
    case Direction.south:
      return Direction.west;
    case Direction.west:
      return Direction.north;
  }
}

Direction turnLeft(Direction direction){
  switch (direction){
    case Direction.north:
      return Direction.west;
    case Direction.west:
      return Direction.south;
    case Direction.south:
      return Direction.east;
    case Direction.east:
      return Direction.north;
  }
}

Map<String, int> advance(int x, int y, Direction direction) {
  switch (direction) {
    case Direction.north:
      y += 1;
      break;
    case Direction.south:
      y -= 1;
      break;
    case Direction.east:
      x += 1;
      break;
    case Direction.west:
      x -= 1;
      break;
  }
  return {'x': x, 'y': y};
}

