# Gerenciador de Tarefas Flutter

Um aplicativo completo de gerenciamento de tarefas com sistema de autenticação e banco de dados SQLite local.

## Funcionalidades

- ✅ **Sistema de autenticação** com login e registro
- ✅ **Usuários individuais** - cada usuário tem suas próprias tarefas
- ✅ **Adicionar tarefas** com título, descrição e prioridade
- ✅ **Editar tarefas** existentes
- ✅ **Marcar como concluída/não concluída**
- ✅ **Excluir tarefas**
- ✅ **Gerenciar prioridades** (Baixa, Média, Alta)
- ✅ **Visualização por status** (Todas, Pendentes, Concluídas)
- ✅ **Persistência de dados** com SQLite
- ✅ **Interface moderna** com Material Design 3
- ✅ **Logout seguro** com limpeza de dados

## Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada do app
├── home_page.dart            # Página principal (após login)
├── models/
│   ├── task.dart            # Modelo de dados da tarefa
│   └── user.dart            # Modelo de dados do usuário
├── services/
│   └── database_helper.dart  # Serviço de banco de dados
├── providers/
│   ├── auth_provider.dart    # Gerenciamento de autenticação
│   └── task_provider.dart    # Gerenciamento de tarefas
├── widgets/
│   ├── task_card.dart        # Widget do card de tarefa
│   ├── task_form_dialog.dart # Diálogo de formulário
│   └── auth_wrapper.dart     # Wrapper de autenticação
└── pages/
    ├── login_page.dart       # Página de login/registro
    └── database_debug_page.dart # Página de debug do banco
```

## Sistema de Autenticação

### Funcionalidades
- **Registro de usuários** com validação de dados
- **Login seguro** com verificação de credenciais
- **Sessão persistente** durante o uso do app
- **Logout** com limpeza de dados da sessão
- **Isolamento de dados** - cada usuário vê apenas suas tarefas

### Validações
- **Username**: mínimo 3 caracteres, único
- **Email**: formato válido, único
- **Senha**: mínimo 6 caracteres

## Banco de Dados

### Localização do Arquivo
O banco de dados SQLite é criado automaticamente no dispositivo/emulador em:
- **Android**: `/data/data/com.example.flutter_application_1/databases/tasks_database.db`
- **iOS**: `/Users/[user]/Library/Developer/CoreSimulator/Devices/[device-id]/data/Containers/Data/Application/[app-id]/Documents/tasks_database.db`

### Estrutura das Tabelas
```sql
-- Tabela de usuários
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  createdAt INTEGER NOT NULL
);

-- Tabela de tarefas com referência ao usuário
CREATE TABLE tasks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  isCompleted INTEGER NOT NULL,
  createdAt INTEGER NOT NULL,
  completedAt INTEGER,
  priority INTEGER NOT NULL,
  userId INTEGER NOT NULL,
  FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
);
```

### Como Visualizar os Dados
1. Execute o aplicativo
2. Faça login
3. Toque no ícone de usuário na barra superior
4. Selecione "Ver banco de dados"
5. A página de debug mostrará todos os dados brutos do banco

## Como Usar

### Primeiro Acesso
1. Execute o aplicativo
2. Na tela de login, toque na aba "Registrar"
3. Preencha username, email e senha
4. Toque em "Registrar"
5. Você será automaticamente logado

### Login
1. Na tela de login, toque na aba "Entrar"
2. Digite seu username e senha
3. Toque em "Entrar"

### Adicionar Tarefa
1. Faça login no aplicativo
2. Toque no botão "+" flutuante
3. Preencha o título e descrição
4. Selecione a prioridade
5. Toque em "Adicionar"

### Editar Tarefa
1. Toque no ícone de editar (lápis) em qualquer tarefa
2. Modifique os campos desejados
3. Toque em "Salvar"

### Marcar como Concluída
1. Toque no ícone de check (✓) em uma tarefa pendente
2. A tarefa será marcada como concluída

### Alterar Prioridade
1. Toque no ícone de bandeira em qualquer tarefa
2. Selecione a nova prioridade no menu

### Excluir Tarefa
1. Toque no ícone de lixeira em qualquer tarefa
2. Confirme a exclusão

### Logout
1. Toque no ícone de usuário na barra superior
2. Selecione "Sair"
3. Confirme a saída
4. Você será redirecionado para a tela de login

## Dependências

- `flutter`: Framework principal
- `sqflite`: Banco de dados SQLite
- `path`: Manipulação de caminhos
- `provider`: Gerenciamento de estado

## Como Executar

1. Certifique-se de ter o Flutter instalado
2. Execute `flutter pub get` para instalar as dependências
3. Conecte um dispositivo ou inicie um emulador
4. Execute `flutter run`

## Recursos Técnicos

- **Arquitetura**: Provider Pattern para gerenciamento de estado
- **Autenticação**: Sistema próprio com validação
- **Banco de Dados**: SQLite com relacionamentos e chaves estrangeiras
- **UI**: Material Design 3 com temas personalizados
- **Navegação**: TabBar para diferentes visualizações
- **Persistência**: Dados salvos localmente no dispositivo
- **Segurança**: Isolamento de dados por usuário

## Debug e Monitoramento

O aplicativo inclui uma página de debug que permite:
- Visualizar todos os dados brutos do banco
- Verificar a estrutura das tabelas
- Monitorar as operações de CRUD
- Acompanhar timestamps de criação e conclusão
- Ver usuários registrados e suas tarefas

Para acessar: Faça login → Toque no ícone de usuário → "Ver banco de dados"

## Segurança

- **Isolamento de dados**: Cada usuário só acessa suas próprias tarefas
- **Validação de entrada**: Todos os campos são validados
- **Chaves estrangeiras**: Integridade referencial no banco
- **Limpeza de sessão**: Dados são limpos ao fazer logout
