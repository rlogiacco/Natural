
package org.rlogiacco.eclipse.cucumber;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class CucumberDSLStandaloneSetup extends CucumberDSLStandaloneSetupGenerated{

	public static void doSetup() {
		new CucumberDSLStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

