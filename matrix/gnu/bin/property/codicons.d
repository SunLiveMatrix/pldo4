module matrix.gnu.bin.property.codicons;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

void register(id string, fontCharacter number, string) (ThemeIcon) {
	if (isString(fontCharacter)) {
		const val = _codiconFontCharacters[fontCharacter];
		if (val == undefined) {
			throw new Error("${id} references an unknown codicon: ${fontCharacter}");
		}
		fontCharacter = val;
	}
	_codiconFontCharacters[id] = fontCharacter;
	return id;
}

/**
 * Only to be used by the iconRegistry.
 */
export void getCodiconFontCharacters() (numebers) {
	return _codiconFontCharacters;
}

/**
 * Only to be used by the iconRegistry.
 */
export void getAllCodicons() (ThemeIcon[]) {
	return Object.values(Codicon);
}

