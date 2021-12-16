import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/views/create_todo_view.dart';
import 'custom_widgets/padding_with_text.dart';
import 'custom_widgets/search_delegate.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TodoController _todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 250, 255, 1),
      drawer: Drawer(
        child: Container(
          color: const Color.fromRGBO(14, 31, 85, 1),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Card(
                      color: Color.fromRGBO(14, 31, 85, 1),
                      shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              CircularPercentIndicator(
                radius: 120,
                progressColor: Colors.pink,
                backgroundColor: const Color.fromRGBO(59, 74, 123, 1),
                animation: false,
                lineWidth: 3,
                percent: 0.4,
                center: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/user.jpeg'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text('Asante \nUsman',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(80, 40, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RowWithIconAndText(
                        text: 'Templates',
                        icon: Icons.bookmark_border_outlined),
                    const RowWithIconAndText(
                        text: 'Categories', icon: Icons.grid_view_outlined),
                    const RowWithIconAndText(
                        text: 'Analytics', icon: Icons.pie_chart_outline),
                    const RowWithIconAndText(
                        text: 'Settings', icon: Icons.settings_outlined),

                    //Showing todo progress graph
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 60, 50, 20),
                        child: Image.asset('assets/images/graph.png')),

                    Column(
                      children: const [
                        Text(
                          'Good',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 169, 199, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Consistency',
                          style: TextStyle(
                              color: Color.fromRGBO(164, 169, 199, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 250, 255, 1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color.fromRGBO(171, 158, 158, 1)),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: MySearchDelegate(), query: '');
            },
            icon: const Icon(Icons.search, size: 26),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications_outlined, size: 26),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PaddingWithText(
                padding: EdgeInsets.all(18),
                text: "What's up,Asante!",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(34, 45, 87, 1)),
            const PaddingWithText(
              text: 'CATEGORIES',
              fontSize: 12.0,
              color: Color.fromRGBO(161, 167, 200, 1),
              fontWeight: null,
              padding: EdgeInsets.all(18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CardCategory(
                  mainText: 'Business',
                  tasks: '40 tasks',
                  indicatorColor: Colors.pink,
                  completionLevel: 0.6,
                ),
                CardCategory(
                  mainText: 'Personal',
                  tasks: '18 tasks',
                  indicatorColor: Colors.blue,
                  completionLevel: 0.3,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "TODAY'S TASKS",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(161, 167, 200, 1),
                ),
              ),
            ),
            FutureBuilder(
                future: _todoController.getAllTodos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data == null) {
                    return const Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 30),
                    );
                  }

                  Todo? todo = snapshot.data as Todo;
                  return ListView.separated(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 80,
                          child: Card(
                            elevation: 0,
                            child: Row(
                              children: [
                                const Radio(
                                  value: '',
                                  groupValue: '',
                                  onChanged: null,
                                  activeColor: Colors.pink,
                                ),
                                Text(
                                  todo.data![index].todoTitle!,
                                  style: const TextStyle(
                                      //decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 5),
                      itemCount: todo.data!.length); //Pass the lenght here
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(22, 106, 237, 1),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const CreateTodoView()));
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}

// class TodoTileWidget extends StatelessWidget {
//   final Datum? todo;
//   const TodoTileWidget({
//     this.todo,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         itemBuilder: (BuildContext context, int index) {
//           return Dismissible(
//             key: Key(index.toString()),
//             secondaryBackground: const Material(
//               color: Colors.red,
//               child: Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//             ),
//             background: const Material(
//               color: Colors.green,
//               child: Icon(
//                 Icons.check_circle,
//                 color: Colors.white,
//               ),
//             ),
//             onDismissed: (dismissedDirection) {
//               SnackBar snackBar = const SnackBar(
//                 content: Text('Todo has been deleted!',
//                     style: TextStyle(
//                       color: Colors.green,
//                     )),
//               );
//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             },
//             child: SizedBox(
//               height: 80,
//               child: Card(
//                 elevation: 0,
//                 child: Row(
//                   children: [
//                     const Radio(
//                       value: '',
//                       groupValue: '',
//                       onChanged: null,
//                       activeColor: Colors.pink,
//                     ),
//                     Text(
//                       // todo.todoTitle!,
//                       todo!.todoTitle.toString(),
//                       style: const TextStyle(
//                           //decoration: TextDecoration.lineThrough,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) =>
//             const SizedBox(height: 5),
//         itemCount: 4);
//   }
// }

class RowWithIconAndText extends StatelessWidget {
  final IconData? icon;
  final String? text;
  const RowWithIconAndText({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 30,
          color: const Color.fromRGBO(233, 235, 253, 1),
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          text.toString(),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(233, 235, 253, 1)),
        ),
        const SizedBox(
          height: 35,
        )
      ],
    );
  }
}

class CardCategory extends StatelessWidget {
  final String? tasks;
  final String? mainText;
  final Color? indicatorColor;
  final double? completionLevel;
  const CardCategory(
      {Key? key,
      required this.mainText,
      required this.tasks,
      required this.indicatorColor,
      required this.completionLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaddingWithText(
                    padding: const EdgeInsets.fromLTRB(8, 8, 0, 5),
                    text: tasks.toString(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(164, 169, 199, 1)),
                PaddingWithText(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 5),
                  text: mainText.toString(),
                  fontSize: 18,
                  color: null,
                  fontWeight: FontWeight.w700,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width * 0.32,
                    lineHeight: 4.0,
                    percent: completionLevel!,
                    progressColor: indicatorColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Radio(
              value: '',
              hoverColor: Colors.pink,
              onChanged: null,
              groupValue: '',
              activeColor: Colors.blue,
            ),
            Text(
              'Have lunch with Antwi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                // decoration: TextDecoration.lineThrough
              ),
            ),
          ],
        ),
      ),
    );
  }
}
