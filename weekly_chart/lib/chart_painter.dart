import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ChartPainter extends CustomPainter {
 late double min,max;
  late List<double> Y;
  late List<String> X;


  ChartPainter( this.X,this.Y, this.min,this.max);
  
  static double border = 0;
  double titleOffset = 22;

  final circlePaint = Paint()
  ..strokeWidth = 1
  ..style = PaintingStyle.stroke
  ..color = Colors.white;

final circleFillPaint = Paint()

  ..style = PaintingStyle.fill
  ..color = Colors.black;



final outlinePaint = Paint()
  ..strokeWidth = 3
  ..style = PaintingStyle.stroke
  ..color = Colors.white;
  
 
final gridPaint = Paint()
  ..strokeWidth = 1
  ..style = PaintingStyle.stroke
  ..color = Colors.white24;
  
 
late double height ;
late double topPadding = 10;

@override
  void paint(Canvas canvas, Size size) {

    // compute the drawable chart width and height

 final drawableWidth = (size.width - 2.0 * border );

final wd = 40.0; //drawableWidth / this.X.length.toDouble();
height = size.height *0.95;
final width = drawableWidth;
// escape if values are invalid
if (height <= 0.0 || width <= 0.0) return;
if (max - min < 1.0e-6) return;

final hr = height / (max - min); // height per unit value

final left = border;
final top = border;
final c = Offset(left + wd / 2.0, top + height / 2.0);
 //_drawOutline(canvas, c, wd, height);
  //calculateHorizontalLines();
  final points = _computePoints(c,wd,height,hr);

  final path = _computePaths(points,wd,false,size.width);
 
  final labels = _computePointLabels();

  canvas.drawPath(path, outlinePaint);

  drawYLabels(canvas, labels, points, wd,top);

   //final c1 = Offset(c.dx-(wd/8), height*1.09);

   //drawXLabels(canvas, c1, wd*2);

    final p = Paint()..style = PaintingStyle.fill
    ..shader = ui.Gradient.linear(
    Offset.zero,
    Offset(0.0, size.height),
    [
      Colors.white.withOpacity(0.17),
      Colors.white.withOpacity(0.08),
    ],
    );
    final pth = _computePaths(points,wd,true,size.width);
     canvas.drawPath(pth, p);
     drawDataPoints(points, labels, canvas, c, wd);
  }

/*
  //? horizontal çizgilerin max ve minimum değerlerini buluyoruz.

  void calculateHorizontalLines(){
  maxLineValue = max.ceil();
  int difference = maxLineValue - min.floor();
  int toSubtract = (numberOfLines) - (difference % (numberOfLines));
  if (toSubtract == numberOfLines) {
    toSubtract = 0;
  }
  minLineValue = min.floor() - toSubtract;

  }


void _drawHorizontalLinesAndLabels(Canvas canvas, Size size, int minLineValue, int maxLineValue) {
  final paint = new Paint()
    ..color = Colors.grey;
  int lineStep = _calculateHorizontalLineStep(maxLineValue, minLineValue);
  double offsetStep = _calculateHorizontalOffsetStep;
  for (int line = 0; line < numberOfLines; line++) {
    double yOffset = line * offsetStep;
    _drawHorizontalLabel(maxLineValue, line, lineStep, canvas, yOffset);
    _drawHorizontalLine(canvas, yOffset, size, paint);
  }


}

/// e.g. between every line should be 100px space.
double get _calculateHorizontalOffsetStep {
    return height / (numberOfLines-1);
}

  int _calculateHorizontalLineStep(int maxLineValue, int minLineValue) {
 return   (maxLineValue)  ~/ (numberOfLines-1);
}



void _drawHorizontalLine(ui.Canvas canvas, double yOffset, ui.Size size, ui.Paint paint) {
  canvas.drawLine(
    new Offset(leftOffsetStart,  5+ yOffset),
    new Offset(size.width, 5+yOffset),
    paint,
  );
}

void _drawHorizontalLabel(int maxLineValue, int line, int lineStep, ui.Canvas canvas, double yOffset) {
 ui.Paragraph paragraph = _buildParagraphForLeftLabel(maxLineValue, line, lineStep);
 canvas.drawParagraph(paragraph,  Offset(0.0, yOffset));
}

///Builds text paragraph for label placed on the left side of a chart (weights)
ui.Paragraph _buildParagraphForLeftLabel(int maxLineValue, int line, int lineStep) {
  ui.ParagraphBuilder builder = new ui.ParagraphBuilder(
    new ui.ParagraphStyle(
      fontSize: 10.0,
      textAlign: TextAlign.right,
    ),
  )
    ..pushStyle( ui.TextStyle(color: Colors.white))
    ..addText((maxLineValue - line * lineStep).toString());
  final ui.Paragraph paragraph = builder.build()
    ..layout( ui.ParagraphConstraints(width: leftOffsetStart - 4));
  return paragraph;
}

*/

  drawXLabels(canvas, Offset c,wd){
TextStyle style = TextStyle(color:Colors.white,fontSize: 12);

    X.forEach((xp) { 
        canvas.save();
        canvas.translate(c.dx, c.dy);
        canvas.rotate(-pi/4);
        canvas.translate(-c.dx, -c.dy);
        drawTextCentered(canvas, c+Offset(-wd/4, 0) , xp, wd, style);
        canvas.restore();
        canvas.drawLine(Offset(c.dx , c.dy),   Offset(c.dx + wd, c.dy), gridPaint);
        c+= Offset(wd, 0);
    });
  }

void drawYLabels(Canvas canvas , List<String> labels,List<Offset> points , double wd,double top) {
 TextStyle style = TextStyle(color:Colors.white60,fontSize: 11,);
 var i = 0;
  labels.forEach((l) {
    final dp = points[i];
    final dy = (dp.dy -15)< top? 15.0:-15.0;
     final ly = dp +Offset(0, dy);
     drawTextCentered(canvas, ly  , l, wd,style);
     i++;

  });
}
void drawDataPoints(List<Offset> points, List<String> labels, Canvas canvas, Offset c, double wd) {
 // canvas.drawLine(Offset(c.dx-15,height-25),   Offset(c.dx-15,-height), gridPaint);

  for(int i = 0; i<points.length; i++){
     final p = points[i];

     canvas.drawLine(Offset(c.dx,height*1.085),   Offset(c.dx,p.dy), gridPaint);

     canvas.drawCircle(p, 4, circleFillPaint);
     canvas.drawCircle(p, 4, circlePaint);
     c += Offset(wd, 0);
   }
}

// 
 void _drawOutline(Canvas canvas, Offset c, double width, double height) {
     Y.forEach((p) { 
      final rect = Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect, outlinePaint);
      c+= Offset(width, 0);
     });
  }
  
  List<Offset> _computePoints(Offset c, double width, double height, double hr) {
    List<Offset> points = [];
    Y.forEach((yp) { 
       // final yy = maxLineValue - (yp - minLineValue) * hr;
       final yy = yp  / max ;
       final dp = Offset(c.dx, height - (yy * height -topPadding));
       
        
        points.add(dp);
      c += Offset(width, 0);
    });
    return points;
  }
  
  _computePaths(List<Offset> points,double width,bool close,double bla) {
    Path path = Path();

  
   for(int i = 0; i<points.length; i++){
    final p = points[i];
   if(p.dx < bla ){
    if(i==0){
      path.moveTo(p.dx,p.dy);
    }else{

   
      final previous = points[i-1];
     
      
       // Offset prvC = Offset((previous.dx + p.dx)/2 , (previous.dy+p.dy)/2 );
        // Offset nextC = Offset((next.dx + p.dx)/2 ,(next.dy+p.dy)/2);

          final sw = width/3;
         

           // path.lineTo(prvC.dx, prvC.dy);

             path.cubicTo(previous.dx+sw,
                previous.dy ,
                previous.dx + 2*sw,
                 p.dy,
                 p.dx,
                 p.dy );


        // path.cubicTo(prvC.dx, prvC.dy ,p.dx,p.dy , nextC.dx, nextC.dy);
      
      /*if(previous.dy<p.dy && next.dy<p.dy){
        final prvC = Offset((previous.dx + p.dx)/2 , (previous.dy+p.dy)/2 );
        final nextC = Offset((next.dx + p.dx)/2 ,(next.dy+p.dy)/2);
          path.lineTo(prvC.dx, prvC.dy);
           path.cubicTo(previous.dx, previous.dy ,p.dx,p.dy + (p.dy-previous.dy), next.dx, next.dy);
      
      }else if(previous.dy > p.dy && next.dy > p.dy){

          // final prvC = Offset((previous.dx + p.dx)/2 , (previous.dy+p.dy)/2 );
       //final nextC = Offset((next.dx + p.dx)/2 ,(next.dy+p.dy)/2);
      //path.lineTo(prvC.dx, prvC.dy);
      path.cubicTo(previous.dx, previous.dy,p.dx,p.dy - (previous.dy-p.dy), next.dx, next.dy,);

      }*/
      

    }
   }
   }
   if(close){
    path.lineTo(points.last.dx,  height*1.09 );
    path.lineTo(points.first.dx, height*1.09);
   }
     


   return path;
  }

  List<String> _computePointLabels() {
    return Y.map((yp) => "${yp.toStringAsFixed(1)}").toList();
  }

TextPainter measureText(String s,TextStyle style,double maxWidth,TextAlign align){
  final span = TextSpan(text: s, style:style);
  final tp = TextPainter(text:span,maxLines: 1,textAlign:align,textDirection: TextDirection.ltr);
  tp.layout(minWidth: 0,maxWidth: maxWidth);
  return tp;
}

 void drawTextCentered(Canvas canvas, Offset c, String l, double maxWidth,TextStyle style) {
  final tp = measureText(l, style, maxWidth, TextAlign.center);
  final offset = c + Offset(-tp.width/2, -tp.height/2);
  tp.paint(canvas, offset);
 }
  






  @override
  bool shouldRepaint(covariant ChartPainter oldDelegate) {
     return false;
    
  }
  
  

 
}
