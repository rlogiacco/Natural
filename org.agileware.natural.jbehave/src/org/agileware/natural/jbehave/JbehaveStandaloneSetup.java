
package org.agileware.natural.jbehave;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class JbehaveStandaloneSetup extends JbehaveStandaloneSetupGenerated{

	public static void doSetup() {
		new JbehaveStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

