import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.blue,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintStyle: TextStyle(color: Colors.lightBlueAccent)),
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // caixas de textos pra inserir valor
  final anoController = TextEditingController();
  final mesController = TextEditingController();
  final diaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  // Para colocar a mensagem do resultado, variável privada
  String _mensagem = "";

  int ano = 0;
  int mes = 0;
  int dia = 0;

  _diaMesAnoParaDias() {
    // esse método da condições de atualizar a tela
    setState(() {
      // entrada de dados
      ano = int.parse(anoController.text);
      mes = int.parse(mesController.text);
      dia = int.parse(diaController.text);

      // processamento (lógica do app)
      int dias = ano * 360 + mes * 30 + dia;

      // saída de dados
      _mensagem = "Você tem ${dias.toString()} dias";

      // limpa o campo de dados
      anoController.clear();
      mesController.clear();
      diaController.clear();
    });
  }

  void _limpaCampos() {
    // limpa todos os campos do app (um tipo de refresh)
    anoController.clear();
    mesController.clear();
    diaController.clear();
    setState(() {
      _mensagem = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    // define o design do app, appBar e body
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Ano/Mês/Dias para Dias"),
        backgroundColor: Colors.blue[700], // define a tonalidade da cor
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _limpaCampos,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      // construir o design real (campos de textos, botões)
      body: SingleChildScrollView(
        // deixa a possibilidade de rolagem na página
        padding: EdgeInsets.all(10), // padding para todos os lados
        child: Form(
          key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // centraliza a figura
          children: [
            // objetos que colocaremos dentro do app
            Icon(
              Icons.date_range,
              size: 150,
              color: Colors.blueAccent,
            ),
            construirTextField("Anos", "Anos: ", anoController, "Digite os anos!"),
            Divider(), // adiciona um pequeno espaço entre as propriedades, parecido com o padding

            construirTextField("Mês", "Meses: ", mesController, "Digite os meses!"),
            Divider(),

            construirTextField("Dias", "Dias: ", diaController, "Digite os dias!"),
            Divider(),
            Padding(
              padding: EdgeInsets.all(20),
              child: FlatButton(
                // Texto do botão
                child: Text("Ano/Mês/Dias para Dias",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                    )),
                onPressed: () {
                  // valida se os campos estão preenchidos
                  if(_formKey.currentState!.validate()){
                    // retorna true
                    // Ao pressionar, chama o método da lógica do app
                    _diaMesAnoParaDias();
                  }
                },
              ),
            ),

            Center(
              child: Text(
                _mensagem,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  Widget construirTextField(
      String texto, String prefixo, TextEditingController c, String mensagemErro) {
    return TextFormField(
      controller: c,
      validator: (value){
        if(value!.isEmpty){
          return mensagemErro;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: TextStyle(
          color: Colors.blue,
        ),
        border: OutlineInputBorder(),
        prefixText: prefixo,
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );
  }
}
