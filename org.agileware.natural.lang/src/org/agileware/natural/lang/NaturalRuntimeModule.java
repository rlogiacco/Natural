/*
 * generated by Xtext 2.23.0-SNAPSHOT
 */
package org.agileware.natural.lang;

import org.agileware.natural.lang.text.TextValueConverterService;
import org.eclipse.xtext.conversion.IValueConverterService;

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
public class NaturalRuntimeModule extends AbstractNaturalRuntimeModule {
	@Override
	public Class<? extends IValueConverterService> bindIValueConverterService() {
		return TextValueConverterService.class;
	}
}