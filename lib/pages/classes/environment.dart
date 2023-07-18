String getVariableAPI() {
  return String.fromEnvironment("API_BASE",
      defaultValue: "http://18.209.60.73:3000");
}
