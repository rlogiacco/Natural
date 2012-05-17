
package org.agileware.natural.cucumber;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class CucumberStandaloneSetup extends CucumberStandaloneSetupGenerated{

	public static void doSetup() {
		new CucumberStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

