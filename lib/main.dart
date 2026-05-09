import 'package:flutter/material.dart';

void main() {
  runApp(const MiApp());
}

// Lista global para guardar personas registradas
List<Map<String, String>> personasRegistradas = [
  {
    'nombre': 'Juan',
    'apellido': 'Pérez',
    'edad': '22',
    'dni': '12345678',
    'correo': 'juan@gmail.com',
  },
  {
    'nombre': 'María',
    'apellido': 'López',
    'edad': '25',
    'dni': '87654321',
    'correo': 'maria@gmail.com',
  },
];

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laboratorio Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// ================= LOGIN =================

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarioController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                size: 90,
                color: Colors.blue,
              ),
              const SizedBox(height: 15),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usuarioController,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(),
                      ),
                    );
                  },
                  child: const Text('INGRESAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MENU =================

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Opciones del menú',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text('Registrar personas'),
              subtitle: const Text('Formulario con 5 campos'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistroPersonasPage(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.list, color: Colors.green),
              title: const Text('Listado de personas'),
              subtitle: const Text('Lista usando ListView'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListadoPersonasPage(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.account_circle, color: Colors.orange),
              title: const Text('Profile'),
              subtitle: const Text('Información del usuario'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Cerrar sesión'),
              subtitle: const Text('Regresar al login'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ================= REGISTRO DE PERSONAS =================

class RegistroPersonasPage extends StatefulWidget {
  const RegistroPersonasPage({super.key});

  @override
  State<RegistroPersonasPage> createState() => _RegistroPersonasPageState();
}

class _RegistroPersonasPageState extends State<RegistroPersonasPage> {
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final edadController = TextEditingController();
  final dniController = TextEditingController();
  final correoController = TextEditingController();

  void guardarPersona() {
    if (nombreController.text.isEmpty ||
        apellidoController.text.isEmpty ||
        edadController.text.isEmpty ||
        dniController.text.isEmpty ||
        correoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos'),
        ),
      );
      return;
    }

    setState(() {
      personasRegistradas.add({
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'edad': edadController.text,
        'dni': dniController.text,
        'correo': correoController.text,
      });
    });

    nombreController.clear();
    apellidoController.clear();
    edadController.clear();
    dniController.clear();
    correoController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Persona registrada correctamente'),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    edadController.dispose();
    dniController.dispose();
    correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Personas'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.person_add_alt_1,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 15),
            const Text(
              'Registrar Persona',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: apellidoController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: edadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: dniController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'DNI',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: guardarPersona,
                icon: const Icon(Icons.save),
                label: const Text('GUARDAR'),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListadoPersonasPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.list),
                label: const Text('VER LISTADO'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= LISTADO DE PERSONAS =================

class ListadoPersonasPage extends StatefulWidget {
  const ListadoPersonasPage({super.key});

  @override
  State<ListadoPersonasPage> createState() => _ListadoPersonasPageState();
}

class _ListadoPersonasPageState extends State<ListadoPersonasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Personas'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: personasRegistradas.isEmpty
          ? const Center(
              child: Text(
                'No hay personas registradas',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: personasRegistradas.length,
              itemBuilder: (context, index) {
                final persona = personasRegistradas[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(
                        persona['nombre']![0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      '${persona['nombre']} ${persona['apellido']}',
                    ),
                    subtitle: Text(
                      'Edad: ${persona['edad']} | DNI: ${persona['dni']}\nCorreo: ${persona['correo']}',
                    ),
                    isThreeLine: true,
                    trailing: const Icon(Icons.person),
                  ),
                );
              },
            ),
    );
  }
}

// ================= PROFILE =================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Mi Perfil',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Nombre'),
                subtitle: Text('Yashira'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.cake),
                title: Text('Edad'),
                subtitle: Text('20 años'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Usuario'),
                subtitle: Text('yashira692'),
              ),
            ),

            const Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('Correo'),
                subtitle: Text('yashira@gmail.com'),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('VOLVER AL MENÚ'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}