import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../application/advice/advice_bloc.dart';
import '../../application/theme/theme_service.dart';
import '../../injection.dart';
import 'widgets/advice_field.dart';
import 'widgets/custom_button.dart';
import 'widgets/error_message.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adviceBloc = sl<AdviceBloc>();
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            Switch(
                value: Provider.of<ThemeService>(context).isDarkModeOn,
                onChanged: (_) {
                  Provider.of<ThemeService>(context, listen:  false).toggleTheme();
                })
          ],
          centerTitle: true,
          backgroundColor: themeData.appBarTheme.backgroundColor,
          title: Text(
            'Advicer',
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
                BlocBuilder<AdviceBloc, AdviceState>(
                    bloc: adviceBloc,
                    builder: (context, adviceState) {
                      if (adviceState is AdviceStateInitial) {
                        return Expanded(
                          child: Center(
                              child: Text(
                            'Your Advice is Waiting for you!',
                            textAlign: TextAlign.center,
                            style: themeData.textTheme.headline1!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        );
                      } else if (adviceState is AdviceStateLoading) {
                        return Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                                color: themeData.colorScheme.secondary),
                          ),
                        );
                      } else if (adviceState is AdviceStateLoaded) {
                        return Expanded(
                          child: Center(
                            child: AdviceField(
                                adviceText: adviceState.advice.advice),
                          ),
                        );
                      } else if (adviceState is AdviceStateFailure) {
                        return  const Expanded(
                          child: Center(child: ErrorMessage()),
                        );
                      }
                      return const Placeholder();
                    }),
                SizedBox(
                    height: 200,
                    child: Center(child: CustomButton(
                      onPressed: () {
                        adviceBloc.add(AdviceRequested());
                      },
                    )))
              ],
            ),
          ),
        ));
  }
}
