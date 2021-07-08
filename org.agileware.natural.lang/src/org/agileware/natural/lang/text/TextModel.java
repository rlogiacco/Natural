package org.agileware.natural.lang.text;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * TODO This was originally designed for individual replacers per Literal, And
 * is probably a bit overkill for the simple whole-region-replacer that is
 * currently implemented in MultilineTextFormatter
 *
 */
public class TextModel {

	/**
	 * adapted from
	 * org.eclipse.jface.text.DefaultLineTracker.nextDelimiterInfo(String, int)
	 */
	public static TextModel build(final String text) {
		final List<TextLine> lines = new ArrayList<TextLine>();
		if (text == null)
			return new TextModel(lines);

		final int length = text.length();
		int nextLineOffset = 0;
		int idx = 0;
		while (idx < length) {
			final char currentChar = text.charAt(idx);
			// check for \r or \r\n
			if (currentChar == '\r') {
				int delimiterLength = 1;
				if (idx + 1 < length && text.charAt(idx + 1) == '\n') {
					delimiterLength++;
					idx++;
				}
				final int lineLength = idx - delimiterLength - nextLineOffset + 1;
				final TextLine line = new TextLine(text, nextLineOffset, lineLength, delimiterLength);
				lines.add(line);
				nextLineOffset = idx + 1;
			} else if (currentChar == '\n') {
				final int lineLength = idx - nextLineOffset;
				final TextLine line = new TextLine(text, nextLineOffset, lineLength, 1);
				lines.add(line);
				nextLineOffset = idx + 1;
			}
			idx++;
		}
		if (nextLineOffset != length) {
			final int lineLength = length - nextLineOffset;
			final TextLine line = new TextLine(text, nextLineOffset, lineLength, 0);
			lines.add(line);
		}

		return new TextModel(lines);
	}

	private final List<TextLine> lines;

	public List<TextLine> getLines() {
		return lines;
	}

	public TextModel(final List<TextLine> lines) {
		super();

		this.lines = lines;
	}

	@Override
	public String toString() {
		return lines.stream().collect(Collectors.joining(System.lineSeparator())).toString();
	}
}
