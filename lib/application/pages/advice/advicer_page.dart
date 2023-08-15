import 'package:advicer_app/application/pages/advice/widget/advice_field.dart';
import 'package:advicer_app/application/pages/advice/widget/custom_button.dart';
import 'package:advicer_app/application/pages/advice/widget/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advicer_app/injection.dart';

import 'bloc/advice_bloc.dart';

class AdvicerWrapperPage extends StatelessWidget {
  const AdvicerWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<AdviceBloc>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advicer App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviceBloc, AdviceState>(
                  builder: (context, state) {
                    if (state is AdviceInitial) {
                      return const Text(
                        'Your advice here...',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      );
                    } else if (state is AdviceLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is AdviceLoaded) {
                      return AdviceField(advice: state.advice);
                    } else if (state is AdviceError) {
                      return ErrorMessage(errorMessage: state.error);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            CustomButton(
              label: 'Get Advice',
              onTap: () => context.read<AdviceBloc>().add(LoadAdvice()),
            ),
          ],
        ),
      ),
    );
  }
}
