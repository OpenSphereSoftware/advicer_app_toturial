import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/application/cubit/advicer_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/theme/theme_service.dart';
import '../../injection.dart';
import 'widgets/advice_field.dart';
import 'widgets/custom_button.dart';
import 'widgets/error_message.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  static const String startText = 'Your Advice is Waiting for you!';
  static const String appbarText = 'Advicer';

  static const String buttonKey = "getAdviceButton";
  static const String progressIndicatorKey = "progressIndicatorKey";
  static const String adviceFieldKey = "adviceFieldKey";
  static const String errorMessageKey = "errorMessageKey";

  @override
  Widget build(BuildContext context) {
    final adviceCubit = sl<AdvicerCubitCubit>();
    //final adviceBloc = sl<AdvicerBloc>();
    final themeData = Theme.of(context);
    return Scaffold(
        backgroundColor: themeData.scaffoldBackgroundColor,
        appBar: AppBar(
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen: false)
                      .toggleTheme();
                })
          ],
          centerTitle: true,
          backgroundColor: themeData.appBarTheme.backgroundColor,
          title: Text(
            appbarText,
            style: themeData.textTheme.headline1!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AdvicerCubitCubit, AdvicerCubitState>(
                    //BlocBuilder<AdvicerBloc, AdvicerState>(
                    bloc: adviceCubit, //adviceBloc,
                    builder: (context, adviceState) {
                      if (adviceState is AdvicerCubitInitial) {
                        return Expanded(
                          child: Center(
                              child: Text(
                            startText,
                            textAlign: TextAlign.center,
                            style: themeData.textTheme.headline1!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        );
                      } else if (adviceState is AdvicerCubitLoading) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                                key: const Key(progressIndicatorKey),
                                color: themeData.colorScheme.secondary),
                          ),
                        );
                      } else if (adviceState is AdvicerCubitLoaded) {
                        return Expanded(
                          child: Center(
                            child: AdviceField(
                                key: const Key(adviceFieldKey),
                                adviceText: adviceState.advice.advice),
                          ),
                        );
                      } else if (adviceState is AdvicerCubitFailure) {
                        return const Expanded(
                          child: Center(
                              child: ErrorMessage(
                            key: Key(errorMessageKey),
                          )),
                        );
                      }
                      return const Placeholder();
                    }),
                SizedBox(
                    height: 200,
                    child: Center(
                        child: CustomButton(
                      key: const Key(buttonKey),
                      onPressed: () {
                        adviceCubit.getAdvice();
                        // adviceBloc.add(AdviceRequested());
                      },
                    )))
              ],
            ),
          ),
        ));
  }
}
