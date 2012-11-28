package org.agileware.natural.cucumber.ui.syntaxcoloring;

import java.util.regex.Pattern;

import org.eclipse.xtext.ui.editor.syntaxcoloring.AbstractAntlrTokenToAttributeIdMapper;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;

public class LexicalHighlightingCalculator extends
		AbstractAntlrTokenToAttributeIdMapper {

	private static final Pattern QUOTED = Pattern.compile("(?:^'([^']*)'$)|(?:^\"([^\"]*)\")$", Pattern.MULTILINE);
	
	@Override
	protected String calculateId(String tokenName, int tokenType) {
		if(QUOTED.matcher(tokenName).matches()) {
			return DefaultHighlightingConfiguration.KEYWORD_ID;
		}
		if("RULE_STRING".equals(tokenName)) {
			return DefaultHighlightingConfiguration.STRING_ID;
		}
		if("RULE_INT".equals(tokenName)) {
			return DefaultHighlightingConfiguration.NUMBER_ID;
		}
		if("RULE_SL_COMMENT".equals(tokenName)) {
			return DefaultHighlightingConfiguration.COMMENT_ID;
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
