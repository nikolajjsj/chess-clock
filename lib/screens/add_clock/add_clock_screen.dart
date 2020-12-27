import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddClockScreen extends StatelessWidget {
  static Route route() {
    return CupertinoPageRoute(builder: (context) => AddClockScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Clock'),
      ),
      body: ListView(
        children: [
          Card(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Clock name',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ClockCreationCard(
            title: 'Time',
          ),
          ClockCreationCard(
            title: 'Increment',
          ),
          ClockCreationCard(
            title: 'Delay',
          ),
        ],
      ),
    );
  }
}

class ClockCreationCard extends StatefulWidget {
  final String title;

  const ClockCreationCard({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _ClockCreationCardState createState() => _ClockCreationCardState();
}

class _ClockCreationCardState extends State<ClockCreationCard> {
  bool isComparing = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                const SizedBox(height: 24.0),
                RaisedButton(
                  child: Icon(
                    Icons.compare_arrows_rounded,
                    color: isComparing ? Colors.white : Colors.red,
                  ),
                  color: isComparing ? Colors.green : Colors.white,
                  onPressed: () => setState(() => isComparing = !isComparing),
                ),
                const SizedBox(width: 24.0),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RaisedButton(
                        child: Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.grey[200],
                        onPressed: () {},
                      ),
                      RaisedButton(
                        child: Text(
                          '00:00',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                        color: Colors.grey[900],
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
