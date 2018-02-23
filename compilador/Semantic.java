public interface Semantic {

	public boolean checkVariableExistence(String variableName);

	public boolean checkMethodExistence(String methodName);

	public boolean checkValidExistingType(Type type);

	public boolean checkTypeCompatibility(Type leftType, Type rightType);

}
