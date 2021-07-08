package org.agileware.natural.cucumber.ui.syntaxcoloring;

import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.RGB;
import org.eclipse.xtext.ui.editor.syntaxcoloring.DefaultHighlightingConfiguration;
import org.eclipse.xtext.ui.editor.syntaxcoloring.IHighlightingConfigurationAcceptor;
import org.eclipse.xtext.ui.editor.utils.TextStyle;

public class HighlightingConfiguration extends DefaultHighlightingConfiguration {

	public static final String TAG_ID = "tag";

	public static final String TABLE_ID = "table";

	public static final String PLACEHOLDER_ID = "placeholder";
	
	public static final String DOC_STRING_ID = "docstring";

	@Override
	public void configure(IHighlightingConfigurationAcceptor acceptor) {
		acceptor.acceptDefaultHighlighting(TAG_ID, "Tag", tagTextStyle());
		acceptor.acceptDefaultHighlighting(TABLE_ID, "Table", tableTextStyle());
		acceptor.acceptDefaultHighlighting(PLACEHOLDER_ID, "Placeholder", placeholderTextStyle());
		acceptor.acceptDefaultHighlighting(DOC_STRING_ID, "DocString", docStringTextStyle());

		super.configure(acceptor);
	}

	@Override
	public TextStyle numberTextStyle() {
		TextStyle textStyle = stringTextStyle().copy();
		return textStyle;
	}
	
	public TextStyle placeholderTextStyle() {
		TextStyle textStyle = stringTextStyle().copy();
		return textStyle;
	}
	
	public TextStyle docStringTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(125, 125, 125));
		return textStyle;
	}

	public TextStyle tableTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(125, 125, 125));
		return textStyle;
	}

	public TextStyle tagTextStyle() {
		TextStyle textStyle = defaultTextStyle().copy();
		textStyle.setColor(new RGB(125, 125, 125));
		textStyle.setStyle(SWT.ITALIC);
		return textStyle;
	}
}
