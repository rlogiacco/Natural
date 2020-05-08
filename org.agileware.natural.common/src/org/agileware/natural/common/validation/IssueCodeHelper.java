package org.agileware.natural.common.validation;

import java.util.Formatter;
import java.util.Locale;

public class IssueCodeHelper {
	static private final String PREFIX = "org.agileware.natural.cucumber.";

	private final Formatter formatter;

	private final String message;

	public String codeFor(Object self) {
		return PREFIX + self.toString();
	}

	public String message(Object... tokens) {
		return formatter.format(this.message, tokens).toString();
	}

	public IssueCodeHelper(String message) {
		this.message = message;
		this.formatter = new Formatter(new StringBuilder(), Locale.US);
	}
}
