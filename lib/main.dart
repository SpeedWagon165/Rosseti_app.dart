import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosseti_project/Blocs/send_messege_bloc.dart';
import 'package:rosseti_project/screens/phone_number_page.dart';

import 'package:rosseti_project/theme/theme_rosseti.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TitleBloc>(
          create: (context) => TitleBloc(),
        ),
        BlocProvider<ExistingTextBloc>(
          create: (context) => ExistingTextBloc(),
        ),
        BlocProvider<ExistingImageBloc>(
          create: (context) => ExistingImageBloc(),
        ),
        BlocProvider<ExistingVideoBloc>(
          create: (context) => ExistingVideoBloc(),
        ),
        BlocProvider<ProposedTextBloc>(
          create: (context) => ProposedTextBloc(),
        ),
        BlocProvider<ProposedImageBloc>(
          create: (context) => ProposedImageBloc(),
        ),
        BlocProvider<ProposedVideoBloc>(
          create: (context) => ProposedVideoBloc(),
        ),
        BlocProvider<PositiveEffectBloc>(
          create: (context) => PositiveEffectBloc(),
        ),
        BlocProvider<TopicBloc>(
          create: (context) => TopicBloc(),
        ),
      ],
      child: const Rosseti(),
    ),
  );
}
