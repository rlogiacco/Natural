/*
 * generated by Xtext
 */
package org.agileware.natural.cucumber.ui.labeling;

import org.agileware.natural.cucumber.model.Background;
import org.agileware.natural.cucumber.model.DocString;
import org.agileware.natural.cucumber.model.Example;
import org.agileware.natural.cucumber.model.Feature;
import org.agileware.natural.cucumber.model.Scenario;
import org.agileware.natural.cucumber.model.ScenarioOutline;
import org.agileware.natural.cucumber.model.Step;
import org.agileware.natural.cucumber.model.Table;
import org.agileware.natural.cucumber.model.Tag;
import org.eclipse.emf.edit.ui.provider.AdapterFactoryLabelProvider;
import org.eclipse.xtext.ui.label.DefaultEObjectLabelProvider;

import com.google.inject.Inject;

/**
 * Provides labels for a EObjects.
 * 
 * see
 * http://www.eclipse.org/Xtext/documentation/latest/xtext.html#labelProvider
 */
public class CucumberLabelProvider extends DefaultEObjectLabelProvider {

	@Inject
	public CucumberLabelProvider(AdapterFactoryLabelProvider delegate) {
		super(delegate);
	}

	String text(Feature ele) {
		return ele.getTitle();
	}

	String image(Feature ele) {
		return "feature.png";
	}

	String text(Background ele) {
		return ele.getTitle() == null ? "Background" : ele.getTitle();
	}

	String image(Background ele) {
		return "background.gif";
	}

	String text(Scenario ele) {
		return ele.getTitle() == null ? "Scenario" : ele.getTitle();
	}

	String image(Scenario ele) {
		return "scenario.png";
	}

	String text(ScenarioOutline ele) {
		return ele.getTitle() == null ? "Scenario Outline" : ele.getTitle();
	}

	String image(ScenarioOutline ele) {
		return "scenario_outline.png";
	}

	String text(Step ele) {
		return ele.getDescription().trim();
	}

	String image(Step ele) {
		return "step.gif";
	}

	String text(Table ele) {
		return merge("Table with ", 
				String.valueOf(ele.getRows().size()),
				ele.getRows().size() > 1 ? " rows" : "row");
	}

	String image(Table ele) {
		return "table.gif";
	}

	String text(DocString ele) {
		return "DocString";
	}

	String image(DocString ele) {
		return "code.gif";
	}

	String text(Example ele) {
		return ele.getTitle().isEmpty() ? "Examples" : ele.getTitle();
	}

	String image(Example ele) {
		return "example.gif";
	}

	String text(Tag ele) {
		return ele.getId();
	}

	String image(Tag ele) {
		return "annotation.gif";
	}

	private static String merge(String... strings) {
		StringBuilder builder = new StringBuilder();
		for (String string : strings) {
			builder.append(string);
		}
		return builder.toString();
	}
}
