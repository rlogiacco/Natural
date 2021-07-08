package org.agileware.natural.cucumber.ui;

import org.agileware.natural.stepmatcher.ui.JavaElementChangeReporter;
import org.eclipse.jdt.core.ElementChangedEvent;
import org.eclipse.jdt.core.JavaCore;

import com.google.inject.Inject;

@SuppressWarnings("unused")
public class CucumberActivator extends org.agileware.natural.cucumber.ui.internal.CucumberActivator {

	@Inject
	public void setJavaElementChangeReporter(final JavaElementChangeReporter reporter) {
		// Listen to Java class changes
		JavaCore.addElementChangedListener(reporter, ElementChangedEvent.POST_CHANGE);
	}
}
