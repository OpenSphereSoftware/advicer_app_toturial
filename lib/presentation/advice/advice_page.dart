import 'package:advicer/application/advice/advice_bloc.dart';
import 'package:advicer/presentation/advice/widgets/advice_field.dart';
import 'package:advicer/presentation/advice/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adviceBloc = AdviceBloc();
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
      body: BlocBuilder<AdviceBloc, AdviceState>(
          bloc: adviceBloc,
          builder: (context, adviceState) {
            if (adviceState is AdviceInitial) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                            child: Text(
                          "Your Advice is Waiting for you!",
                          textAlign: TextAlign.center,
                          style: themeData.textTheme.headline1!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
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
              );
            } else if (adviceState is AdviceLoading) {
              return Center(
                child: CircularProgressIndicator(
                    color: themeData.colorScheme.secondary),
              );
            } else if (adviceState is AdviceLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: AdviceField(
                              advice_text: adviceState.advice.advice),
                        ),
                      ),
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
              );
            } else if (adviceState is AdviceFailure) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.redAccent,
                              size: 40,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ups, there was something going wrong, try again!",
                              textAlign: TextAlign.center,
                              style: themeData.textTheme.headline1!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )),
                      ),
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
              );
            }
            return Placeholder();
          }),
    );
  }
}
