import 'package:akademik_app/ui/screen/homepage_screen_bloc.dart';
import 'package:akademik_app/ui/screen/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseStateScreen extends StatefulWidget {
  const ChooseStateScreen({super.key});

  @override
  State<ChooseStateScreen> createState() => _ChooseStateScreenState();
}

class _ChooseStateScreenState extends State<ChooseStateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose State'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(MenuScreen());
                },
                child: Text('GetX'),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(HomePageScreenBloc());
                },
                child: Text('Bloc'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
