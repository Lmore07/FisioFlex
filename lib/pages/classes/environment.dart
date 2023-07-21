String getVariableAPI() {
  return String.fromEnvironment("API_BASE",
      defaultValue: "http://44.202.143.143:3000");
}
