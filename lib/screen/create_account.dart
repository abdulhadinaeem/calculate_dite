import 'package:calculate_dite/services/create_account_provider.dart';
import 'package:calculate_dite/widgets/common/add_image_widget.dart';
import 'package:calculate_dite/widgets/common/bottom_sheet.dart';
import 'package:calculate_dite/widgets/common/custom_list_tile.dart';
import 'package:calculate_dite/widgets/input/custom_text_field.dart';
import 'package:calculate_dite/widgets/button/custom_button.dart';
import 'package:calculate_dite/core/constants/app_images.dart';
import 'package:calculate_dite/core/constants/app_text.dart';
import 'package:calculate_dite/mixins/validator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccount extends StatelessWidget with Validator {
  CreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserManagementProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddImageWidget(
                backgroundImage: provider.image != null
                    ? Image.file(
                        provider.image!,
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
                        title: 'Gallery',
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
                        title: 'Camera',
                        isImage: false,
                      ),
                      if (provider.image != null)
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
                          title: 'Remove',
                          isImage: false,
                        )
                    ],
                  );
                },
              ),
              Text(
                provider.nullImageText ?? '',
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: context.height * 0.45,
                width: double.infinity,
                child: Form(
                  key: provider.formkey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: provider.nameController,
                        keyboardType: TextInputType.name,
                        hintText: AppText.userName,
                        labelText: AppText.name,
                        validator: nameValidator,
                      ),
                      CustomTextField(
                        controller: provider.ageController,
                        validator: ageValidator,
                        keyboardType: TextInputType.number,
                        hintText: AppText.ageHint,
                        labelText: AppText.ageLabel,
                      ),
                      CustomTextField(
                        controller: provider.emailController,
                        validator: emailValidator,
                        keyboardType: TextInputType.emailAddress,
                        hintText: AppText.emailHint,
                        labelText: AppText.emailLabel,
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                title: provider.isDataStoring
                    ? const CircularProgressIndicator()
                    : const Text(AppText.createAccount),
                onPressed: () {
                  provider.imageErrortext();
                  if (provider.formkey.currentState!.validate()) {
                    provider.createAccountOnTap(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
