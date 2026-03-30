import 'package:flutter/material.dart';
import 'package:weekly_chart/progress_chart.dart';



void main() {

 
  runApp(MyApp());
}










class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Week Chart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Example(),
    );
  }
}






class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  static const _shapeConfig = _SketchShapeConfig(
    baseLineYFactor: 1,

    bottomFlatStartXFactor: 0.19,
    bottomFlatEndXFactor: 0.81,

    leftBottomCubicControl1: Offset(0.05, 1), // alt kıvrımın kontrol noktası 1
    leftBottomCubicControl2: Offset(0.06, 1),

    leftBottomArcStart:
        Offset(0.01, 0.575), // sol ortanın alt kıvrımının başlangıç noktası

    leftSideCubicControl1:
        Offset(-0.022, 0.35), // sol orta kıvrımın kontrol noktası 1
    leftSideCubicControl2:
        Offset(0.14, 0.005), // sol orta kıvrımın kontrol noktası 2

    leftTopArcEnd:
        Offset(0.175, -0.02), // sol ortanın üst kıvrımının bitiş noktası

    rightTopArcEnd: Offset(0.825, -0.02),
    rightBottomArcEnd: Offset(0.99, 0.575),

    rightSideCubicControl1: Offset(0.86, 0.005),
    rightSideCubicControl2: Offset(1.022, 0.35),

    rightBottomCubicControl1: Offset(0.94, 1),
    rightBottomCubicControl2: Offset(0.95, 1),

    topArcRadiusXFactor: 0.34,
    topArcRadiusYFactor: 0.088,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F1E8),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: AspectRatio(
              aspectRatio: 2.8,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: CustomPaint(
                  painter: _SketchShapePainter(config: _shapeConfig),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SketchShapePainter extends CustomPainter {
  const _SketchShapePainter({required this.config});

  final _SketchShapeConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    final baselineY = size.height * config.baseLineYFactor;
    final flatStart =
        Offset(size.width * config.bottomFlatStartXFactor, baselineY);
    final flatEnd = Offset(size.width * config.bottomFlatEndXFactor, baselineY);
    final leftBottomArcStart = config.resolve(size, config.leftBottomArcStart);
    final leftTopArcEnd = config.resolve(size, config.leftTopArcEnd);
    final rightTopArcEnd = config.resolve(size, config.rightTopArcEnd);
    final rightBottomArcEnd = config.resolve(size, config.rightBottomArcEnd);

    final path = Path()
      ..moveTo(flatStart.dx, flatStart.dy)
      ..cubicTo(
        size.width * config.leftBottomCubicControl1.dx,
        size.height * config.leftBottomCubicControl1.dy,
        size.width * config.leftBottomCubicControl2.dx,
        size.height * config.leftBottomCubicControl2.dy,
        leftBottomArcStart.dx,
        leftBottomArcStart.dy,
      )
      ..cubicTo(
        size.width * config.leftSideCubicControl1.dx,
        size.height * config.leftSideCubicControl1.dy,
        size.width * config.leftSideCubicControl2.dx,
        size.height * config.leftSideCubicControl2.dy,
        leftTopArcEnd.dx,
        leftTopArcEnd.dy,
      )
      ..arcToPoint(
        rightTopArcEnd,
        radius: Radius.elliptical(
          size.width * config.topArcRadiusXFactor,
          size.height * config.topArcRadiusYFactor,
        ),
      )
      ..cubicTo(
        size.width * config.rightSideCubicControl1.dx,
        size.height * config.rightSideCubicControl1.dy,
        size.width * config.rightSideCubicControl2.dx,
        size.height * config.rightSideCubicControl2.dy,
        rightBottomArcEnd.dx,
        rightBottomArcEnd.dy,
      )
      ..cubicTo(
        size.width * config.rightBottomCubicControl1.dx,
        size.height * config.rightBottomCubicControl1.dy,
        size.width * config.rightBottomCubicControl2.dx,
        size.height * config.rightBottomCubicControl2.dy,
        flatEnd.dx,
        flatEnd.dy,
      )
      ..lineTo(flatStart.dx, flatStart.dy)
      ..close();

    final fillPaint = Paint()
      ..color = const Color(0xFFECE2CE)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF8A4C42)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final startPointPaint = Paint()..color = const Color(0xFFD2565C);

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
    canvas.drawCircle(flatStart, 6, startPointPaint);
  }

  @override
  bool shouldRepaint(covariant _SketchShapePainter oldDelegate) {
    return oldDelegate.config != config;
  }
}

class _SketchShapeConfig {
  const _SketchShapeConfig({
    required this.baseLineYFactor,
    required this.bottomFlatStartXFactor,
    required this.bottomFlatEndXFactor,
    required this.leftBottomArcStart,
    required this.leftTopArcEnd,
    required this.rightTopArcEnd,
    required this.leftBottomCubicControl1,
    required this.leftBottomCubicControl2,
    required this.leftSideCubicControl1,
    required this.leftSideCubicControl2,
    required this.rightSideCubicControl1,
    required this.rightSideCubicControl2,
    required this.rightBottomArcEnd,
    required this.rightBottomCubicControl1,
    required this.rightBottomCubicControl2,
    required this.topArcRadiusXFactor,
    required this.topArcRadiusYFactor,
  });

  final double baseLineYFactor;
  final double bottomFlatStartXFactor;
  final double bottomFlatEndXFactor;
  final Offset leftBottomArcStart;
  final Offset leftTopArcEnd;
  final Offset rightTopArcEnd;
  final Offset leftBottomCubicControl1;
  final Offset leftBottomCubicControl2;
  final Offset leftSideCubicControl1;
  final Offset leftSideCubicControl2;
  final Offset rightSideCubicControl1;
  final Offset rightSideCubicControl2;
  final Offset rightBottomArcEnd;
  final Offset rightBottomCubicControl1;
  final Offset rightBottomCubicControl2;
  final double topArcRadiusXFactor;
  final double topArcRadiusYFactor;

  Offset resolve(Size size, Offset factor) {
    return Offset(size.width * factor.dx, size.height * factor.dy);
  }
}
