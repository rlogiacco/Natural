package org.rlogiacco.eclipse.bdd.common;

import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.core.ElementChangedEvent;
import org.eclipse.jdt.core.ICompilationUnit;
import org.eclipse.jdt.core.IElementChangedListener;
import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IJavaElementDelta;

import com.google.inject.Inject;

public class JavaElementChangeReporter implements IElementChangedListener {

	@Inject
	private JavaHyperlinkCache hyperlinkCache;
	
	@Inject 
	private AbstractAnnotationDescriptor annotationDescriptor;
	
	public JavaElementChangeReporter(){}
	
	@Override
	public void elementChanged(ElementChangedEvent event) {
		traverse(event.getDelta(), null);
	}

	void traverse(IJavaElementDelta delta, List<JavaHyperlink> hyperlinks) {
		if (delta.getElement().getElementType() == IJavaElement.COMPILATION_UNIT) {
			switch (delta.getKind()) {
			case IJavaElementDelta.ADDED:
			case IJavaElementDelta.CHANGED:
				if (hyperlinkCache.contains(((ICompilationUnit)delta.getElement()))) {
					hyperlinks = hyperlinkCache.get(((ICompilationUnit)delta.getElement()));
				} else if (hyperlinks == null) {
					hyperlinks = new ArrayList<JavaHyperlink>();
				}
				this.handleAnnotations(delta, hyperlinks);
				break;
			case IJavaElementDelta.REMOVED:
				hyperlinkCache.remove(((ICompilationUnit)delta.getElement()));
				break;
			}
		}
		for (IJavaElementDelta child : delta.getAffectedChildren()) {
			this.traverse(child, hyperlinks);
		}
	}
	
	protected void handleAnnotations(IJavaElementDelta delta, List<JavaHyperlink> hyperlinks) {
		for (IJavaElementDelta annotation : delta.getAnnotationDeltas()) {
			for (String name : annotationDescriptor.getNames()) {
				if (AbstractAnnotationDescriptor.checkSimpleName(annotation.getElement(), name) && AbstractAnnotationDescriptor.checkPackage(annotation.getElement(), annotationDescriptor.getPackage())) {
					System.out.println(delta.getElement().getElementName() + " was updated");
					break;
				}
			}
		}
		for (IJavaElementDelta child : delta.getAffectedChildren()) {
			this.handleAnnotations(child, hyperlinks);
		}
	}
}