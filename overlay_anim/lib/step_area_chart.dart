import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:overlay_anim/ext.dart';


class StepAreaChart extends StatefulWidget {
  
  @override
  State<StepAreaChart> createState() => _StepAreaChartState();
}

class _StepAreaChartState extends State<StepAreaChart> 
 with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

 DateTime selectedDate = DateTime.now();

  List<ChartData> chartData = [];
  List<bool> isSelected = [false, true, false];
  (Offset?,int)? toolTip;

@override
  void initState() {
    super.initState();


      _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

       updateChartData();
  }

  void updateChartData() {

      if (isSelected[0]) {
        chartData = [
          ChartData('Mon', 12),
          ChartData('Tue', 12),
          ChartData('Wed', 15),
          ChartData('Thu', 50),
          ChartData('Fri', 50),
          ChartData('Sat', 30),
          ChartData('Sun', 30),
        ];
      } else if (isSelected[1]) {
        chartData = [
          ChartData('Week 1', 99),
          ChartData('Week 2', 80),
          ChartData('Week 3', 60),
          ChartData('Week 4', 90),
          ChartData('Week 4', 65),
          ChartData('Week 4', 55),
        ];
      } else if (isSelected[2]) {
        chartData = [
          ChartData('Jan', 52),
          ChartData('Feb', 40),
          ChartData('Mar', 50),
          ChartData('Apr', 40),
          ChartData('May', 35),
          ChartData('Jun', 55),
          ChartData('Jul', 22),
          ChartData('Aug', 10),
          ChartData('Sep', 35),
          ChartData('Oct', 35),
          ChartData('Nov', 60),
          ChartData('Dec', 30),
        ];
      }


     _controller.forward(from: 0.0);

  }

  void changeDate(int days) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: days));
    });
  }


 Widget row(){
  return  Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ToggleButtons(
                  fillColor: Colors.transparent,
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                      updateChartData();
                    });
                  },
                  children: [
                    for (int i = 0; i < isSelected.length; i++)
                      Container(
                        key: UniqueKey(),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: isSelected[i] ? Colors.blue.withOpacity(0.2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          ['Günlük', 'Haftalık', 'Aylık'][i],
                          style: const TextStyle(color: Colors.black),
                        ).paddingOnly(left: 15, right: 15, top: 5, bottom: 5),
                      ).paddingAll(5),
                  ],
                ),
              ),
            ],
          ),
        );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Area Chart'),
      ),
      body: Column(
        children: [
          row(),
          Center(
           
            child:  Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
                child: GestureDetector(
                       
                            child:AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
                             size:Size(MediaQuery.sizeOf(context).width -50,MediaQuery.sizeOf(context).width -50 ),
                      painter: StepAreaChartPainter(chartData: chartData,
                          onTap: (p0, p1){

                            setState(() {
                              this.toolTip = (p0,p1);
                            });


                           Timer(Duration(seconds:4), (){
                              setState(() {
                                this.toolTip = null;
                              });
                            });
                          },
                          toolTip: toolTip,
                          animationValue: _animation.value,
                      
                      ),
                    );
                    
                    },)
                            ),
              ),
            ),
              
          ),
        ],
      ),
    );
  }
}













class ChartData {
  ChartData(this.label, this.value);
  final String label;
  final double value;
}


class StepAreaChartPainter extends CustomPainter {
 final List<ChartData> chartData;
   double radius = 10;
  double max = 0;
  double yStep = 0;
  final path = Path();
   double animationValue;  
  Function(Offset,int)? onTap;

   Map<int, (Offset,Offset)> valueOfsets = {};

  (Offset?,int)? toolTip;

  StepAreaChartPainter({required this.chartData, this.radius = 10, this.onTap, this.toolTip, this.animationValue = 0});

  final yStepCount = 6;

   final factor = 5 ;
   final lineColor = Color.fromRGBO(92, 185, 166, 1);
   final fillColor = Color.fromRGBO(219, 229, 229, 1);




  @override
  void paint(Canvas canvas, Size size) {


 
  max = chartData.reduce((value, element) => value.value
     > element.value ? value : element).value;

    yStep = size.height / yStepCount; ;

    for (int i = 0; i < yStepCount + 1 ; i++) {
      final y = size.height - yStep * i;
        drawDashedLine(canvas: canvas, p1:Offset(25, y),
         p2:Offset(size.width, y) , dashWidth: 5, dashSpace: 3, paint: Paint()..color = Colors.grey);
        drawYTags(size, canvas, i, y);
    }


  
    drawLine(canvas,size);
    drawXValues(size,canvas);

    if(toolTip?.$1 != null){
        showToolTip(canvas,size);
    
    }
   
  }


  showToolTip(Canvas canvas,size){

 final Paint tooltipPaint = Paint()
        ..color = Colors.white
        
        ..style = PaintingStyle.fill;

      // Tooltip metni için TextPainter
      final TextSpan span = TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 12),
        text: chartData[toolTip!.$2].value.toString(),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      tp.layout();


      // Tooltip'in gölgesi için boyama
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..style = PaintingStyle.fill;

   final double arrowHeight = 10;    

  final width = 40.0;
  final height = 60.0;
  final radius = 10.0;
  final bottomOffset = 22.0;
  final offset = toolTip!.$1!;

  final Rect rect = Rect.fromLTRB(offset.dx - width ,offset.dy - height,offset.dx + width, offset.dy - bottomOffset);


 
  final Path arrowPath = Path()
      ..moveTo(offset.dx + 7, rect.bottom )
      ..lineTo(offset.dx , rect.bottom  + arrowHeight)
      ..lineTo(offset.dx - 7, rect.bottom )
      ..lineTo(offset.dx - (width - radius), offset.dy - bottomOffset)
      ..quadraticBezierTo(offset.dx - width , offset.dy - bottomOffset, offset.dx - width , offset.dy - (bottomOffset + radius))
      ..lineTo(offset.dx - width , offset.dy - (height - radius))
      ..quadraticBezierTo(offset.dx - width , offset.dy - height, offset.dx - (width - radius), offset.dy - height)
      ..lineTo(offset.dx +(width - radius), offset.dy - height)
      ..quadraticBezierTo(offset.dx + width, offset.dy - height, offset.dx + width, offset.dy - (height - radius))
      ..lineTo(offset.dx + width, offset.dy - width)
       ..quadraticBezierTo(offset.dx + width, rect.bottom, offset.dx +(width - radius), rect.bottom)

      ..close();


     // canvas.drawShadow(Path()..addRRect(rRect), Colors.black, 3, true);
      canvas.drawShadow(arrowPath,  Colors.grey.withOpacity(.5), 4, true);
      canvas.drawPath(arrowPath, tooltipPaint);

     // canvas.drawRRect(RRect.fromRectXY(rect,10,10), Paint()..color = Colors.white);

      canvas.drawLine(Offset(offset.dx, size.height), Offset(offset.dx, offset.dy),
       Paint()..color =lineColor
       ..strokeWidth = 2
       
       );

       // Tooltip noktası
       canvas.drawCircle(offset, 8, Paint()..color = Colors.white);
       canvas.drawCircle(offset, 6, Paint()..color = lineColor);


       // Tooltip metni

      tp.paint(
        canvas,
        Offset(
          offset.dx - tp.width / 2,
          offset.dy - 50,
        ),
      );
       
  } 









  drawYTags(size,canvas, int i, y){

     final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '${((max  * 1.2) / yStepCount * i ).floor()}',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(-10, y - textPainter.height / 2));
  }

List<double> previousYs = [];


  drawLine(canvas,size){
      final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

  
    final fillPath = Path();
     double stepWidth = (size.width - 25) / (chartData.length );

 
   

    for (int i = 0; i < chartData.length ; i++) {
      final value = chartData[i].value;
      final previous = i == 0 ? 0 : chartData[i - 1].value;
      final next = i == chartData.length - 1 ? value : chartData[i + 1].value;

      final x = i * stepWidth + 25;
     
   
      var y = size.height -  ((value  / (max  * 1.2 )) * size.height) * animationValue;

    
      if (i == 0) {
      
        indexEqualsZero(size, x, y, stepWidth, fillPath, value, next, i);
      } else {
      
      var yFactor = 0;

      if (i < chartData.length -1 ) {
        yFactor = next > value ? -factor : factor;
      }
  

         if(value == previous){
      
          yFactor = valuEqualsPrevious(i, x, stepWidth, y, fillPath, yFactor, next, value);

         } else if(value > previous){

          yFactor = valueBiggerThanPrevious(value, previous, yFactor, x, y, fillPath, stepWidth, next, i, size);

            
         
        }else if(value < previous){

            valueSmallerThanPrevious(i, x, y, size, fillPath, yFactor, stepWidth, value, next);
          
        }
     


       // path.lineTo(x + stepWidth - factor, y);

       
       

        /*fillPath.lineTo(x , y + (chartData[i].value > chartData[i-1].value ? factor : -factor));
        fillPath.quadraticBezierTo(x, y, x + factor, y);
        fillPath.lineTo(x + stepWidth - factor, y);
        if(i < chartData.length -1){
          fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor);
        }else{
          fillPath.lineTo(x + stepWidth, y);
        }*/
       
         valueOfsets[i] = (Offset(x, y),Offset(
        
          x + stepWidth, 
         y));

        if(previousYs.length< chartData.length && animationValue == 1){
         previousYs.add(y);
        }
      }

    }

    fillPath.lineTo(size.width , size.height);
    fillPath.close();

    final fillPaint = Paint()
     ..shader = LinearGradient(
        colors: [fillColor, fillColor.withOpacity(.2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  void indexEqualsZero(size, double x, y, double stepWidth, Path fillPath, double value, double next, int i) {
     path.moveTo(25, size.height);
           
    path.lineTo(x, y+factor);
    
    path.quadraticBezierTo(x, y, x +factor, y);
    path.lineTo(x + stepWidth  - factor, y);
           
     fillPath.moveTo(x, size.height);
     fillPath.lineTo(x, y+factor);
     fillPath.quadraticBezierTo(x, y, x +factor, y);
     fillPath.lineTo(x + stepWidth  - factor, y);
    
      if(value == next )
      {
         path.lineTo(x + stepWidth, y);
         fillPath.lineTo(x + stepWidth, y);
    
      }else if (value < next){
    
      
       path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y -factor);
       fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y -factor);
    
      } else{
    
      
       path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y +factor);
       fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y +factor);
    
      } 
    
    
    valueOfsets[i] = (Offset(25, y),Offset( stepWidth +25, y));
  }

  int valuEqualsPrevious(int i, double x, double stepWidth, y, Path fillPath, int yFactor, double next, double value) {
     if(i == chartData.length -1){
             
        path.lineTo(x +stepWidth, y);
        fillPath.lineTo(x + stepWidth, y);
    
        }else{
          
      
       yFactor = next > value ? -factor : factor;
      
       if((value - next).abs() < radius && value != next){
          yFactor = ((value - next)).floor();
    
          path.lineTo(x + (stepWidth - yFactor.abs()) , y );
          fillPath.lineTo(x + (stepWidth - yFactor.abs()) , y );
      
        }else{
          path.lineTo(x + stepWidth - factor , y );
          fillPath.lineTo(x + stepWidth - factor , y );
      
        }
       
         path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor);
     fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor);
       
             }
    
    return yFactor;
  }

  void valueSmallerThanPrevious(int i, double x, y, size, Path fillPath, int yFactor, double stepWidth, double value, double next) {
    
    if(i == chartData.length-1){
     
        path.lineTo(x, y - factor);
        
        path.quadraticBezierTo(x, y, x + factor, y);
       
        path.lineTo(size.width, y);
        
    
         fillPath.lineTo(x, y - factor);
         fillPath.quadraticBezierTo(x, y, x + factor, y);
         fillPath.lineTo(size.width, y);
    
    } else {
        
       path.lineTo(x, y - factor); // dik çizgiyi çiziyor
            
       path.quadraticBezierTo(x, y, x + yFactor.abs(), y);
       path.lineTo(x + stepWidth - factor, y);
    
    
        fillPath.lineTo(x, y - factor);
    
        fillPath.quadraticBezierTo(x, y, x + yFactor.abs(), y);
    
        fillPath.lineTo(x + stepWidth - factor, y);
       
       if(value == next){
    
          path.lineTo(x + stepWidth, y);
          fillPath.lineTo(x + stepWidth, y);
       }else{
        path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor);
       fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor);
       }
       
    }
    
  }

  int valueBiggerThanPrevious(double value, num previous, int yFactor, double x, y, Path fillPath, double stepWidth, double next, int i, size) {
    if((value - previous).abs() < radius){
       yFactor = ((value - previous)).floor();
       path.lineTo(x, y + yFactor.abs());
       
       path.quadraticBezierTo(x, y, x + yFactor.abs(), y);
       fillPath.lineTo(x, y + yFactor.abs());
       fillPath.quadraticBezierTo(x, y, x + yFactor.abs(), y);
     
       
     } else{
    
         
       path.lineTo(x, y + factor);
       path.quadraticBezierTo(x, y, x + factor, y);
       fillPath.lineTo(x, y + factor);
       fillPath.quadraticBezierTo(x, y, x + factor, y);
    
     }
    
     path.lineTo(x + stepWidth - factor, y);
     fillPath.lineTo(x + stepWidth - factor, y);
    
     yFactor = value > previous ? -factor : factor;
      
      if(value < next){
    
       path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y - yFactor.abs());
       fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y - yFactor.abs());
      }else if(value > next){
     
        path.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor.abs());
         fillPath.quadraticBezierTo(x + stepWidth, y, x + stepWidth, y + yFactor.abs());
        
              
      }
    
      if(i == chartData.length -1){
        path.lineTo(size.width, y);
         fillPath.lineTo(size.width, y);
      }
    
                
    return yFactor;
  }


  drawXValues(size,canvas){
     for (int i = 0; i < chartData.length; i++) {
      final double x = i * (size.width - 25) / (chartData.length - 1);
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: chartData[i].label,
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2 + 25, size.height + 5));
    }
  }

void drawDashedLine(
      {required Canvas canvas,
      required Offset p1,
      required Offset p2,
      required int dashWidth,
      required int dashSpace,
      required Paint paint}) {
  // Get normalized distance vector from p1 to p2
  var dx = p2.dx - p1.dx;
  var dy = p2.dy - p1.dy;
  final magnitude = sqrt(dx * dx + dy * dy);
  dx = dx / magnitude;
  dy = dy / magnitude;

  // Compute number of dash segments
  final steps = magnitude ~/ (dashWidth + dashSpace);

  var startX = p1.dx;
  var startY = p1.dy;

  for (int i = 0; i < steps; i++) {
    final endX = startX + dx * dashWidth;
    final endY = startY + dy * dashWidth;
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    startX += dx * (dashWidth + dashSpace);
    startY += dy * (dashWidth + dashSpace);
  }
}


@override
bool hitTest(Offset position) {
    // _path - is the same one we built in paint() method;
 
    valueOfsets.forEach((key, value) {
      if (isPointInPath(value.$1, value.$2, position)) {
        print(chartData[key].value);
        print('Tapped on $key');
        onTap?.call(Offset(position.dx, value.$1.dy),key);

      }
    });
    return path.contains(position);
}

bool isPointInPath(Offset start, Offset end, Offset point) {
  return point.dx >= start.dx && point.dx <= end.dx ;
}
  @override
  bool shouldRepaint(covariant StepAreaChartPainter oldDelegate) {
    return true;
  }



}


//0001 0001 0000 535800840000 0008 0001 0013 
//0000 000F 00FB 536F757263655F3000 
//0000 000B 00224 16E7430000000000E00100000000000000000 
//0000 0008 0012 0003 
//0000 0008 000F 000A 
//0000 0010 0011C7F5FB3119D81D98BF0000000008007AFDF0000000080050000C00000012004DE200341400F40301BA1EED81