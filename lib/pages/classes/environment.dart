String getVariableAPI() {
  return String.fromEnvironment("API_BASE",
      defaultValue: "https://teraflex-yzph.onrender.com");
}
