// features/main/home/layout/path_layout_engine.dart
// THUẦN DART — test được không cần Flutter. Layout KHÔNG phải business rule
// nên nó ở tầng Presentation, không đặt vào Domain.

class PathLayoutEngine {
  const PathLayoutEngine({this.firstDoorStartSide = -1});

  /// -1: cửa đầu rẽ trái trước; +1: rẽ phải trước.
  final int firstDoorStartSide;

  /// [doorSizes]: số node của từng cửa theo thứ tự toàn cục (xuyên section).
  /// Trả về List<List<int>> song song: offset theo đơn vị sóng
  /// (0 = O, ±1 = A, ±2 = B).
  List<List<int>> build(List<int> doorSizes) {
    final result = <List<int>>[];
    var side = firstDoorStartSide;
    for (final n in doorSizes) {
      final offsets = _buildDoor(n, side);
      result.add(offsets);
      side = _nextStartSide(offsets, fallback: -side);
    }
    return result;
  }

  /// Luật biên: cuối cửa đi trái→phải thì đầu cửa kế đi phải→trái.
  int _nextStartSide(List<int> offsets, {required int fallback}) {
    if (offsets.length < 2) return fallback;
    final endDir = (offsets.last - offsets[offsets.length - 2]).sign;
    return endDir == 0 ? fallback : -endDir;
  }

  /// Một cửa luôn bắt đầu và kết thúc tại O.
  List<int> _buildDoor(int n, int side) {
    if (n <= 0) return const [];
    final out = <int>[0];
    var s = side;
    var remaining = n - 1;
    while (remaining > 0) {
      if (remaining >= 4) {
        out.addAll([s, s * 2, s, 0]); // nửa sóng trọn: A B A O
        s = -s;
        remaining -= 4;
      } else if (remaining == 3) {
        out.addAll([s, s, 0]); // nửa sóng cụt
        remaining = 0;
      } else if (remaining == 2) {
        out.addAll([s, 0]);
        remaining = 0;
      } else {
        out.add(0);
        remaining = 0;
      }
    }
    return out;
  }

  /// Đổi đơn vị sóng → pixel.
  static double toDx(int unit, double a, double b) =>
      unit == 0 ? 0.0 : (unit.abs() == 1 ? a : b) * unit.sign;
} 