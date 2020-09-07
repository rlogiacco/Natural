package org.agileware.natural.stepmatcher;

import java.util.Collection;

public class DefaultStepMatcher implements IStepMatcher {

	@Override
	public boolean isActivated() {
		return false;
	}

	@Override
	public Collection<AnnotationMacthEntry> findMatches(final String keyword, final String description) {
		return null;
	}

}
