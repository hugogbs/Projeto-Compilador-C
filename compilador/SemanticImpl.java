import java.util.*;
public class SemanticImpl {

  private static Map<String, List<String>> tiposCompativeis = new HashMap<String, List<String>>();

  private List<Type> secondaryTypes = new ArrayList<Type>();
  private static List<Type> BASIC_TYPES;
  private static SemanticImpl semantic; // Deve sempre ser um Singleton



  public static SemanticImpl getInstance() {
    if (semantic == null) {
      initCollections();
    }
    return semantic;
  };

  private static void initCollections() {
    initBasicTypes();
    initTypeCompatibility();
  };

  public int getBlockSize() {};

  public void incBlockSize() {};

  public void resetBlockSize() {};

  protected SemanticImpl() {};

  private static void initBasicTypes() {
		BASIC_TYPES = new ArrayList<Type>() {
			{
				add(new Type("float"));
        add(new Type("int"));
        add(new Type("string"));
			};
		};
	};

  private static void initTypeCompatibility() {

    List<String> stringCompTypes = new ArrayList<String>();
    stringCompTypes.add("string");

    List<String> intCompTypes = new ArrayList<String>();
    intCompTypes.add("int");
    intCompTypes.add("float");

    List<String> floatCompTypes = new ArrayList<String>();
    floatCompTypes.add("float");
    floatCompTypes.add("int");
    //
    // List<String> charCompTypes = new ArrayList<String>();
    // charCompTypes.add("char");
  };

  private static void iniTestingOperators() {};

  private void createNewScope(ScopedEntity scope) {};

  public void exitCurrentScope() throws InvalidFunctionException {};

  public void checkVariableAttribution(String id, String function) throws
    InvalidVariableException, InvalidTypeException, InvalidFunctionException {};

  public void exitCurrentScope(Expression exp) throws InvalidFunctionException {};

  public ScopedEntity getCurrentScope() {};

  public void addFunctionAndNewScope(Function f) {};

  public void generateSwitchCode(Expression e) {};

  public void beginSwitch(Expression e) throws InvalidTypeException {};

  public void validateCase(Expression e) throws InvalidTypeException {};

  public boolean checkVariableExistence(String variableName) {};

  public boolean checkVariableExistenceLocal(String variableName) {};

  public boolean checkVariableExistenceGlobal(String variableName) {};

  public void checkFunctionExistence(Function temp) throws InvalidFunctionException {};

  public boolean checkValidExistingType(Type type) {
		return BASIC_TYPES.contains(type) || secondaryTypes.contains(type);
	};

  public void checkIsBoolean(Type type) throws InvalidTypeException {};

  public boolean checkTypeCompatibility(Type leftType, Type rightType) {
    if (leftType.equals(rightType)) {
      return true;
    } else {
      List<String> types = tiposCompativeis.get(leftType.getName());
      if (types == null) {
        return false;
      }
      return types.contains(rightType.getName());
    }
  };

  public void addType(Type type) {
		if (!secondaryTypes.contains(type)) {
			secondaryTypes.add(type);
			List<String> tipos = new ArrayList<String>();
			tipos.add(type.getName());
			tiposCompativeis.put(type.getName(), tipos);
		};
	};

  public boolean checkTypeOfAssignment(Variable variable, Expression exp) throws InvalidTypeAssignmentException {};

  public boolean isNumericExpression(Expression le, Expression re) throws InvalidOperationException {};

  public boolean isNumericExpression(Expression le) throws InvalidOperationException {};

  private void validateVariable(Variable variable) throws Exception {};

  private void validateVariableGlobal(Variable variable) throws Exception {};

  private void addVariable(Variable variable) throws Exception {};

  public void addVariablesFromTempList(Type type) throws Exception {};

  public void validateFunction(String functionName, ArrayList<Parameter> params, Type declaredType) throws
    InvalidFunctionException, InvalidParameterException {};

  private boolean hasReturn(Expression exp) throws InvalidFunctionException {};

  private void checkDeclaredAndReturnedType(String functionName, Type declaredType, Expression exp) throws InvalidFunctionException {};

  private void checkExistingParameter(ArrayList<Parameter> params) throws InvalidParameterException {};

  public Expression getExpression(Expression le, String md, Expression re) throws InvalidTypeException, InvalidOperationException {};

  private Type getMajorType(Type type1, Type type2) {};

  public void checkVariableAttribution(String id, Expression expression) throws
    InvalidVariableException, InvalidTypeException, InvalidFunctionException {};

  public Variable findVariableByIdentifier(String variableName) {};

  public void validateVariableName(String variableName) throws InvalidVariableException {};

  public void addSupertype(String className, String superClassName) throws InvalidTypeException {};

  private void checkTestingExpression(Expression le, String operator,Expression re) throws InvalidOperatorException, InvalidOperationException {};

  public boolean verifyCall(String funcName, ArrayList<Expression> args) throws InvalidFunctionCallException {};

  /* Auxiliary functions */

  public void addVariableToTempList(Variable var) {};

  public CodeGenerator getCodeGenerator() {};

  public void setCurrentOperator(boolean newCurrentOperator){};

  public void generateBaseOpCode(String op, Expression e1, Expression e2) {};

  private Operation getOperator(String op) {};




};
