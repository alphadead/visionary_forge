import 'package:flutter/material.dart';
import 'package:visionary_forge/ideaGeneration.dart';
import 'package:visionary_forge/ideaListView.dart';
import 'package:visionary_forge/profileScreen.dart';

Color buttonCol = const Color.fromRGBO(246, 148, 110, 1);
Color bkGnd = const Color.fromRGBO(35, 59, 79, 1);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 59, 79, 1),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  },
                  child: Icon(
                    Icons.person,
                    color: buttonCol,
                  )),
            )
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/home.gif',
            height: 300,
          ),
          const Spacer(),
          Material(
            elevation: 10,
            color: bkGnd,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.white.withOpacity(0.3)),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(246, 148, 110, 1)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              IdeaGenerationPage(),
                        ),
                      );
                    },
                    child: const Text('Lets get your imagination into reality'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(246, 148, 110, 1)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const IdeaListView(),
                        ),
                      );
                    },
                    child: const Text('Want to help an idea grow?'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
