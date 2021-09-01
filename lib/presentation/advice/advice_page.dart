import 'package:advicer/application/advice/advice_bloc.dart';
import 'package:advicer/injection.dart';
import 'package:advicer/presentation/advice/widgets/advice_field.dart';
import 'package:advicer/presentation/advice/widgets/custom_button.dart';
import 'package:advicer/presentation/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adviceBloc = sl<AdviceBloc>();
    final themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: themeData.appBarTheme.color,
          title: Text(
            "Advicer",
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
                            "Your Advice is Waiting for you!",
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
                                advice_text: adviceState.advice.advice),
                          ),
                        );
                      } else if (adviceState is AdviceStateFailure) {
                        return Expanded(
                          child: Center(child: ErrorMessage()),
                        );
                      }
                      return Placeholder();
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
