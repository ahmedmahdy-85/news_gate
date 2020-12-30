import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';

class Registration extends StatefulWidget {
  static const String id = 'registrationScreen';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  int currentImageIndex = 0;
  List<String> images = [
    'assets/images/reg1.png',
    'assets/images/reg2.jpg',
    'assets/images/reg3.jpg',
    'assets/images/reg4.png'
  ];

  Widget dotStyle(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5.0),
      height: 6,
      width: currentImageIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentImageIndex = index;
                });
              },
              itemCount: images.length,
              itemBuilder: (context, index) => Slider(
                size: size,
                image: images[index],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(images.length, (index) => dotStyle(index)),
                ),
                Spacer(
                  flex: 3,
                ),
                SizedBox(
                  width: size.width - 70,
                  child: MaterialButton(
                    elevation: 2,
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    color: Theme.of(context).primaryColor,
                    splashColor: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'CONTINUE',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Slider extends StatelessWidget {
  final Size size;
  final String image;
  Slider({@required this.size, @required this.image});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEWS',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'LOOSE',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Image.asset(image),
      ],
    );
  }
}
