import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/view/home_view.dart';

class RegisterProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(RegisterProvider.pattern.toString());
  UserCredential userCredential;

  void registerValidation({
    TextEditingController fullName,
    TextEditingController email,
    TextEditingController password,
    TextEditingController phone,
    BuildContext context,
  }) async {
    if (fullName.text.trim().isEmpty) {
      Get.snackbar(
        'Атын толтырыңыз',
        'Сіз өз атыңызды енгізбедіңіз!',
        snackPosition: SnackPosition.TOP,
      );
      return;
    } else {
      if (!regExp.hasMatch(email.text.trim())) {
        Get.snackbar(
          'Поштаны толтырыңыз',
          'Сіз электрондық поштаны енгізбедіңіз!',
          snackPosition: SnackPosition.TOP,
        );
        return;
      } else {
        if (password.text.trim().isEmpty) {
          Get.snackbar(
            'Құпия сөзді толтырыңыз',
            'Сіз парольді енгізбедіңіз!',
            snackPosition: SnackPosition.TOP,
          );
          return;
        } else {
          if (password.text.length <= 8) {
            Get.snackbar(
              'Мәтін өрісі',
              'Пароль 8 болуы керек!',
              snackPosition: SnackPosition.TOP,
            );
            return;
          } else {
            try {
              notifyListeners();
              userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email.text,
                password: password.text,
              );
              notifyListeners();
              FirebaseFirestore.instance
                  .collection('Пользователь')
                  .doc(userCredential.user.uid)
                  .set(
                {
                  "Id": userCredential.user.uid,
                  "Имя": fullName.text,
                  "Почта": email.text,
                  "Пароль": password.text,
                  "Номер телефон": phone.text,
                  "Город": 'Нету',
                  "Адрес": 'Нету',
                  "Картинка":
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmRl3d2-pvsay_8CnBFoGlXtZ5jybJr9PkbDAL6bVN-CZWsqfsMi4Q5-ezCMew_lhqjvo&usqp=CAU',
                  "Дата": DateTime.now(),
                },
              ).then((value) {
                notifyListeners();
                Get.to(HomeView());
              });
            } on FirebaseAuthException catch (e) {
              notifyListeners();
              if (e.code == "week-password") {
                Get.snackbar(
                  'Құпиясөзді қарау',
                  'Әлсіз пароль',
                  snackPosition: SnackPosition.TOP,
                );
              } else if (e.code == 'email-already-in-user') {
                Get.snackbar(
                  'Тексеру',
                  'Пайдаланылған электрондық пошта',
                  snackPosition: SnackPosition.TOP,
                );
              }
            }
          }
        }
      }
    }
  }
}
