package org.agileware.natural.cucumber.ui.syntaxcoloring;

import java.util.regex.Pattern;

import org.eclipse.xtext.ui.editor.syntaxcoloring.AbstractAntlrTokenToAttributeIdMapper;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;

public class LexicalHighlightingCalculator extends
		AbstractAntlrTokenToAttributeIdMapper {

	private static final Pattern QUOTED = Pattern.compile("(?:^'([^']*)'$)|(?:^\"([^\"]*)\")$", Pattern.MULTILINE);
	
	private static final Pattern PUNCTUATION = Pattern.compile("\\p{Punct}*");
	
	@Override
	protected String calculateId(String tokenName, int tokenType) {
		if(PUNCTUATION.matcher(tokenName).matches()) {
			return DefaultHighlightingConfiguration.PUNCTUATION_ID;
		}
		if(QUOTED.matcher(tokenName).matches()) {
			return DefaultHighlightingConfiguration.KEYWORD_ID;
		}
		if("RULE_STRING".equals(tokenName)) {
			return DefaultHighlightingConfiguration.STRING_ID;
		}
		if("RULE_INT".equals(tokenName)) {
			return DefaultHighlightingConfiguration.NUMBER_ID;
		}
		if("RULE_ML_COMMENT".equals(tokenName) || "RULE_SL_COMMENT".equals(tokenName)) {
			return DefaultHighlightingConfiguration.COMMENT_ID;
		}
		if("RULE_STEP_KEYWORD".equals(tokenName)) {
			return HighlightingConfiguration.STEP_KEYWORD;
		}
		if("RULE_PLACEHOLDER".equals(tokenName)) {
			return HighlightingConfiguration.PLACEHOLDER;
		}
		if("RULE_TAGNAME".equals(tokenName)) {
			return HighlightingConfiguration.TAG;
		}
		if("RULE_DOC_STRING".equals(tokenName)) {
			return HighlightingConfiguration.DOC_STRING;
		}
		if("RULE_TABLE_ROW".equals(tokenName)) {
			return HighlightingConfiguration.TABLE;
		}
		return DefaultHighlightingConfiguration.DEFAULT_ID;
	}

}
