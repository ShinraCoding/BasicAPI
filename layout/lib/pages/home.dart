import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class Homepage extends StatefulWidget {
  // const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ชี้เป้าร้านเด็ด"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder( 
          builder: (context,snapshot) {
            var data = json.decode(snapshot.data.toString()); // decode json ต้องใช้ package dart.convert
            return ListView.builder( // class การทำ Loop
              itemBuilder: (BuildContext context,int index) 
              {
                  return myBox(data[index]['title'], data[index]['subtitle'], data[index]['imageurl'],data[index]['detail']);
              },
              itemCount: data.length, // กำหนดจำนวนรอบที่จะทำ หรือ จำนวนข้อมูลที่จะ Loop
              );

          },
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'), //ดึงข้อมูลจากไฟล์ Json แล้ว assign ค่าให้ snapshot

        ),
      ),
      // bottomNavigationBar: ,
    );
  }

  Widget myBox(String title, String subtitle, String imageurl, String detail) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // มุมกล่องมนๆ
        image: DecorationImage(
          image: NetworkImage(imageurl), //การดึงภาพจาก URL network
          fit: BoxFit.cover, //ทำให้รูปภาพเต็ม container
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.50),
              BlendMode.darken), //ทำให้ภาพเข้มขึ้นจางลงโดยการเทสีลงไป
        ),
        //color: Colors.blue[100],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceEvenly, // ตำแหน่ง start=บน center=กลาง end=ล่าง
        crossAxisAlignment:
            CrossAxisAlignment.start, //ตำแหน่ง start=ซ้าย center=กลาง end=ขวา
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                print("Next page was clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailPage(title,subtitle,imageurl,detail)),
                ); //วิธีการ route ไปยังอีกหน้าเพื่อเวลากด back กลับจะได้กลับมายังหน้าเดิม
              },
              child: Text("อ่านต่อ"),
            ),
          ),
          // Container(
          //   width: 400,
          //   alignment: Alignment.topLeft,
          //   child: Text(
          //     "ร้านเด็ดลับๆ",
          //     style: TextStyle(fontSize: 25),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   width: 250,
          //   alignment: Alignment.center,
          //   child: Text(
          //     "ร้านเด็ดๆที่คุณอาจไม่รู้ หรือ ร้านรับๆที่คุณไม่เคยเห็นมาก่อน",
          //     style: TextStyle(fontSize: 15),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   width: 400,
          //   alignment: Alignment.bottomRight,
          //   child: Text(
          //     "อ่านต่อ",
          //     style: TextStyle(fontSize: 10),
          //   ),
          // ),
        ],
      ),
    );
  }
}
