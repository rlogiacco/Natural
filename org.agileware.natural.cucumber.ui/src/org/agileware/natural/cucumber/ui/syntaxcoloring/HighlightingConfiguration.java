package org.agileware.natural.cucumber.ui.syntaxcoloring;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor;
import org.eclipse.xtext.ui.editor.utils.TextStyle;

public class HighlightingConfiguration implements IHighlightingConfiguration {

	public static final String STEP_KEYWORD = "stepCondition";
	public static final String TAG = "tag";
	public static final String TABLE = "table";
	public static final String PLACEHOLDER = "placeholder";
	public static final String DOC_STRING = "docstring";
	public static final String KEYWORD_ID = "keyword";
	public static final String COMMENT_ID = "comment";
	public static final String STRING_ID = "string";
	public static final String NUMBER_ID = "number";
	public static final String DEFAULT_ID = "default";
	public static final String INVALID_TOKEN_ID = "error";

	public void configure(IHighlightingConfigurationAcceptor acceptor) {
		acceptor.acceptDefaultHighlighting(KEYWORD_ID, "Keyword", keywordTextStyle());
		acceptor.acceptDefaultHighlighting(COMMENT_ID, "Comment", commentTextStyle());
		acceptor.acceptDefaultHighlighting(STRING_ID, "String", stringTextStyle());
		acceptor.acceptDefaultHighlighting(NUMBER_ID, "Number", numberTextStyle());
		acceptor.acceptDefaultHighlighting(DEFAULT_ID, "Default", defaultTextStyle());
		acceptor.acceptDefaultHighlighting(INVALID_TOKEN_ID, "Invalid Symbol", errorTextStyle());
		// Gherkin
		acceptor.acceptDefaultHighlighting(STEP_KEYWORD, "Step Condition", stepKeywordTextStyle());
		acceptor.acceptDefaultHighlighting(TAG, "Tag", tagTextStyle());
		acceptor.acceptDefaultHighlighting(TABLE, "Table", numberTextStyle());
		acceptor.acceptDefaultHighlighting(PLACEHOLDER, "Placeholder", tagTextStyle());
		acceptor.acceptDefaultHighlighting(DOC_STRING, "Doc String", numberTextStyle());
	}

	public TextStyle defaultTextStyle() {
		TextStyle textStyle = new TextStyle();
		// textStyle.setBackgroundColor(new RGB(255, 255, 255));
		textStyle.setColor(new RGB(0, 0, 0));
		return textStyle;
	}

	public TextStyle errorTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		// textStyle.setColor(new RGB(255, 0, 0));
		return textStyle;
	}

	public TextStyle numberTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(125, 125, 125));
		return textStyle;
	}

	public TextStyle stringTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(42, 0, 255));
		return textStyle;
	}

	public TextStyle commentTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(63, 127, 95));
		return textStyle;
	}

	public TextStyle keywordTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(127, 0, 85));
		textStyle.setStyle(SWT.BOLD);
		return textStyle;
	}

	public TextStyle stepKeywordTextStyle() {
		TextStyle textStyle = keywordTextStyle();
		textStyle.setStyle(SWT.ITALIC);
		return textStyle;
	}

	public TextStyle tagTextStyle() {
		TextStyle textStyle = numberTextStyle();
		textStyle.setStyle(SWT.ITALIC);
		return textStyle;
	}
}
