import 'dart:io';
import 'package:calculate_dite/core/constants/app_images.dart';
import 'package:calculate_dite/core/constants/app_text.dart';
import 'package:calculate_dite/mixins/validator.dart';
import 'package:calculate_dite/services/create_account_provider.dart';
import 'package:calculate_dite/widgets/button/custom_button.dart';
import 'package:calculate_dite/widgets/common/add_image_widget.dart';
import 'package:calculate_dite/widgets/common/bottom_sheet.dart';
import 'package:calculate_dite/widgets/common/custom_list_tile.dart';
import 'package:calculate_dite/widgets/input/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddMealScreen extends StatefulWidget {
  AddMealScreen({
    super.key,
    required this.map,
  });
  Map<String, dynamic> map;

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> with Validator {
  @override
  void initState() {
    final provider =
        Provider.of<UserManagementProvider>(context, listen: false);
    if (widget.map['isEdit'] == true) {
      provider.mealController.text = widget.map['mealName'] ?? '';
      provider.caloriesController.text = widget.map['mealCalories'] ?? '';
      provider.image = File(widget.map['image'] ?? '');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserManagementProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              widget.map['isEdit']
                  ? provider.clearMealFields()
                  : provider.clearMealFields();
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          widget.map['isEdit'] ? AppText.editMeal : AppText.addNewMeal,
          style: context.textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: provider.addMealKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              AddImageWidget(
                backgroundImage: provider.image != null
                    ? Image.network(
                        widget.map['isEdit']
                            ? widget.map['image']!
                            : provider.imageUrl!,
                        fit: BoxFit.cover,
                      ).image
                    : const NetworkImage(
                        AppImages.noProfilePic,
                      ),
                onTap: () {
                  showCustomModalBottomSheet(
                    context,
                    [
                      CustomListTile(
                        isForwardIcon: false,
                        icon: const Icon(
                          Icons.photo,
                          color: Colors.black,
                        ),
                        onTap: () {
                          provider.getImageFromGallery();
                          Navigator.pop(context);
                        },
                        title: AppText.gallery,
                        isImage: false,
                      ),
                      CustomListTile(
                        isForwardIcon: false,
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                        onTap: () {
                          provider.getImageFromCamera();
                          Navigator.pop(context);
                        },
                        title: AppText.camera,
                        isImage: false,
                      ),
                      if (provider.image != null ||
                          widget.map['isEdit'] == true)
                        CustomListTile(
                          isForwardIcon: false,
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          onTap: () {
                            provider.deleteImage();
                            Navigator.pop(context);
                          },
                          title: AppText.remove,
                          isImage: false,
                        ),
                    ],
                  );
                },
              ),
              const Spacer(),
              CustomTextField(
                hintText: AppText.egg,
                labelText: AppText.meal,
                validator: mealValidator,
                controller: provider.mealController,
              ),
              CustomTextField(
                hintText: AppText.seventy,
                labelText: AppText.calories,
                validator: caloriesValidator,
                keyboardType: TextInputType.number,
                controller: provider.caloriesController,
              ),
              CustomButton(
                title: provider.isDataStoring
                    ? const CircularProgressIndicator()
                    : const Text(AppText.add),
                onPressed: () {
                  if (provider.addMealKey.currentState!.validate()) {
                    provider.addMealOnTap(
                        widget.map['isEdit'],
                        widget.map['id'],
                        widget.map['currIndex'],
                        widget.map['mealIndex'],
                        context);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
