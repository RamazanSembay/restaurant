import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            appBar(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Menu(),
                  Container(
                    height: 150,
                    width: 400,
                    child: FutureMenu(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: MenuTovar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTovar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Мәзір').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var data = snapshot.data.docs[index];
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff444444),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(
                                  image: NetworkImage(
                                      'https://image.starterapp.ru/w:1680/aHR0cHM6Ly9jZG4uc2FuaXR5LmlvL2ltYWdlcy91cHJ1bWJ3ai9wcm9kdWN0aW9uLzYwZmJiYmFjNGNmYmFhZDQwNzMwNzVkMzE4MmIxMzg0YzhjMGEyOTEtNjQweDY0MC5qcGc='),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Бірінші тағамдар',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff222222),
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.amber,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Көру',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff222222),
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Tovar extends StatelessWidget {
  final String name;
  final String image;

  const Tovar({Key key, this.name, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color(0xff444444),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage(image),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff999999),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}

class FutureMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Категория').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var data = snapshot.data.docs[index];
            return Tovar(
              name: data['Название'],
              image: data['Картинка'],
            );
          },
        );
      },
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Tovar(
          name: 'Палау',
          image:
              'https://image.starterapp.ru/w:1680/aHR0cHM6Ly9jZG4uc2FuaXR5LmlvL2ltYWdlcy91cHJ1bWJ3ai9wcm9kdWN0aW9uL2NiNWU1Y2E3N2U2NWViMDFmNDEzZTg4NWE4ZjQ3NTM0ZmZiNTM0MDctNzgzeDc4My5qcGc=',
        ),
        Tovar(
          name: 'Салаттар',
          image:
              'https://image.starterapp.ru/w:1680/aHR0cHM6Ly9jZG4uc2FuaXR5LmlvL2ltYWdlcy91cHJ1bWJ3ai9wcm9kdWN0aW9uLzE4MTA1OWZlYzM1ZmY1YmQ1MzgwNWNlNzU0Y2Y2OGFkOGI3NTNkZTMtMzkzMXg1ODk3LmpwZw==',
        ),
        Tovar(
          name: 'Пісірілген',
          image:
              'https://image.starterapp.ru/w:1680/aHR0cHM6Ly9jZG4uc2FuaXR5LmlvL2ltYWdlcy91cHJ1bWJ3ai9wcm9kdWN0aW9uL2Q0N2U1NjM4MDI0OWE3MDE5YzQ2NDgyYTM5NjUyMmU5ZmUzYWEzZWQtNDAwMng2MDAzLmpwZw==',
        ),
      ],
    );
  }
}

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
        bottom: 30,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/arrow_back.png'),
                    width: 40,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          Text(
            'Мәзір',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xff222222),
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }
}
