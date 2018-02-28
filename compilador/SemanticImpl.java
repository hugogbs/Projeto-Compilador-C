import java.util.*;
public class SemanticImpl {

  private List<Type> secondaryTypes = new ArrayList<Type>();
  private static List<Type> BASIC_TYPES;
  static CodeGenerator codeGenerator;
  private static String currentOperator;


  public static SemanticImpl getInstance() {};

  private static void initCollections() {};

  public int getBlockSize() {};

  public void incBlockSize() {};

  public void resetBlockSize() {};

  protected SemanticImpl() {};

  /* tipos básicos da linguagem */
  private static void initBasicTypes() {
		BASIC_TYPES = new ArrayList<Type>() {
			{
				add(new Type("int")); //
				add(new Type("float")); //
				add(new Type("double")); //
        add(new Type("short")); //
        add(new Type("unsigned"));
        add(new Type("signed")); //
				add(new Type("long")); //
				add(new Type("char")); //
				add(new Type("void")); //
				add(new Type("String"));
				add(new Type("Object"));
				add(new Type("Integer"));
			}
		};
	};

  /*add um novo tipo*/
  public void addType(Type type) {
		if (!secondaryTypes.contains(type)) {
			secondaryTypes.add(type);
			List<String> tipos = new ArrayList<String>();
			tipos.add(type.getName());
			tiposCompativeis.put(type.getName(), tipos);
		};
	};

  private static void initTypeCompatibility() {};

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

  public boolean checkTypeCompatibility(Type leftType, Type rightType) {};

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

  public void addVariableToTempList(Variable var) {
    tempVariables.add(var);
  };

  public CodeGenerator getCodeGenerator() {
    return codeGenerator;
  };

  public void setCurrentOperator(boolean newCurrentOperator){
    currentOperator = newCurrentOperator+"";
  };

  public void generateBaseOpCode(String op, Expression e1, Expression e2) {
    //System.out.println(op);
    Operation operator = getOperator(op);
    switch(operator){
      case PLUS:
        codeGenerator.generatePLUSCode(e1.getRegister(), e2.getRegister());
        break;
      case MINUS:
        codeGenerator.generateMINUSCode(e1.getRegister(), e2.getRegister());
        break;
      case STAR:
        codeGenerator.generateMULTCode(e1.getRegister(), e2.getRegister());
        break;
      case BAR:
        codeGenerator.generateDIVCode(e1.getRegister(), e2.getRegister());
        break;
      case AND_OP:
        codeGenerator.generateANDCode(e1.getRegister(), e2.getRegister());
        break;
      case OR_OP:
        codeGenerator.generateORCode(e1.getRegister(), e2.getRegister());
        break;
      case EQ_OP:
        codeGenerator.generateEQCode(e1.getRegister(), e2.getRegister());
        break;
      case NE_OP:
        codeGenerator.generateNECode(e1.getRegister(), e2.getRegister());
        break;
      case LE_OP:
        codeGenerator.generateLECode(e1.getRegister(), e2.getRegister());
        break;
      case LT:
        codeGenerator.generateLTCode(e1.getRegister(), e2.getRegister());
        break;
      case GE_OP:
        codeGenerator.generateGECode(e1.getRegister(), e2.getRegister());
        break;
      case GT:
        codeGenerator.generateGTCode(e1.getRegister(), e2.getRegister());
        break;
      case EQUALS:
        codeGenerator.generateSTCode(e1);
        break;
      case ADD_ASSIGN:
        codeGenerator.generateANDACode(e1, e2);
        break;
      case SUB_ASSIGN:
        codeGenerator.generateSUBACode(e1.getRegister(), e2.getRegister());
        break;
      case MUL_ASSIGN:
        codeGenerator.generateMULACode(e1.getRegister(), e2.getRegister());
        break;
      case DIV_ASSIGN:
        codeGenerator.generateDIVACode(e1, e2);
        break;
      case MOD_ASSIGN:
        codeGenerator.generateMODACode(e1.getRegister(), e2);
        break;
      case AND_ASSIGN:
        codeGenerator.generateANDACode(e1.getRegister(), e2); //tem or equals nao?
        break;
      case XOR_ASSIGN:
        codeGenerator.generateXORACode(e1, e2);
        break;
      default:
              break;
    }
  };

  private Operation getOperator(String op) {
    switch(op){
      case "+":
        return Operation.PLUS;
      case "-":
        return Operation.MINUS;
      case "*":
        return Operation.STAR; /*mudar esse nome?*/
      case "/":
        return Operation.BAR;
      case "%":
        return Operation.PERC;
      case "!":
        return Operation.EXCLA;
      case "&&":
        return Operation.AND_OP;
      case "||":
        return Operation.OR_OP;
      case "==":
        return Operation.EQ_OP;
      case "!=":
        return Operation.NE_OP;
      case "<=":
        return Operation.LE_OP;
      case "<":
        return Operation.LT;
      case ">=":
        return Operation.GE_OP;
      case ">":
        return Operation.GT;
      case "=":
        return Operation.EQUALS;
      case "+=":
        return Operation.ADD_ASSIGN;
      case "-=":
        return Operation.SUB_ASSIGN;
      case "*=":
        return Operation.MUL_ASSIGN;
      case "/=":
        return Operation.DIV_ASSIGN;
      case "%=":
        return Operation.MOD_ASSIGN;
      case "&=":
        return Operation.AND_ASSIGN;
      case "^=":
        return Operation.XOR_ASSIGN;
      case "&":
        return Operation.AND;
      case "|":
        return Operation.PIPE;
      case "~":
        return Operation.TIL;
      case "^":
        return Operation.CARET;
      case "<<":
        return Operation.LEFT_OP;
      case ">>":
        return Operation.RIGHT_OP;
      case "++":
        return Operation.INC_OP;
      case "--":
        return Operation.DEC_OP;
      case "...":
        return Operation.ELLIPSIS;
      case ">>=":
        return Operation.RIGHT_ASSIGN;
      case "<<=":
        return Operation.LEFT_ASSIGN;
      case "|=":
        return Operation.OR_ASSIGN;
      case "->":
        return Operation.PTR_OP;
      case ":":
        return Operation.DDOT;
      case ",":
        return Operation.COMMA;
      case ";":
        return Operation.SEMICOLON;
      case ".":
        return Operation.DOT;
      case "?":
        return Operation.INTER;
      default:
        return Operation.PLUS;
    }
  };




};
