import 'package:calculate_dite/core/constants/app_text.dart';
import 'package:calculate_dite/core/constants/route_names.dart';
import 'package:calculate_dite/services/create_account_provider.dart';
import 'package:calculate_dite/widgets/button/custom_button.dart';
import 'package:calculate_dite/widgets/dialog/custom_dialog.dart';
import 'package:calculate_dite/widgets/dialog/delete_all_user_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    super.key,
    required this.map,
  });
  Map map;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserManagementProvider>(context);

    int index = widget.map['index'];
    String id = widget.map['id'];

    List? data = provider.userData[index].mealList ?? [''];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          provider.isFetching ? '' : provider.userData[index].name ?? '',
        ),
        actions: [
          provider.isFetching
              ? const SizedBox()
              : data.length < 2
                  ? const SizedBox()
                  : IconButton(
                      tooltip: AppText.deleteAll,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteUserDialog(
                              title: AppText.doYouWantToDeleteAllMeals,
                              onPressed: () {
                                provider.deleteAllMeal(
                                  index,
                                );
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            provider.isFetching
                ? const CircularProgressIndicator()
                : const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Total cal\n',
                      style: context.textTheme.displayLarge,
                    ),
                    Text(
                      '0.0',
                      style: context.textTheme.displayMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total meal\n',
                      style: context.textTheme.displayLarge,
                    ),
                    Text(
                      data.length.toString(),
                      style: context.textTheme.displayMedium,
                    ),
                  ],
                ),
              ],
            ),
            ////ListView'...............
            const Spacer(),
            SizedBox(
              height: context.height * 0.5,
              child: data.isEmpty
                  ? const Center(
                      child: Text(
                        AppText.addYourTodayMeal,
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index2) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                RouteNames.addMealScreen,
                                arguments: {
                                  'mealName': data[index2]['mealName'],
                                  'mealCalories': data[index2]['mealCalories'],
                                  'currIndex': widget.map['index'],
                                  'mealIndex': index2,
                                  'isEdit': true,
                                  'image': data[index2]['mealImage'],
                                  'id': provider.userData[index].id,
                                },
                              );
                            },
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: context.height * 0.3,
                                    width: context.width * 0.5,
                                    child: CustomAlertDialog(
                                      title: AppText.doYouWantToDeleteMeal,
                                      onPressed: () {
                                        provider.deleteMeal(
                                          index,
                                          index2,
                                          id,
                                        );

                                        Navigator.pop(context);
                                      },
                                      buttonTitle: AppText.deleteMeal,
                                    ),
                                  );
                                },
                              );
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  NetworkImage(data[index2]['mealImage'] ?? ''),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index2]['mealName'] ?? '',
                                ),
                                Text(
                                  'cal: ${data[index2]['mealCalories'] ?? ''}',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const Spacer(),
            CustomButton(
              title: const Text(AppText.addMeal),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.addMealScreen,
                  arguments: {
                    'currIndex': index,
                    'id': id,
                    'isEdit': false,
                  },
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
