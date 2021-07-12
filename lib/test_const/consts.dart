/*
 * @LastEditors:  
 * @LastEditTime: 2021-07-08 12:07:02
 * @FilePath: /habit_app/lib/test_const/consts.dart
 */
import 'package:flutter/material.dart';

class Consts{
  static final List<Habit> habitList = [
     new Habit(Colors.blue, "content1", "http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg",8),
     new Habit(Colors.yellow, "content2", "http://yanxuan.nosdn.127.net/8b30eeb17c831eba08b97bdcb4c46a8e.png",3),
     new Habit(Colors.green, "content3", "http://yanxuan.nosdn.127.net/a196b367f23ccfd8205b6da647c62b84.png",3.5),
     new Habit(Colors.grey, "content4", "http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png",4.4),
     new Habit(Colors.red, "content5", "http://yanxuan.nosdn.127.net/88dc5d80c6f84102f003ecd69c86e1cf.png",2.8),
     new Habit(Colors.yellow, "content6", "http://yanxuan.nosdn.127.net/8b9328496990357033d4259fda250679.png",3.3),
     new Habit(Colors.green, "content7", "http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png",4.5),
     new Habit(Colors.grey, "content8", "http://yanxuan.nosdn.127.net/ee92704f3b8323905b51fc647823e6e5.png",6.5),
     new Habit(Colors.yellow, "content9", "http://yanxuan.nosdn.127.net/e564410546a11ddceb5a82bfce8da43d.png",5),
  ];

  //  static List<Habit> habitList =List.generate(1, (index) => new Habit("red", "content1", "http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg",),);

   
}

class Habit {
   String? content;
   String img;
   Color color;
   double size;
   Habit(this.color,this.content,this.img,this.size);
}