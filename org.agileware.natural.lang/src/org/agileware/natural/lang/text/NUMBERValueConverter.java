package org.agileware.natural.lang.text;

import java.math.BigInteger;

import org.eclipse.xtext.conversion.ValueConverterException;
import org.eclipse.xtext.conversion.impl.AbstractLexerBasedConverter;
import org.eclipse.xtext.nodemodel.INode;
import org.eclipse.xtext.util.Strings;

public class NUMBERValueConverter extends AbstractLexerBasedConverter<BigInteger> {

	public NUMBERValueConverter() {
		super();
	}

	@Override
	protected String toEscapedString(final BigInteger value) {
		return value.toString();
	}

	@Override
	public BigInteger toValue(final String string, final INode node) throws ValueConverterException {
		if (Strings.isEmpty(string))
			throw new ValueConverterException("Couldn't convert empty string to an int value.", node, null);
		try {
			return new BigInteger(string);
		} catch (final NumberFormatException e) {
			throw new ValueConverterException("Couldn't convert '" + string + "' to an int value.", node, e);
		}
	}

}
