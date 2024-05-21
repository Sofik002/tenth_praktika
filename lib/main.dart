import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const App());
}
class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          theme: theme,
          home: const CounterPage(),
        );
      },
    );
  }
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,
      ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}


class CounterPage extends StatelessWidget {
  const CounterPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child:  const CounterView(),
    );
  }
}


class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10 практическая работа"),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Scaffold(
              appBar:AppBar(
                title: Text('$count', style: Theme.of(context).textTheme.displayLarge),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              body:SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children:[
                        Padding(padding: EdgeInsets.only(top: 20),),
                        Text('София', style: TextStyle(
                            fontSize: 24,
                            color: Colors.black
                        ),),
                        Padding(padding: EdgeInsets.only(top: 20),),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/kot.jpg'),
                          radius: 100,
                        ),
                        Padding(padding: EdgeInsets.only(top: 20),),
                        Row(
                          children: [
                            Icon(Icons.mail_outline,size: 24),
                            Padding(padding: EdgeInsets.only(left: 10),),
                            Text('lublupoest@mail.ru', style: TextStyle(
                              fontSize: 24,
                            ),),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10),),
                        ElevatedButton(child: const Text("Перейти в профиль"),onPressed: (){Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> const Account()));},),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),

      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementPressed());
            },
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}



class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData.light();

  static final _darkTheme = ThemeData.dark();

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aккаунт'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body:  SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children:[
                Padding(padding: EdgeInsets.only(top: 40),),
                Text('УПС, при загрузке страницы возрикла ошибка', style: TextStyle(
                    fontSize: 24,
                    color: Colors.pinkAccent
                ),),
                Padding(padding: EdgeInsets.only(top: 20),),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Вернутся на главный экран'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

