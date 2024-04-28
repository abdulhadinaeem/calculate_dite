import 'dart:io';
import 'package:calculate_dite/model/show_user_list_model/show_user_list_model.dart';
import 'package:calculate_dite/widgets/dialog/error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserManagementProvider extends ChangeNotifier {
  int? index;
  String? base64bytes;
  List<ShowUserListModel> userData = [];
  late bool isFetching;
  bool isDataStoring = false;
  bool isMealStoring = false;
  File? image;
  String? imageUrl;
  String? name;
  String? userImage;
  String? id;
  String? mealImage;
  String? mealName;
  String? mealCalories;

  String? nullImageText;
  double totalCalories = 0.0;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<FormState> addMealKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mealController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();

  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future getImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final tempImage = File(image.path);
      this.image = tempImage;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick the image:$e');
    }
  }

  Future getImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image == null) return;
      final tempImage = File(image.path);

      this.image = tempImage;
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint('Failed to pick the image:$e');
    }
  }

  upLoadImageToFirebase() async {
    String filePath = 'directoryName/${image?.path.split("/").last}';
    File file = File(image?.path ?? "");
    try {
      TaskSnapshot uploadTask = await firebase_storage.FirebaseStorage.instance
          .ref(filePath)
          .putFile(file);
      imageUrl = await uploadTask.ref.getDownloadURL();

      print('downLoadImage:$imageUrl');

      return imageUrl;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void createAccountOnTap(context) async {
    isDataStoring = true;
    await upLoadImageToFirebase();
    storeAccountData(context);
    clearFileds(context);
    isDataStoring = false;

    notifyListeners();
  }

  void addMealOnTap(isEdit, id, currIndex, mealIndex, context) async {
    isMealStoring = true;
    await upLoadImageToFirebase();
    isEdit
        ? editMealData(id, currIndex, mealIndex)
        : storeMealData(
            id,
            currIndex,
          );
    isEdit ? clearMealFields() : clearMealFields();

    Navigator.pop(context);
    isMealStoring = false;
    notifyListeners();
  }

  void deleteImage() {
    image = null;
    notifyListeners();
  }

  void imageErrortext() {
    nullImageText = image == null ? 'Please add the image!' : '';
    notifyListeners();
  }

//FETCHING DATA....
  Future getUserData() async {
    final snapshot = await FirebaseFirestore.instance.collection('Users').get();
    for (var element in snapshot.docs) {
      print(element.data());
      userData.add(ShowUserListModel.fromMap(element.data()));
    }

    notifyListeners();
  }

//STORE ACCOUNT DATA..........
  Future<void> storeAccountData(BuildContext context) async {
    String img = imageUrl.toString();
    name = nameController.text;
    id = DateTime.now().toString();

    final user = ShowUserListModel(
      name: nameController.text,
      id: DateTime.now().toString(),
      image: img,
    );
    notifyListeners();

    return usersCollection.add(user.toMap()).then((value) {
      print(value.id);
      user.id = value.id;
      usersCollection.doc(value.id).update(user.toMap());
      userData.add(user);
      notifyListeners();
    });
  }

  clearFileds(context) {
    nameController.clear();
    ageController.clear();
    emailController.clear();
    image = null;
    Navigator.pop(context);
  }

  //STORE MEAL DATA...............
  Future<void> storeMealData(String uId, int index) async {
    mealCalories = caloriesController.text;
    mealName = mealController.text;
    String img = imageUrl.toString();
    notifyListeners();
    try {
      usersCollection
          .where('id', isEqualTo: userData[index].id)
          .get()
          .then((value) {
        value.docs.forEach(
          (element) async {
            List<dynamic>? existingMealList =
                (element.data() as Map<String, dynamic>)['mealList'];

            List<dynamic> existingMeals = existingMealList ?? [];

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(element.id)
                .update({'mealList': existingMeals});
          },
        );
      });
    } on FirebaseException catch (e) {
      ErrorDialog(title: e.code.toString());
      print('Exception:${e.code.toString()}');
    }
  }

//EDIT MEAL DATA...........
  Future<void> editMealData(String uId, int userIndex, int mealIndex) async {
    mealCalories = caloriesController.text;
    mealName = mealController.text;
    String img = imageUrl.toString();
    Map<String, dynamic> updatedMeal = {
      'mealName': mealName,
      'mealCalories': mealCalories,
      'mealImage': img,
      'mealId': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    try {
      usersCollection
          .where('id', isEqualTo: userData[userIndex].id)
          .get()
          .then((value) {
        value.docs.forEach(
          (element) async {
            List<dynamic>? existingMealList =
                (element.data() as Map<String, dynamic>)['mealList'];

            List<dynamic> existingMeals = existingMealList ?? [];

            existingMeals[mealIndex] = updatedMeal;

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(element.id)
                .update(
              {'mealList': existingMeals},
            );
          },
        );
      });

      notifyListeners();
    } on FirebaseException catch (e) {
      ErrorDialog(title: e.code.toString());
      debugPrint('Exception:${e.code.toString()}');
    }
  }

//DELETE USER DATA........
  Future<void> deleteUser(String uid, int index) async {
    usersCollection
        .where('id', isEqualTo: userData[index].id)
        .get()
        .then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.docs.forEach(
        (element) async {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(element.id)
              .delete();
          userData.removeAt(index);
          notifyListeners();
        },
      );
    });
  }

//DELETE ALL MEALS........
  void deleteAllMeal(
    int index,
  ) async {
    usersCollection.where('id', isEqualTo: userData[index].id).get().then(
      (value) {
        value.docs.forEach(
          (element) async {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(element.id)
                .update(
              {
                'mealList': FieldValue.arrayRemove(
                  (element.data() as Map)['mealList'],
                ),
              },
            );
          },
        );
      },
    );
  }

//DELETE ONE MEAL..........
  Future<void> deleteMeal(int index, int index2, String id) async {
    try {
      usersCollection.where('id', isEqualTo: userData[index].id).get().then(
        (value) {
          // ignore: avoid_function_literals_in_foreach_calls
          value.docs.forEach(
            (element) async {
              List existingMealList =
                  (element.data() as Map<String, dynamic>)['mealList'];

              List? existingMeals = existingMealList;

              existingMeals.removeAt(index2);

              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(element.id)
                  .update(
                {'mealList': existingMeals},
              );
            },
          );
        },
      );

      notifyListeners();
    } on FirebaseException catch (e) {
      ErrorDialog(title: e.code.toString());
      debugPrint('Exception:${e.code.toString()}');
    }
  }

  void clearMealFields() {
    mealController.clear();
    caloriesController.clear();
    image = null;
    notifyListeners();
  }
}
