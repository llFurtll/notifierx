# NotifierX

<a href="https://www.buymeacoffee.com/danielmelonari" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

## Por que?
Enquanto eu desenvolvia alguns projetos em Flutter, sentia uma grande dificuldade em questão de toda hora criar
vários ValueNotifier em minha Controller por exemplo para gerenciar as alterações de um determinado processo e nisso
replicar em tela ao usuário.
Durante esse tempo comecei a lembrar que no Flutter temos a classe ChangeNotifier, que podemos utilizar para informar
ao Flutter quando queremos que determinada ação gere uma alteração, então refleti um pouco e pensei em uma forma
de padronizar de forma organizada uma forma onde o desenvolvedor possa criar um Widget que a qualquer momento possa
alterar seu estado conforme uma determinada circunstância.

## Observações
Antes de começar, sempre gosto de lembrar que esse plugin está em fase inicial, e durante seu desenvolvimento pode ser
modificado algumas partes para melhorar o desenvolvimento dos projetos ao desenvolvedor, ao criar o <b>NotifierX</b> visei sempre a utilizar os recursos do Dart/Flutter para conseguir realizar as injeções de dependências.

## Pontos a entender
Conforme vocês podem ver em meu projeto de exemplo, eu criei uma estrutura no momento de criar uma View no Flutter, necessariamente você não preciisa seguir essa estrutura, mas vou explicar para você entender a ideia.
```
 - presentation
    - list_person
      - notifiers
      - pages
      - widgets
```
* <b>notifiers: </b> Aqui será seu controlador, onde ficará as regras de negócio da sua View e alterações de estado.
* <b>pages: </b> Aqui ficará suas Views, onde cada uma terá um Notifier.
* <b>widgets: </b> Os Widgets que você deseja criar para utilizar em suas Views.

Outro ponto interessante, que nesse plugin eu decidi criar um Widget específico onde o mesmo conterá um Notifier e ficará escutando as mudanças e realizando a alteraçõa do estado conforme você deseja, nesse caso hoje você pode alterar o estado do seu Widget para três tipos:
* <b>loading: </b> Nesse momento o seu Widget está no estado de "carregando", nesse momento você pode retornar se quiser um CiruclarProgressIndicator.
* <b>error: </b> Nesse momento o seu Widget está no estado de "erro", nesse momento você poderia mostrar ao usuário um AlertDialog explicando o motivo de erro e renderizando em tela alguma mensagem ou botão de atualizar a View novamente.
* <b>ready: </b> Nesse momento o seu Widget está "finalizado", nesse caso não aconteceu nenhuma falha no processo e os dados já foram carregados, nisso você pode retornar as informações que você desejar.

## NotifierXListener
Essa classe nada mais é que uma classe abstrata, onde toda vez que você for criar um Notifier você estenderá dela, nesse momento você estará herdando métodos padrões que logo vou explicar em baixo, que nisso facilitará para você alterar os estados do seu Widget.

Vamos entender os métodos onInit, onClose e o onDependencies.
```dart
    @mustCallSuper
    void onInit() {
        mediator.register(this);
    }

    @mustCallSuper
    void onClose() {
        mediator.unregister(this);
    }

    void onDependencies() {}
```
Esses três métodos ao estender a classe <b>NotifierXListener</b>, você poderá realizar a sobrecarga dos mesmos, vamos entendê-los:
* <b>onInit: </b> Esse método é executado no initState do Widget. Um ponto importante que quando vocẽ cria um Notifier a partir desse momento ele estará configurado para receber chamadas, explicaremos isso mais a adiante.
* <b>onClose: </b> Esse método é executado no dipose do Widget. Um ponto importante, que no momento de ser destruído removemos ele também da lista de Listeners para não receber mais chamadas.
* <b>onDependencies: </b> Esse método executará no didChangeDependencies do Widget, recomendado utilizar esse método caso deseje buscar algum parâmetro da rota por exemplo que depende do contexto já ter sido criado.

Você também pode notar que seu Notifier herdará três métodos:
```dart
    void setLoading() {
        if (state != NotifierXState.loading) {
        state = NotifierXState.loading;
        notifyListeners();
        }
    }

    void setReady() {
        if (state != NotifierXState.ready) {
            state = NotifierXState.ready;
            notifyListeners();
        }
    }

    void setError() {
        if (state != NotifierXState.error) {
            state = NotifierXState.error;
            notifyListeners();
        }
    }
```

Esses três métodos são muito simples, basicamente eles irão alterar o estado do seu Widget para "loading", "erro" ou "ready" e nisso o Widget se encarregará de chamar as funções de construção que você deseja exibir para o usuário dependendo do estado que você chamou.

Por fim temos o método receive:
```dart
    void receive(String message, dynamic value) {}
```

Esse método você pode sobescrever o mesmo e definir quais ações tomar caso algum outro Notifier dispare uma mensagem no Notifier correspondente, por exemplo, você realizou um cadastro de um registro e deseje que sua listagem recarregue as informações.
Esse método possuí 2 argumentos:
* <b>message: </b> Qual a mensagem que você deseja emitir ao Notifier, exemplo "load".
* <b>value: </b> Caso deseje compartilhar um valor de um Notifier para o outro.

# NotifierXObs
Esse é o Widget encarregado em gerenciar as alterações de loading, error e ready, então em seu Notifier a partir do momento que você começar uma chamada para uma banco local por exemplo e chamar o método setLoading, automaticamente o NotifierXObs identificará a alteração de estado e exibir ao usuário o que você desejar, segue um exemplo:
```dart
    NotifierXObs<ListPersonNotifier>(
      build: (context, notifier) {
        if (notifier.peoples.isEmpty) {
          return const Center(
            child: Text(
              "Nenhuma pessoa cadastrada!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            )
          );
        }
        
        return ListView.separated(
          itemCount: notifier.peoples.length,
          padding: const EdgeInsets.all(15.0),
          separatorBuilder: (context, index) => const SizedBox(height: 15.0),
          itemBuilder: (context, index) {
            return ItemListPersonWidget(person: notifier.peoples[index]);
          },
        );
      },
      loading: (context, notifier) =>
        const Center(child: CircularProgressIndicator()),
      error: (context, notifier) {
        return Center(
          child: Text(
            notifier.messageError,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.red
            ),
          )
        );
      },
    );
```

Como você pode ver, o NotifierXObs apenas solicita que você passe no argumento o método build, onde você terá acesso ao contexto e o seu Notifier, pode reparar também que eu passo para ele qual será o Notifier que ele deverá buscar nas dependências, não se preocupe, vou explicar depois como configurar as dependências, nisso também você pode passar os argumentos não obrigatórios como error e loading, então quando gerar algum erro no processo automaticamente o método de error será chamado e uma mensagem será exibida ao usuário, caso esteja no estado de loading um CircularProgressIndicator será exibido ao usuário, quando estiver os dados carregado chamará o método build.

# NotifierXObsScreen
Essa classe também é abstrata, eu criei ela para que o desenvolvedor possa criar uma View estendendo a partir dela e nisso
ter acesso ao Notifier de forma mais global vamos se dizer assim, no caso por exemplo, você tem um FloatingActionButton em sua View e você deseja disparar uma ação no Notifier, em vez de utilizar os disparos de mensagens para o Notifier específico você já terá acesso de forma global vamos se dizer assim ao Notifier da View correspondente.

Nessa classe você só será obrigado a implementar o método builder, segue exemplo:
```dart
    class FormPerson extends NotifierXObsScreen<FormPersonNotifier> {
        const FormPerson({super.key});

        @override
        Widget builder(BuildContext context) {
            return AlertDialog(
            title: Text(notifier.isEdit ? "Editar pessoa" : "Cadastrar nova pessoa"),
            actions: _buildActions(context),
            content: _buildContent(),
        );
    }
```
Como você pode notar, na assinatura da classe você deverá passar também ao <b>NotifierXObsScreen</b> qual Notifier ele deverá buscar as alterações.

E como explicado anteriomente nessa minha View eu tenho alguns botões de ações, onde também terão acesso ao Notifier.
```dart
    List<Widget> _buildActions(BuildContext context) {
        return [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Fechar")
            ),
            TextButton(
                onPressed: notifier.save,
                child: Text(notifier.isEdit ? "Atualizar" : "Cadastrar")
            )
        ];
    }
```
Como você pode notar, o meu TextButton está chamando o método save do Notifier, e também tenho acesso a variábel isEdit, para validar se no momento está realizando uma edição ou um cadastro.

# NotifierXMediator
Essa classe é um mediador entre os Notifiers, onde você pode disparar eventos de um Notifier para outro, é bem simples de utilizar, segue um exemplo:
No seu Notifier você deverá sobescrever o método receive:
```dart
    @override
    void receive(String message, dynamic value) {
        switch (message) {
        case "load":
            _loadPeoples();
            break;
        case "delete":
            _deletePeople(value);
            break;
        }
    }
```

Você pode notar que meu Notifier pode receber duas mensagens, load e delete, e conforme a mensagem eu disparo coisas diferentes, agora veja como chamar:
```dart
    mediator.send<ListPersonNotifier>("load")
```
Todo Notifier que você cria já tem acesso ao mediador, nisso você deverá chamar o método send passando para ele qual Notifier ele deverá buscar, nisso você passa a mensagem, que é o argumento obrigatório da função, caso também desejar pode passar um segundo argumento nomeado que é o valor que deseja enviar ao Notifier.

# Configurando as dependências
Bom esse é o momento de configurar as dependências, lá no método main da sua aplicação, antes de retornar o MaterialApp você irá retornar a classe <b>NotifierXDependencies</b>, segue exemplo:
```dart
    void main() => runApp(
        NotifierXDependencies(
            globalDependencies: create(),
            depencencies: const [
                createListPersonNotifier,
                createFormPersonNotifier
            ],
            child: const MaterialApp(
                home: ListPerson(),
            )
        )
    );
```
Como você pode ver no meu exemplo, existem dois argumentos, o primeiro seria a configuração das dependências globais da sua aplicação e o segundo seriam todos os Notifiers da sua aplicação, bom conforme meu projeto de exemplo, eu tenho essas dependências globais, no caso crie uma função em seu projeto onde você retornará uma lista de dependências, segue o meu exemplo:
```dart
    List<dynamic> create() {
        List<dynamic> dependencies = [];

        dependencies.add(PathProviderAdapterImpl());
        dependencies.add(FileDataSource(pathProvider: dependencies.whereType().first));

        return dependencies;
    }
```
No meu projeto eu configurei duas dependências globais, uma é o PathProvider e o outro um DataSource que salvar/le as informações do meu aplicativo em um arquivo.
Para os Notifiers eu segui o seguinte padrão, para todo Notifier que eu criar no mesmo arquivo eu crio uma função que irá retornar ele com as dependências, segue o exemplo do projeto, vamos olhar meu Notifier da listagem?
```dart
    class ListPersonNotifier extends NotifierXListener {
        final GetFindAllPerson getFindAllPerson;
        final GetDeletePerson getDeletePerson;
        
        ListPersonNotifier({
            required this.getFindAllPerson,
            required this.getDeletePerson
        });
    }

    ListPersonNotifier createListPersonNotifier(List<dynamic> global) {
        final dataSource = PersonFileDataSourceImpl(
            dataSource: global.whereType<DataSource<File>>().first
        );
        final repository = PersonRepositoryImpl(dataSource);

        final getFindAllPerson = GetFindAllPerson(repository);
        final getDeletePerson = GetDeletePerson(repository);

        final notifier = ListPersonNotifier(
            getFindAllPerson: getFindAllPerson,
            getDeletePerson: getDeletePerson
        );

        return notifier;
    }
```
Como você pode notar meu Notifier depende de dois casos de uso, nisso eu criei um método que retorna a instância dele, e você pode notar que nesse método existe um argumento chamado global, exatamente, esse argumento será repassado a sua função lá no <b>NotifierXDependencies</b>, nisso ele irá chamar sua função e armazenar seu Notifier nas dependências da aplicação, nisso você terá acesso as dependências globais da aplicação, no meu caso, meu PersonFileDataSourceImpl depende de um DataSource<File>, que nada mais é que meu FileDataSource que configurei nas dependências globais.

Feito isso você chamará o método que cria seu Notifier lá no argumento dependencies, onde você basicamente passa uma lista de funções e nisso o <b>NotifierXDependencies</b> executa e passa as dependências globais para você.

Aí pronto, suas dependências estarão configuradas e o plugin realizará todos os processos necessários para injetálas e armazená-las na memória para ser possível buscar posteriomente, nisso você não precisará ficar criando novos objetos sempre e sim reaproveitálos nas dependências globais do sistema, como no meu caso uma classe que retornava a conexão com um arquivo.

# Considerações finais
Acredito que não esteja 100%, pode ser que durante o tempo precise realizar melhorias, ter mais conhecimentos para deixar ainda melhor, mas caso você queira colaborar, não hesite em entrar em contato comigo, estou sempre disposto a aprender mais e espero que o plugin ajude a você a desenvolver seus projetos de forma mais simples e eficaz.

### :man:  Dev
<a href="https://www.linkedin.com/in/daniel-melonari-5413a7197/" target="_blank">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/48370450?v=4" width="100px;" height="100px" alt=""/>
 <br />
 <sub><b>Daniel Melonari</b></sub></a> <a href="https://www.linkedin.com/in/daniel-melonari-5413a7197/" title="Linkedin" target="_blank">🚀</a>


Done with ❤️ by Daniel Melonari 👋🏽 Contact!