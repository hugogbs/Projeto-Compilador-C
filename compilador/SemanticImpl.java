import java.util.*;
public class SemanticImpl {
  private List<Type> secondaryTypes = new ArrayList<Type>();

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
	}

  public boolean checkValidExistingType(Type type) {
		return BASIC_TYPES.contains(type) || secondaryTypes.contains(type);
	}
  public void addType(Type type) {
		if (!secondaryTypes.contains(type)) {
			secondaryTypes.add(type);
			List<String> tipos = new ArrayList<String>();
			tipos.add(type.getName());
			tiposCompativeis.put(type.getName(), tipos);
		}
	}

}
