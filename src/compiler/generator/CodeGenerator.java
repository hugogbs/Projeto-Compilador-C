package compiler.generator;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.invoke.SwitchPoint;
import java.util.HashMap;
import java.util.Map;

import com.sun.org.apache.bcel.internal.classfile.Code;
import compiler.core.Expression;
import compiler.core.Function;
import compiler.core.Type;
import compiler.core.Variable;
import compiler.util.Register;

public class CodeGenerator {

	private int labels;
	private int register;
	private int lastRegisterUsed;
	private String assemblyCode;
	private Register[] registers;
	private Map<String, Integer> functionAddres;
	private static CodeGenerator codeGen;

	public CodeGenerator() {
		this.labels = 100;
		this.register = 0;
		this.lastRegisterUsed = 0;
		this.registers = Register.values();
		this.assemblyCode = initAssemblyCode();
		this.functionAddres = new HashMap<String, Integer>();
	}

	public static CodeGenerator getInstance() {
		if (codeGen == null) {
			codeGen = new CodeGenerator();
		}
		return codeGen;
	}
	private String initAssemblyCode() {
		return "100: LD SP, #6000\n";
	}

	public void assignmentDeclaration(Variable var, Object obj) {
		if (obj instanceof Expression) {
			generateSTCode(var);
		}
		if (obj instanceof Function) {
			Function f = (Function) obj;
			generateLDCode(new Expression(f.getName()));
			generateSTCode(var);
		}
		System.out.println(assemblyCode);
	}
	/*ADD CODE */

	public void generateADDCode() {  /*pq sem? Amiga nem sei*/
		labels += 8;

		Register one = registers[register - 1];
		Register two = allocateRegister();

		register++;
		Register result = allocateRegister();
		addCode(labels + ": ADD " + result + ", " + one + ", " + two);
	}
	public void generateADDCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": ADD " + result + ", " + r1 + ", " + r2);
	}

	public void generateADDCode(Register result, Register one, Register two) {
		labels += 8;
		addCode(labels + ": ADD " + result + ", " + one + ", " + two);
	}

	public void generateADDCode(Register result, Register one, Expression exp) { /*exp? se sim, pq só o primeiro é registrador?
																					Cagação, parece estar errado, mas talvez n esteja*/
		labels += 8;
		addCode(labels + ": ADD " + result + ", " + one + ", #" + exp.getAssemblyValue());
	}

	/*SUB CODE*/

	public void generateSUBCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": SUB " + result + ", " + r1 + ", " + r2);
	}

	public void generateSUBCode(Register result, Register one, Expression exp) {
		labels += 8;
		addCode(labels + ": SUB " + result + ", " + one + ", #" + exp.getAssemblyValue());
	}

	public void generateSUBCode(Register result, Register one, Register two) {
		labels += 8;
		addCode(labels + ": SUB " + result + ", " + one + ", " + two);
	}

	/*MUL CODE*/
	public void generateMULCode() { /*sem parm again*/
		labels += 8;

		Register one = registers[register - 1];
		Register two = allocateRegister();

		register++;
		Register result = allocateRegister();
		addCode(labels + ": MUL " + result + ", " + one + ", " + two);
	}

	public void generateMULCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": MUL " + result + ", " + r1 + ", " + r2);
	}

	public void generateMULCode(Register result, Register one, Expression exp) {
		labels += 8;
		addCode(labels + ": MUL " + result + ", " + one + ", #" + exp.getValue());
	}

	public void generateMULNegativeCode() {
		labels += 8;

		Register one = allocateRegister();

		register++;
		Register result = allocateRegister();
		addCode(labels + ": MUL " + result + ", " + one + ", #-1");
	}

	/*DIV CODE*/
	public void generateDIVCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": DIV " + result + ", " + r1 + ", " + r2);
	}

	/*AND CODE*/
	public void generateANDCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": AND " + result + ", " + r1 + ", " + r2);
	}

	/*OR CODE*/
	public void generateORCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": OR " + result + ", " + r1 + ", " + r2);
	}

	/*XOR CODE*/
	public void generateXORCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": XOR " + result + ", " + r1 + ", " + r2);
	}

	public void generateBaseNOTCode(Register r1) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": XOR " + result + ", " + r1 + ", #true");
	}

	/*MOD CODE*/
	public void generateMODCode(Register r1, Register r2) {
		labels += 8;

		register++;
		Register result = allocateRegister();
		addCode(labels + ": MOD " + result + ", " + r1 + ", " + r2);
	}

	/*EQ CODE*/
	public void generateANDEQCode(Register r1, Expression e) {
		generateANDCode(r1, e.getRegister());
		generateSTCode(r1, e);
	}

	public void generateOREQCode(Register r1, Expression e) {
		generateORCode(r1, e.getRegister());
		generateSTCode(r1, e);
	}

	public void generateXOREQCode(Expression e1, Expression e2) {
		generateXORCode(e2.getRegister(), e2.getRegister());
		generateSTCode(e1);
	}

	public void generateDIVEQCode(Expression e1, Expression e2) {
		generateLDCode(e1);
		generateDIVCode(e1.getRegister(), e2.getRegister());
		generateSTCode(e1);
	}

	public void generateMODEQCode(Register r1, Expression e) {
		generateMODCode(r1, e.getRegister());
		generateSTCode(r1, e);
	}

	public void generateADDEQCode(Expression e1, Expression e2) {
		generateMODCode(e1.getRegister(), e2.getRegister());
		generateSTCode(e1);
	}

	/*NOT CODE*/
	public void generateNOTCode() {
		generateBEQZCode(4);
		generateMULCode(Register.R2, Register.R1, new Expression(new Type("int"), "-1"));
		generateADDCode(Register.R1, Register.R1, Register.R2);
		generateBRCode(2);
		generateADDCode(Register.R1, Register.R1, new Expression(new Type("int"), "1"));
	}

	/*BRANCH CODE*/
	public void generateBEQZCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;

		Register current = allocateRegister();
		addCode(labels + ": BEQZ " + current + ", " + jump);
	}

	public void generateBNEQZCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;

		Register current = allocateRegister();
		addCode(labels + ": BNEQZ " + current + ", " + jump);
	}

	public void generateBNEQZCodeCase() {
		Expression e = new Expression("int");
		e.setAssemblyValue("0");
		generateLDCode(e);
		labels += 8;

		Register one = registers[register - 1];
		Register two = allocateRegister();
		addCode(labels + ": BNE " + one + ", " + two + ", #caseEnd");
	}

	public void generateBGEQZCode(Register e,int br) {
		if(Integer.parseInt(e.getValue()) >= 0){
			labels += 8;
			int jump = (br * 8) + labels;

			Register current = allocateRegister();
			addCode(labels + ": BGEQZ " + current + ", " + jump);
		}
	}

	public void generateBLEQZCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;

		Register current = allocateRegister();
		addCode(labels + ": BLEQZ " + current + ", " + jump);
	}

	public void generateBLTZCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;

		Register current = allocateRegister();
		addCode(labels + ": BLTZ " + current + ", " + jump);
	}

	public void generateBGTZCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;

		Register current = allocateRegister();
		addCode(labels + ": BGTZ " + current + ", " + jump);
	}

	public void generateBRCode(int br) {
		labels += 8;
		int jump = (br * 8) + labels;
		addCode(labels + ": BR " + jump);
	}
	public void generateBRCode(Integer address) {
		labels += 8;
		addCode(labels + ": BR " + address);
	}

	public void generateBRCode(Register register) {
		labels += 8;
		addCode(labels + ": BR " + register);
	}

	/*LOAD CODE*/
	public Register generateLDCode(Expression expression) {
		Register r = null;
		if (expression.getAssemblyValue() != null) {
			register++;
			labels += 8;
			r = allocateRegister();
			addCode(labels + ": LD " + r + ", " + expression.getAssemblyValue());
			expression.setRegister(r);
		}
		return r;
	}

	public Register generateLDCode(Variable var) {
		Register r = null;
		if (var.getIdentifier() != null) {
			register++;
			labels += 8;
			r = allocateRegister();
			addCode(labels + ": LD " + r + ", " + var.getIdentifier());
			var.setRegister(r);
		}
		return r;
	}

	public Register generateLDCode(Register r, Expression expression) {
		if (expression.getAssemblyValue() != null) {
			labels += 8;
			addCode(labels + ": LD " + r + ", #" + expression.getAssemblyValue());
			expression.setRegister(r);
		}
		return r;
	}

	/*STORE CODE*/
	public void generateSTCode(Variable variable) {
		labels += 8;
		addCode(labels + ": ST " + variable.getIdentifier() + ", " + allocateRegister());
		this.register = this.lastRegisterUsed;
	}

	public void generateSTCode(Register one, Expression exp) {
		labels += 8;
		addCode(labels + ": ST " + one + ", " + exp.getAssemblyValue());
		this.register = this.lastRegisterUsed;
	}

	public void generateSTCode(Expression exp) {
		labels += 8;
		addCode(labels + ": ST " + exp.getAssemblyValue() + ", " + allocateRegister());
		this.register = this.lastRegisterUsed;
	}

	/* FOR CODE*/

	public void generateFORCode(Expression e1, Expression e2,Expression e3, Expression e4){ // e1: a=1 e2: a<10 e3: a = a+1 e4: o q ta dentro do for
		labels += 8;
		Register r1 = registers[register - 1];
		Register r2 = allocateRegister();

		register++;
		Register r3 = allocateRegister();
		register++;
		Register result = allocateRegister();

		generateLDCode(r1,e1);
		generateLDCode(r2,e2);
		generateLDCode(r3,e3);
		generateSUBCode(result,r1,r2);
		generateBGEQZCode(result,8);
		generateADDCode(r1,r1,r3);
		generateBRCode(4);
		generateHalt();

	}

	///////////////////////////////////////////////////////////////////////////////////

	public void addCode(String assemblyString) {
		assemblyCode += assemblyString + "\n";
		System.out.println("############################################### \n");
		System.out.println(getAssemblyCode());
		System.out.println("############################################### \n");
	}

	public void generateCallFunction(String functionName) {
		Expression blockSize = new Expression("size");
		Integer addressFunction = functionAddres.get(functionName);

		generateADDCode(Register.SP, Register.SP, blockSize);

		int jump = (3 * 8) + labels;
		generateSTCode(Register._SP, new Expression(new Type("int"), Integer.toString(jump)));
		generateBRCode(addressFunction);
		generateSUBCode(Register._SP, Register.SP, blockSize);
	}

	public void generateHalt() {
		labels += 8;
		addCode(labels + ": HALT\n");
	}

	public String getAssemblyCode() {
		return assemblyCode;
	}

	public void addFunctionAddress(String name) {
		labels += 300;
		functionAddres.put(name, labels + 8);
		addCode("\n");
	}

	public void StorageReturnedType(Function function, Expression returnedExpression) {
		if (returnedExpression.getValue() != null) {
			generateLDCode(returnedExpression);
			generateSTCode(new Expression(function.getName()));

			if(function.getName().equals("main")){
				generateHalt();
			} else {
				generateBRCode(Register._SP);
			}
		} else {
			if (returnedExpression.getValue() != null) {
				generateLDCode(returnedExpression);
				generateSTCode(new Expression(function.getName()));
			} else {
				generateSTCode(new Expression(function.getName()));
			}
			generateBRCode(Register._SP);
		}
	}

	public Register getLastRegister() {
		return allocateRegister();
	}

	public Register allocateRegister(){
		try {
			Register allocated = registers[register];
			return allocated;
		} catch (Exception e) {
			register++;
			return allocateRegister();
		}
	}

	public void lastRegisterUsed(int register) {
		this.lastRegisterUsed = register;
	}

	public int getLabels(){
		return labels;
	}

	public void generateFinalAssemblyCode() throws IOException {
		BufferedWriter writer = new BufferedWriter(new FileWriter(new File("assembly.txt")));
		writer.write(assemblyCode);
		writer.close();
	}

}
