enum ChainInfoStatus {
  complete,
  active,
  notStarted,
}

enum ChainPosition { start, middle, end }

class Position {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  const Position({this.top, this.bottom, this.left, this.right});
}

