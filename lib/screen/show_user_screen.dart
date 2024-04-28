import 'package:calculate_dite/core/constants/app_text.dart';
import 'package:calculate_dite/services/create_account_provider.dart';
import 'package:calculate_dite/core/constants/route_names.dart';
import 'package:calculate_dite/widgets/dialog/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowUserScreen extends StatefulWidget {
  const ShowUserScreen({super.key});

  @override
  State<ShowUserScreen> createState() => _ShowUserScreenState();
}

class _ShowUserScreenState extends State<ShowUserScreen> {
  @override
  void initState() {
    final provider =
        Provider.of<UserManagementProvider>(context, listen: false);
    provider.getUserData().then((value) {
      setState(() {
        isFetching = false;
      });
    });
    // provider.deleteUser;
    super.initState();
  }

  bool isFetching = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserManagementProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppText.allUsers,
          style: context.textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: context.height * 0.8,
            child: isFetching
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: provider.userData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: context.height * 0.3,
                                  width: context.width * 0.5,
                                  child: CustomAlertDialog(
                                    title: AppText.doYouWantToDelete,
                                    onPressed: () {
                                      provider.deleteUser(
                                        provider.userData[index].id ?? '',
                                        index,
                                      );
                                      Navigator.pop(context);
                                    },
                                    buttonTitle: AppText.deleteUser,
                                  ),
                                );
                              },
                            );
                          },
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.userDetailsScreen,
                                arguments: {
                                  'index': index,
                                  'id': provider.userData[index].id ?? '',
                                });
                            print(index);
                          },
                          title: Text(
                            provider.userData[index].name ?? "",
                            style: context.textTheme.displayMedium,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 25,
                            backgroundImage: NetworkImage(
                              provider.userData[index].image ?? "",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.purple,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.createAccountScreen,
                  );
                  // print(data[0]);
                },
                child: const Text(
                  AppText.addUser,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
