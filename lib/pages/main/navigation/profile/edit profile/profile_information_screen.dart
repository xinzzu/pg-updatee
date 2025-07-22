import 'package:flutter/material.dart';
import 'package:pgcard/providers/patient_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../widgets/profile/edit profile/custom_button.dart';
import '../../../../../widgets/profile/edit profile/custom_text_field.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nikController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch patient data on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PatientProvider>(context, listen: false).fetchPatientData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nikController.dispose();
    _birthDateController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Consumer<PatientProvider>(
              builder: (context, patientProvider, child) {
                final patient = patientProvider.patient;

                if (patientProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (patient != null) {
                  // Populate the text controllers with patient data
                  _nameController.text = patient.fullName;
                  _nikController.text = patient.nationalId;
                  _birthDateController.text = patient.dateOfBirth;
                  _genderController.text = patient.gender;
                  _addressController.text = patient.address;
                  _phoneController.text = patient.phoneNumber;
                }

                return Container(
                  constraints: const BoxConstraints(maxWidth: 375),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Navigation Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.chevron_left,
                                  size: 24,
                                  color: Color(0xFF101010),
                                ),
                              ),
                            ),
                            const SizedBox(width: 66),
                            const Text(
                              'Informasi Profil',
                              style: TextStyle(
                                color: Color(0xFF101010),
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Profile Image
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child: CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('assets/images/profile.png'),
                            ),
                          ),
                        ),

                        // Form Fields with data from patient model
                        CustomTextField(
                          label: 'Nama',
                          controller: _nameController,
                        ),
                        CustomTextField(
                          label: 'NIK',
                          controller: _nikController,
                          keyboardType: TextInputType.number,
                        ),
                        CustomTextField(
                          label: 'Tanggal Lahir',
                          controller: _birthDateController,
                        ),
                        CustomTextField(
                          label: 'Jenis Kelamin',
                          controller: _genderController,
                        ),
                        CustomTextField(
                          label: 'Alamat',
                          controller: _addressController,
                        ),
                        CustomTextField(
                          label: 'Nomor telfon',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                        ),

                        // Save Button
                        const SizedBox(height: 15),
                        CustomButton(
                          text: 'Simpan perubahan',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Handle form submission
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
