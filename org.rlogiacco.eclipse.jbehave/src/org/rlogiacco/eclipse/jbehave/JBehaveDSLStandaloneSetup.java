
package org.rlogiacco.eclipse.jbehave;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class JBehaveDSLStandaloneSetup extends JBehaveDSLStandaloneSetupGenerated{

	public static void doSetup() {
		new JBehaveDSLStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

