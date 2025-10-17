import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;
  Color backgroundColor = const Color(0xFFBBDEFB);
  Color appBarColor = const Color(0xFF1565C0);

  List<Tarefa> tarefas = [];
  List<Tarefa> finalizados = [];

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String dateNow = formatter.format(now);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer:Scaffold(
          appBar: AppBar(
            title: Text("Imagem Colocada"),
          ),
          body: Image.network('https://www.pokemon.com/static-assets/content-assets/cms2/img/video-games/_tiles/pokemon-legends-z-a/launch/pokemon-legends-z-a-875-en.png'),
          floatingActionButton: FloatingActionButton(onPressed: () => goBack(),
           child: Icon(Icons.close, color: Colors.red,),
           backgroundColor: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text("Tarefas", style: TextStyle(color: Colors.white)),
          backgroundColor: appBarColor,
          actions: [
            ElevatedButton(
              onPressed: colorChange,
              style: ElevatedButton.styleFrom(
                backgroundColor: appBarColor,
                elevation: 0,
              ),
              child: Icon(
                isOn ? Icons.toggle_on : Icons.toggle_off,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Andamentos"),
              Tab(text: "Finalizados"),
            ], //Tabs
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: tarefas.isEmpty
                  ? const Center(
                      child: Text(
                        "Sem tarefas no momento",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D47A1),
                          letterSpacing: 0.2,
                        ),
                      ),
                    )
                  : SizedBox(
                      child: ListView(
                        children: [
                          for (var tarefa in tarefas)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Card(
                                child: ListTile(
                                  onTap: () => taskDetails(tarefa),
                                  title: Text(
                                    tarefa.nomeTask,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    tarefa.descricaoTask,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Text(dateNow),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            tarefas.remove(tarefa);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.done_all),
                                        color: Colors.green,
                                        onPressed: () {
                                          setState(() {
                                            tarefas.remove(tarefa);
                                            finalizados.add(tarefa);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
            Center(
              child: finalizados.isEmpty
                  ? const Center(
                      child: Text(
                        "Sem tarefas feitas",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0D47A1),
                          letterSpacing: 0.2,
                        ),
                      ),
                    )
                  : SizedBox(
                      child: ListView(
                        children: [
                          for (var finalizado in finalizados)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Card(
                                child: ListTile(
                                  onTap: () => taskDetails(finalizado),
                                  title: Text(
                                    finalizado.nomeTask,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    finalizado.descricaoTask,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Text(dateNow),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => setState(() {
                                          finalizados.remove(finalizado);
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: changePage,
              backgroundColor: const Color(0xFF1E88E5),
              child: Icon(Icons.add, color: Colors.white),
            ),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  void colorChange() {
    setState(() {
      isOn = !isOn;
      if (isOn) {
        backgroundColor = const Color(0xFF0D1B2A);
        appBarColor = const Color(0xFF1B263B);
      } else {
        backgroundColor = const Color(0xFFBBDEFB);
        appBarColor = const Color(0xFF1565C0);
      }
    });
  }
  void goBack(){
    setState(() {
      Navigator.pop(context);
    });
  }

  void changePage() async {
    final task = await showDialog<dynamic>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: backgroundColor,
        shadowColor: Colors.blue,
        child: SizedBox(width: 400, height: 300, child: OtherPage()),
      ),
    );

    if (task != null) {
      setState(() {
        tarefas.add(task);
      });
    }
  }

  void taskDetails(Tarefa tarefa) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tarefa.nomeTask.isNotEmpty ? tarefa.nomeTask : "Sem titulo",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 23),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tarefa.descricaoTask.isNotEmpty
                        ? tarefa.descricaoTask
                        : 'Sem descrição',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Fechar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPage();
}

class _OtherPage extends State<OtherPage> {
  Color backgroundColor = const Color(0xFFBBDEFB);
  Color appBarColor = const Color(0xFF1565C0);
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 10,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF1565C0),
          title: Text(
            "Adicionar Tarefas",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Nome da tarefa",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: taskDescriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  hintText: "Descrição da tarefa",
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => onAddTask(),
                  child: Text("Adicionar"),
                ),
                TextButton(
                  onPressed: () => onAddList(),
                  child: Text("Adicionar Lista"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onAddTask() {
    String nome = taskNameController.text;
    String descricao = taskDescriptionController.text;
    Tarefa task = Tarefa(nome, descricao);
    Navigator.pop(context, task);
    //  taskNameController.clear();
    // taskDescriptionController.clear();
  }

  void onAddList() {
    String nome = taskNameController.text;
    String descricao = taskDescriptionController.text;
    List<String> descricaoList = descricao.split(" ");
    String descricaoQuebrada = descricaoList.join("\n");

    Tarefa task = Tarefa(nome, descricaoQuebrada);
    Navigator.pop(context, task);
  }
}

class Tarefa {
  String nomeTask;
  String descricaoTask;

  Tarefa(this.nomeTask, this.descricaoTask);
}
