import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _specialtyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  bool _isLoading = false;

  Future<void> _createAppointment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Genera un ID único para la cita (puedes usar también un auto-incremento o cualquier otro método)
        String appointmentId = DateTime.now().millisecondsSinceEpoch.toString();

        // Guarda la cita en la Realtime Database
        await _database.child('appointments').child(appointmentId).set({
          'id': appointmentId,
          'specialty': _specialtyController.text.trim(),
          'date': _dateController.text.trim(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cita creada exitosamente')),
        );

        // Limpia los campos después de registrar la cita
        _specialtyController.clear();
        _dateController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la cita: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Cita Médica'),
        backgroundColor: const Color(0xFF00ACC1), // Azul médico
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Registrar Cita Médica',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B), // Verde profesional
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                _specialtyController,
                'Especialidad',
                Icons.local_hospital,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _dateController,
                'Fecha (DD/MM/YYYY)',
                Icons.calendar_today,
                inputType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _createAppointment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: const Color(0xFF00796B), // Verde médico
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Crear Cita'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF00796B)),
        prefixIcon: Icon(icon, color: Color(0xFF00ACC1)), // Íconos azules
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFB2EBF2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00796B), width: 2), // Borde verde
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $label';
        }
        return null;
      },
    );
  }
}
