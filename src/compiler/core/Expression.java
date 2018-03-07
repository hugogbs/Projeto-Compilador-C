package compiler.core;

import compiler.util.*;

public class Expression {
	private Type type;
	private String value;
	private String context;
	private Register register;
	private boolean returnFlag;
	
	public Expression(Type t) {
		this.type = t;
		this.returnFlag = false;
	}
	
	public Expression(String name) {
		type = new Type("UNKNOWN");
		this.returnFlag = false;
	}
	
	public Expression(Type t, String value) {
		this.type = t;
		this.value = value;
		this.context = "";
		this.returnFlag = false;
	}
	
	public Type getType() {
		return type;
	}

	public void setReturn(boolean returnFlag) {
		this.returnFlag = returnFlag;
	}

	public boolean isReturn() {
		return returnFlag;
	}
	
	public String getValue() {
		return value;
	}
	
	public String getContext(){
		return this.context;
	}
	
	public void setContext(String context){
		this.context = context;
	}
	
	public void setRegister(Register register) {
		this. register = register;
	}
	
	public Register getRegister() {
		return register;
	}
	
	public boolean isNumeric() {
		return  getType().getName().equals("int")
				||getType().getName().equals("float")
				||getType().getName().equals("long")
				||getType().getName().equals("double");
	}
	
	public String toString(){
		return "Expression of type; " + getType();
	}

	public void setAssemblyValue(String value) {
		this.value = value;
	}

	public String getAssemblyValue() {
		return this.value;
	}

	public static Type getTypeNumber(String number) {
		if (number.contains(".")) {
			return new Type("float");
		}
		return new Type("int");
	}

	public static Object convertNumber(String number) {
		if (number.contains(".")) {
			return Float.parseFloat(number);
		}
		return Integer.parseInt(number);
	}
}
