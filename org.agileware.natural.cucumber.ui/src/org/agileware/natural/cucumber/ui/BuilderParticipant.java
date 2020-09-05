package org.agileware.natural.cucumber.ui;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;

public class BuilderParticipant extends org.eclipse.xtext.builder.BuilderParticipant {

	@Override
	public void build(final IBuildContext context, IProgressMonitor monitor) throws CoreException {
		super.build(context, monitor);
//		if (!context.getResourceSet().getResources().isEmpty()) {
//			//TODO iterate over the resources to evict only those that have changed
//		}
	}
}
