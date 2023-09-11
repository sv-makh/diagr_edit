extension IsNotNullOrEmpty on String? {
  bool isNotNullOrEmpty() {
    return ((this != null) || (this != null && this!.isNotEmpty));
  }
}