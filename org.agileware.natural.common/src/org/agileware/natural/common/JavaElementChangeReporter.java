package org.agileware.natural.common;

import java.util.List;

import org.eclipse.jdt.core.ElementChangedEvent;
import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IElementChangedListener;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IJavaElementDelta;

import com.google.inject.Inject;

public class JavaElementChangeReporter implements IElementChangedListener {
	
	@Inject
	private JavaAnnotationMatcher matcher;
	
	@Override
	public void elementChanged(ElementChangedEvent event) {
		traverse(event.getDelta(), null);
	}

	void traverse(IJavaElementDelta delta, List<JavaHyperlink> hyperlinks) {
		if (delta.getElement().getElementType() == IJavaElement.COMPILATION_UNIT) {
			if ((delta.getFlags() & IJavaElementDelta.F_PRIMARY_RESOURCE) > 0) {
				matcher.evict((ICompilationUnit)delta.getElement());
			}
		}
		for (IJavaElementDelta child : delta.getAffectedChildren()) {
			this.traverse(child, hyperlinks);
		}
	}
}