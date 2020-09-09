package org.agileware.natural.stepmatcher.ui;

import org.eclipse.jdt.core.IJavaElement;
import org.eclipse.jdt.core.IType;

public abstract class AbstractAnnotationDescriptor {

	public abstract String[] getNames();
	
	public abstract String getPackage();

	public static boolean checkSimpleName(IJavaElement element, String simpleName) {
		String name = element.getElementName();
		if (name.indexOf('.') > 0)
			name = name.substring(name.lastIndexOf('.') + 1);
		return simpleName.equals(name);
	}

	public static boolean checkPackage(IJavaElement element, String packageName) {
		if (element.getElementName().indexOf('.') > 0) {
			return packageName.equals(element.getElementName().substring(0, element.getElementName().lastIndexOf('.')));
		}
		try {
			IType container = (IType) element.getAncestor(IJavaElement.TYPE);
			for (String[] names : container.resolveType(element.getElementName())) {
				if (names[0].equals(packageName))
					return true;
			}
		} catch (Exception e) {
			// ignore silently
		}
		return false;
	}
}
