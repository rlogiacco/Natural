package org.agileware.natural.cucumber.ui.syntaxcoloring;

import java.util.regex.Pattern;

import org.eclipse.xtext.ide.editor.syntaxcoloring.HighlightingStyles;
import org.eclipse.xtext.ui.editor.syntaxcoloring.AbstractAntlrTokenToAttributeIdMapper;

public class LexicalHighlightingCalculator extends AbstractAntlrTokenToAttributeIdMapper {

	private static final Pattern QUOTED = Pattern.compile("(?:^'([^']*)'$)|(?:^\"([^\"]*)\")$", Pattern.MULTILINE);

	@Override
	protected String calculateId(final String tokenName, final int tokenType) {
		if ("'|'".equals(tokenName)) {
			return HighlightingConfiguration.TABLE_ID;
		}
		if (QUOTED.matcher(tokenName).matches()) {
			return HighlightingStyles.KEYWORD_ID;
		}
		if ("RULE_STRING".equals(tokenName)) {
			return HighlightingStyles.STRING_ID;
		}
		if ("RULE_NUMBER".equals(tokenName)) {
			return HighlightingStyles.NUMBER_ID;
		}
		if ("RULE_SL_COMMENT".equals(tokenName)) {
			return HighlightingStyles.COMMENT_ID;
		}
		if ("RULE_TAG".equals(tokenName)) {
			return HighlightingConfiguration.TAG_ID;
		}
		if ("RULE_DOC_STRING_LITERAL".equals(tokenName)) {
			return HighlightingConfiguration.DOC_STRING_ID;
		}
		if ("RULE_TABLE_CELL".equals(tokenName)) {
			return HighlightingConfiguration.TABLE_ID;
		}
		if ("RULE_STEP_KEYWORD".equals(tokenName)) {
			return HighlightingStyles.KEYWORD_ID;
		}
		if ("RULE_PLACEHOLDER".equals(tokenName)) {
			return HighlightingConfiguration.PLACEHOLDER_ID;
		}

		return HighlightingStyles.DEFAULT_ID;
	}
}
