import 'package:cronometro/pages/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_cubit.dart';
import 'timer_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cronômetro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<TimerCubit>(context),
                      child: TimerPage(),
                    ),
                  ),
                );
              },
              child: Text('Iniciar Cronômetro'),
            ),
            SizedBox(height: 20), // Adicionando um espaçamento entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TimerScreen(), // Navegar para a tela do Timer diretamente
                  ),
                );
              },
              child: Text('Ir para o Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
