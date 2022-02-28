package org.agileware.natural.stepmatcher;

import java.util.Collection;

public interface IStepMatcher {

	/**
	 * @return Returns true if step matcher is activated at runtime
	 */
	public boolean isActivated();

	/**
	 * Search for matching annotations given a Step keyword and description
	 *
	 * @param keyword
	 * @param description
	 * @return
	 */
	public Collection<AnnotationMacthEntry> findMatches(final String keyword, final String description);
}
