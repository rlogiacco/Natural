package org.agileware.natural.lang.text;

import java.math.BigInteger;

import org.eclipse.xtext.conversion.IValueConverter;
import org.eclipse.xtext.conversion.ValueConverter;
import org.eclipse.xtext.conversion.impl.AbstractDeclarativeValueConverterService;
import org.eclipse.xtext.conversion.impl.STRINGValueConverter;

import com.google.inject.Inject;

public class TextValueConverterService extends AbstractDeclarativeValueConverterService {

	@Inject
	private STRINGValueConverter stringValueConverter;

	@ValueConverter(rule = TextLiterals.STRING)
	public IValueConverter<String> STRING_LITERAL() {
		return stringValueConverter;
	}

	@Inject
	private NUMBERValueConverter numberValueConverter;

	@ValueConverter(rule = TextLiterals.NUMBER)
	public IValueConverter<BigInteger> NUMBER_LITERAL() {
		return numberValueConverter;
	}
}
