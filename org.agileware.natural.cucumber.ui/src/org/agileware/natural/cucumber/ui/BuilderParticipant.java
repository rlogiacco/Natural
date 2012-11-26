package org.agileware.natural.cucumber.ui;

import org.agileware.natural.common.JavaAnnotationMatcher;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;

import com.google.inject.Inject;

public class BuilderParticipant extends org.eclipse.xtext.builder.BuilderParticipant {
	@Inject
	private JavaAnnotationMatcher matcher;
	
	public void build(final IBuildContext context, IProgressMonitor monitor) throws CoreException {
		super.build(context, monitor);
		if (!context.getResourceSet().getResources().isEmpty()) {
			//TODO iterate over the resources to evict only those that have changed
//			matcher.evict(null);
		}
	}
}
