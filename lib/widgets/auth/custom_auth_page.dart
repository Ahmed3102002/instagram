import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:social/providers/is_loading_provider.dart';
import 'package:social/utils/methods/app_methods.dart';
import 'package:social/widgets/others/custom_text.dart';

import '../../utils/constants.dart';

class CustomAuthPage extends StatelessWidget {
  const CustomAuthPage({
    super.key,
    required this.children,
    required this.formKey,
  });
  final List<Widget> children;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    final IsLoadingProvider isLoading = Provider.of<IsLoadingProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading.isLoading,
        progressIndicator: CircularProgressIndicator(
          color: Theme.of(context).dividerColor,
        ),
        child: Scaffold(
          appBar: AppBar(
            foregroundColor: Theme.of(context).dividerColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            elevation: 0,
            title: CustomText(
              title: 'Social app',
              fontSize: 20,
              color: Theme.of(context).dividerColor,
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  type: MaterialType.card,
                  shadowColor: Theme.of(context).dividerColor,
                  elevation: 5,
                  borderRadius: AppMethods.boderRadius(radius: 30),
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor,
                      borderRadius: ConstantVariables.borderRadius,
                    ),
                    child: InkWell(
                      child: Form(
                        key: formKey,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: children,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
