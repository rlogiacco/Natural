package org.rlogiacco.eclipse.cucumber.ui;

import org.eclipse.jdt.core.ElementChangedEvent;
import org.eclipse.jdt.core.JavaCore;
import org.rlogiacco.eclipse.bdd.common.AbstractAnnotationDescriptor;
import org.rlogiacco.eclipse.bdd.common.JavaElementChangeReporter;
import org.rlogiacco.eclipse.bdd.common.JavaHyperlinkCache;

import com.google.inject.Inject;

@SuppressWarnings("unused")
public class CucumberDSLActivator extends org.rlogiacco.eclipse.cucumber.ui.internal.CucumberDSLActivator {
	
	@Inject
	private JavaHyperlinkCache hyperlinkCache;
	
	@Inject 
	private AbstractAnnotationDescriptor annotationDescriptor;
	
	@Inject
	public void setJavaElementChangeReporter(JavaElementChangeReporter reporter) {
		// Listen to Java class changes
		// TODO JavaCore.addElementChangedListener(reporter, ElementChangedEvent.POST_RECONCILE);
	}
}
