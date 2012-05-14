package org.rlogiacco.eclipse.bdd.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;
import java.util.Map;

import org.eclipse.core.resources.IFile;
import org.eclipse.jdt.core.ICompilationUnit;

import com.google.common.collect.MapMaker;
import com.google.inject.Singleton;

@Singleton
public class JavaHyperlinkCache {

	private Map<IFile, List<JavaHyperlink>> models = new MapMaker().softKeys().makeMap();
	private Map<ICompilationUnit, List<JavaHyperlink>> classes = new MapMaker().softKeys().makeMap();

	public JavaHyperlinkCache() {
	}

	public boolean contains(ICompilationUnit type) {
		return classes.containsKey(type);
	}

	public List<JavaHyperlink> get(ICompilationUnit type) {
		return classes.get(type);
	}

	public void remove(ICompilationUnit type) {
		List<JavaHyperlink> removed = classes.remove(type);
		if (removed != null) {
			for (Map.Entry<IFile, List<JavaHyperlink>> entry : models.entrySet()) {
				if (entry.getValue() == removed) {
					models.remove(entry.getKey());
					return;
				}
			}
			System.err.println("cache not in sync");
		}
	}
	
	public void add(ICompilationUnit type, List<JavaHyperlink> hyperlinks) {
		
	}
}
