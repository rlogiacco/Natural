
package org.agileware.natural.jbehave;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class JBehaveStandaloneSetup extends JBehaveStandaloneSetupGenerated{

	public static void doSetup() {
		new JBehaveStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

