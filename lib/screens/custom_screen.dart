import 'package:chessclock/misc/models/clock_model.dart';
import 'package:chessclock/screens/add_clock/bloc/add_clock_bloc.dart';
import 'package:chessclock/screens/clock/clock_screen.dart';
import 'package:chessclock/widgets/clock_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomScreen extends StatelessWidget {
  const CustomScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddClockBloc, AddClockState>(
      builder: (context, state) {
        if (state is CustomClocksLoaded) {
          return ListView.builder(
            itemCount: state.timers.length,
            itemBuilder: (context, index) {
              final ChessClock _timer = state.timers[index];

              return InkWell(
                onTap: () =>
                    Navigator.of(context).push(ClockScreen.route(_timer)),
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Delete clock?'),
                    content: Icon(
                      Icons.delete_rounded,
                      color: Colors.red,
                      size: 42.0,
                    ),
                    actions: [
                      FlatButton(
                        child: Text(
                          'CANCEL',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<AddClockBloc>(context).add(
                            RemoveCustomClock(index: index),
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                child: ClockCard(chessClock: _timer),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
