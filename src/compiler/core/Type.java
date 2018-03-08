package compiler.core;


public class Type implements Parameter {

	private String typeName;

	public Type(String typeName) {
		this.typeName = typeName;
	}

	public String getName() {
		return this.typeName;
	}

	public boolean equals(Object obj) {
		if (!(obj instanceof Type))
			return false;
		return this.getName().toLowerCase().equals(((Type) obj).getName().toLowerCase());
	}
	
	@Override
	public String toString(){
		return getName();
	}

	@Override
	public Type getType() {
		return this;
	}

	@Override
	public String getIdentifier() {
		return getName();
	}
}