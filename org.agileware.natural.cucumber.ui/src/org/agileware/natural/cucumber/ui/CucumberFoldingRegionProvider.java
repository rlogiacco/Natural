package org.agileware.natural.cucumber.ui;

import java.util.Collection;

import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.ui.editor.folding.DefaultFoldingRegionProvider;
import org.eclipse.xtext.ui.editor.folding.FoldedPosition;
import org.eclipse.xtext.ui.editor.model.IXtextDocument;

public class CucumberFoldingRegionProvider extends DefaultFoldingRegionProvider {

	@Override
	protected Collection<FoldedPosition> doGetFoldingRegions(
			IXtextDocument xtextDocument, XtextResource xtextResource) {
		// TODO Auto-generated method stub
		return super.doGetFoldingRegions(xtextDocument, xtextResource);
	}

}
