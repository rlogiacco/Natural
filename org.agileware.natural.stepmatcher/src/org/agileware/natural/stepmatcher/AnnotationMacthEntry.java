package org.agileware.natural.stepmatcher;

public class AnnotationMacthEntry {

	private final String keyword;
	private final String description;
	private final String typeName;
	private final String methodSignature;

	public String getKeyword() {
		return keyword;
	}

	public String getDescription() {
		return description;
	}

	public String getTypeName() {
		return typeName;
	}

	public String getMethodSignature() {
		return methodSignature;
	}

	public AnnotationMacthEntry(final String keyword, final String description, final String typeName,
			final String methodSignature) {
		super();
		this.keyword = keyword;
		this.description = description;
		this.typeName = typeName;
		this.methodSignature = methodSignature;
	}
}
