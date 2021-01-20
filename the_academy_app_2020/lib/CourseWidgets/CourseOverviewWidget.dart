import 'package:flutter/material.dart';
import 'package:the_academy_app_2020/Models/CourseModel.dart';

class CourseOverviewWidget extends StatefulWidget {
  final CourseProtocol course;
  CourseOverviewWidget({this.course});
  
  @override
  _CourseOverviewWidgetState createState() => _CourseOverviewWidgetState();
}

class _CourseOverviewWidgetState extends State<CourseOverviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
       children: [
         Expanded(
           child: Container(
             //height: MediaQuery.of(context).size.height,
             color: Colors.red,
             child: Text("ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ekshdfbqdhfq kjdfhqkadjshk whjasd kfjhav sdjgvkwjh sehsg dhwGAED EHFG HH SAHJF KWJAHSB KFJHGS DH HSD LHASB KDHBCA SHDBC AHSBDC HASBLD HEHRJBSFD HABS DHFBA HB hb hjfdbv shfbv haelrsukfdeh fjhdas fjkaha jdfal jvksdjfhalv jkdfb lvkejfdakv jhfdkj vhbdl fkvhskjdflhvdhfx kvhadzfkcvajkdfv advbkfadbvdfjv hf vbfdvdanvbdjklsvnbdfnbvlkjadjfb vafdb vfbjkvfb vjafmnvb lkajvbjkfv bfsldjkavb dfkvbfs ljkvbf jkabfjkvbsjklfb jkvabejkcvblkjab f ajksefblv jkafbedk bfl  ",
             ),
           ),
         ),
         Container(
           //height: 50,
           color: Colors.blue,
         ),
         Container(
           //height: 50,
           color: Colors.green,
         ),],
      ),
    );
  }
}

