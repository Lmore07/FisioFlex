String getVariableAPI() {
  return String.fromEnvironment("API_BASE",
      defaultValue: "http://54.173.14.40:3000");
}
