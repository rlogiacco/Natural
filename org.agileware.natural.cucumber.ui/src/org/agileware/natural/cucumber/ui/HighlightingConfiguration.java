package org.agileware.natural.cucumber.ui;

import org.eclipse.swt.SWT;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor;
import org.eclipse.xtext.ui.editor.utils.TextStyle;

public class HighlightingConfiguration extends
		DefaultHighlightingConfiguration {

	public static final String STEP_KEYWORD = "stepCondition";
	public static final String TAG = "tag";
	public static final String TABLE = "table";
	public static final String PLACEHOLDER = "placeholder";
	public static final String DOC_STRING = "docstring";

	@Override
	public void configure(IHighlightingConfigurationAcceptor acceptor) {
		super.configure(acceptor);
		acceptor.acceptDefaultHighlighting(STEP_KEYWORD, "Step Condition", stepKeywordTextStyle());
		acceptor.acceptDefaultHighlighting(TAG, "Tag", tagTextStyle());
		acceptor.acceptDefaultHighlighting(TABLE, "Table", super.numberTextStyle());
		acceptor.acceptDefaultHighlighting(PLACEHOLDER, "Placeholder", tagTextStyle());
		acceptor.acceptDefaultHighlighting(DOC_STRING, "Doc String", super.numberTextStyle());
	}

	public TextStyle stepKeywordTextStyle() {
		TextStyle textStyle = super.keywordTextStyle();
		textStyle.setStyle(SWT.ITALIC);
		return textStyle;
	}
	
	public TextStyle tagTextStyle() {
		TextStyle textStyle = super.numberTextStyle();
		textStyle.setStyle(SWT.ITALIC);
		return textStyle;
	}
}
