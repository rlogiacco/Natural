package org.agileware.natural.cucumber;

import org.eclipse.xtext.diagnostics.Diagnostic;
import org.eclipse.xtext.nodemodel.SyntaxErrorMessage;
import org.eclipse.xtext.parser.antlr.ISyntaxErrorMessageProvider;

public class SyntaxErrorMessageProvider implements ISyntaxErrorMessageProvider {

	public SyntaxErrorMessage getSyntaxErrorMessage(IParserErrorContext context) {
		return new SyntaxErrorMessage("Questo non e` lavoro per Augusto Evangelisti", Diagnostic.SYNTAX_DIAGNOSTIC);
	}

	public SyntaxErrorMessage getSyntaxErrorMessage(IValueConverterErrorContext context) {
		return new SyntaxErrorMessage("Questo non e` lavoro per Augusto Evangelisti", Diagnostic.SYNTAX_DIAGNOSTIC);
	}

}
