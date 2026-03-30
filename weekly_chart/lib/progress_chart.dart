import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';

import 'chart_painter.dart';

class Score {
  late double value;
   late DateTime time;
  Score( this.value,
     this.time,
 );
   
}


const dayCount = 7;
final rng = math.Random();
const weekDays =["","Pzt","Sal","Çar","Per","Cum","Cmt","Paz"];

class ProgressChart extends StatefulWidget {
  const ProgressChart({Key? key});

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> with TickerProviderStateMixin {

  late List<Score> scores;
  late double min,max;
  late List<double> Y;
  late List<String> X;
   double _progress = 0.0;
  late Animation<double> animation;

@override
  void initState() {

      generateScore();

      findMinMax();
      createXYData();
      super.initState();
    /*  var controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        print(animation.value);
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
 */

  
  }


  void generateScore(){
  scores = List<Score>.generate(dayCount*3, (index){
      final y = rng.nextDouble() * 30;
      final d = DateTime.now().add(Duration(days: -dayCount + index));
      return Score(y, d);
    });
  }

  void findMinMax(){
    max = scores.map((e) => e.value).reduce(math.max);
    min = scores.map((e) => e.value).reduce((value, element) => math.min(value, element));
    print(min);
  }

  void createXYData(){
    Y = scores.map((p) =>p.value).toList();
    X = scores.map((p)=>"${weekDays[p.time.weekday]} ${p.time.day}").toList();
  }
ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 5),
           child: Container(
            color: Colors.black,
             child: SingleChildScrollView(
                controller: sc,
                scrollDirection: Axis.horizontal,
                child:SizedBox(
                    height: 270,
                  child:
                
                 Stack(
    children: [ // old code
       Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ChartDayLabels(
        leftPadding: 25,
        rightPadding: 10,
        children: X,
      ),
    ),
     SizedBox(
                  height:200,width:MediaQuery.of(context).size.width*3,
                   child: CustomPaint(
                     painter: ChartPainter(X,Y,min,max)),
                     ),
    ])
                 ),
             
      ),
           ),
         ),


      ElevatedButton(onPressed: (){
        print(sc.offset);
        sc.animateTo(sc.offset+20, duration: Duration(milliseconds: 800), curve: Curves.easeIn);
      }, child: Text("İleri"))

      ],
    );
  }


}


class ChartDayLabels extends StatelessWidget {
   ChartDayLabels(
      {Key? key, required this.leftPadding, required this.rightPadding,required this.children})
      : super(key: key);

  final double leftPadding;
  final double rightPadding;

  Offset labelOffset(int length, double i) {
    final segment = 1 / (length - 1);
 
    
    final offsetValue = (i - ((length - 1) / 2)) * segment;
      print(offsetValue);
    return Offset(offsetValue, 0);
  }
  List<String> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color:Colors.black
       /* gradient: LinearGradient(
          stops: [0.0, 1.0],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.white, Colors.white.withOpacity(0.85)],
        ),*/
      ),
      child: Padding(
        padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
          children: children
              .asMap()
              .entries
              .map(
                (entry) =>   SizedBox(
                      width: 90,
                      height:120,
                      child:Transform.translate(
                        offset: Offset(entry.value == children.first ? -10 : -45.0* entry.key -15,-0),
                        child: Transform.rotate(
                          angle: pi/6,
                          child: RotatedBox(
              quarterTurns: -1,
              child:Text(
                          entry.value+"12345",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFA9A9A9),
                          ),
                                              ),
                        )),
                    ),
                ),
               
              )
              .toList(),
        ),
      ),
    );
  }
}

