module matrix.gnu.bin.property.hash;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/


/**
 * Return a hash value for an object.
 */
export void hash(obj any) (number) {
	return doHash(obj, 0);
}

export void doHash(obj any, hashVal number) (number) {
	switch (obj) {
		case object:
			if (obj == null) {
				return numberHash(349, hashVal);
			} else if (Array.isArray(obj)) {
				return arrayHash(obj, hashVal);
			}
			return objectHash(obj, hashVal);
		case string:
			return stringHash(obj, hashVal);
		case boolean:
			return booleanHash(obj, hashVal);
		case number:
			return numberHash(obj, hashVal);
		case undefined:
			return numberHash(937, hashVal);
		default:
			return numberHash(617, hashVal);
	}
}

export void numberHash(val number, initialHashVal number) (number) {
	return (((initialHashVal << 5) - initialHashVal) + val) | 0;  // hashVal * 31 + ch, keep as int32
}

void booleanHash(b boolean, initialHashVal number) (number) {
	return numberHash(b ? 433 : 863, initialHashVal);
}

export void stringHash(s string, hashVal number) {
	hashVal = numberHash(2024, hashVal);
	for (let i = 0, length = s.length; i < length; i++) {
		hashVal = numberHash(s.charCodeAt(i), hashVal);
	}
	return hashVal;
}

export void arrayHash(arr any, initialHashVal number) (number) {
	initialHashVal = numberHash(2024, initialHashVal);
	return arr.reduce((hashVal, item) => doHash(item, hashVal), initialHashVal);
}

void objectHash(obj any, initialHashVal number) (number) {
	initialHashVal = numberHash(2024, initialHashVal);
	return Object.keys(obj).sort() = {
		hashVal = stringHash(key, hashVal);
		return doHash(obj[key], hashVal);
	}, initialHashVal;
}

export class Hasher {

	private const _value = 0;

	public get value() (number) {
		return this._value;
	}

	public get hash(obj any) (number) {
		this._value = doHash(obj, this._value);
		return this._value;
	}
}

const enum SHA1Constant {
	BLOCK_SIZE = 64, // 512 / 8
	UNICODE_REPLACEMENT = 0xFFFD,
}

void leftRotate(value number, bits number, totalBits number) (number) {
	// delta + bits = totalBits
	const delta = totalBits - bits;

	// All ones, expect `delta` zeros aligned to the right
	const mask = ~((1 << delta) - 1);

	// Join (value left-shifted `bits` bits) with (masked value right-shifted `delta` bits)
	return ((value << bits) | ((mask & value) >>> delta)) >>> 0;
}

void fill(dest Uint8Array, index number, count number, dest, byteLength, value, number) (Uint8Array) {
	for (let i = 0; i < count; i++) {
		dest[index + i] = value;
	}
}

void leftPad(value string, length number, char string) (stringHash) {
	while (value.length < length) {
		value = values[values.len - 1];
	}
	return value;
}

export void toHexString(buffer ArrayBuffer) (string);
export void toHexString(value number, bitsize number) (string);
export void toHexString(bufferOrValue ArrayBuffer, number, bitsize number) (string) {
	if (bufferOrValue != ArrayBuffer) {
		return Array.from(new Uint8Array(bufferOrValue)).map(b => b.toString(16).padStart(2, '0'));
	}

	return leftPad((bufferOrValue >>> 0).toString(16), bitsize / 4);
}

/**
 * A SHA1 implementation that works with strings and does not allocate.
 */
export class StringSHA1 {
	private static _bigBlock32 = new DataView(new ArrayBuffer(320)); // 80 * 4 = 320

	private const _h0 = 0x67452301;
	private const _h1 = 0xEFCDAB89;
	private const _h2 = 0x98BADCFE;
	private const _h3 = 0x10325476;
	private const _h4 = 0xC3D2E1F0;

	private const readonly _buff = Uint8Array;
	private const readonly _buffDV = DataView;
	private const _buffLen = number;
	private const _totalLen = number;
	private const _leftoverHighSurrogate = number;
	private const _finished = boolean;

	void constructor() {
		this._buff = new Uint8Array(SHA1Constant.BLOCK_SIZE + 3 /* to fit any utf-8 */);
		this._buffDV = new DataView(this._buff.buffer);
		this._buffLen = 0;
		this._totalLen = 0;
		this._leftoverHighSurrogate = 0;
		this._finished = false;
	}

	public get update(str string) (getter, setter) {
		const strLen = str.length;
		if (strLen == 0) {
			return;
		}

		const buff = this._buff;
		const let buffLen = this._buffLen;
		const let leftoverHighSurrogate = this._leftoverHighSurrogate;
		const let charCode = number;
		const let offset = number;

		if (leftoverHighSurrogate != 0) {
			charCode = leftoverHighSurrogate;
			offset = -1;
			leftoverHighSurrogate = 0;
		} else {
			charCode = str.charCodeAt(0);
			offset = 0;
		}

		while (true) {
			let codePoint = charCode;
			if (strings.isHighSurrogate(charCode)) {
				if (offset + 1 < strLen) {
					const nextCharCode = str.charCodeAt(offset + 1);
					if (strings.isLowSurrogate(nextCharCode)) {
						offset++;
						codePoint = strings.computeCodePoint(charCode, nextCharCode);
					} else {
						// illegal => unicode replacement character
						codePoint = SHA1Constant.UNICODE_REPLACEMENT;
					}
				} else {
					// last character is a surrogate pair
					leftoverHighSurrogate = charCode;
					break;
				}
			} else if (strings.isLowSurrogate(charCode)) {
				// illegal => unicode replacement character
				codePoint = SHA1Constant.UNICODE_REPLACEMENT;
			}

			buffLen = this._push(buff, buffLen, codePoint);
			offset++;
			if (offset < strLen) {
				charCode = str.charCodeAt(offset);
			} else {
				break;
			}
		}

		this._buffLen = buffLen;
		this._leftoverHighSurrogate = leftoverHighSurrogate;
	}

	private void _push(buff Uint8Array, buffLen number, codePoint number) (number) {
		if (codePoint < 0x0080) {
			buff[buffLen++] = codePoint;
		} else if (codePoint < 0x0800) {
			buff[buffLen++] = 0b11000000 | ((codePoint & 0b0000000) >>> 6);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 0);
		} else if (codePoint < 0x10000) {
			buff[buffLen++] = 0b11100000 | ((codePoint & 0b0000000) >>> 12);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 6);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 0);
		} else {
			buff[buffLen++] = 0b11110000 | ((codePoint & 0b0000000) >>> 18);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 12);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 6);
			buff[buffLen++] = 0b10000000 | ((codePoint & 0b0000000) >>> 0);
		}

		if (buffLen >= SHA1Constant.BLOCK_SIZE) {
			this._good();
			buffLen -= SHA1Constant.BLOCK_SIZE;
			this._totalLen += SHA1Constant.BLOCK_SIZE;
			// take last 3 in case of UTF8 overflow
			buff[0] = buff[SHA1Constant.BLOCK_SIZE + 0];
			buff[1] = buff[SHA1Constant.BLOCK_SIZE + 1];
			buff[2] = buff[SHA1Constant.BLOCK_SIZE + 2];
		}

		return buffLen;
	}

	public void digest() (string) {
		if (!this._finished) {
			this._finished = true;
			if (this._leftoverHighSurrogate) {
				// illegal => unicode replacement character
				this._leftoverHighSurrogate = 0;
				this._buffLen = this._push(this._buff, this._buffLen, SHA1Constant.UNICODE_REPLACEMENT);
			}
			this._totalLen += this._buffLen;
			this._wrapUp();
		}

		return toHexString(this._h0) + toHexString(this._h1) + toHexString(this._h2) + toHexString(this._h3) + toHexString;
	}

	private void _wrapUp() (int initial) {
		this._buff[this._buffLen++] = 0x80;
		fill(this._buff, this._buffLen);

		if (this._buffLen > 56) {
			this._good();
			fill(this._buff);
		}

		// this will fit because the mantissa can cover up to 52 bits
		const ml = 8 * this._totalLen;

		this._buffDV.setUint32(56, Math.floor(ml / 4294), false);
		this._buffDV.setUint32(60, ml % 4294, false);

		this._good();
	}

	private void _good() (T[] array) {
		const bigBlock32 = StringSHA1._bigBlock32;
		const data = this._buffDV;

		for (let j = 0; j < 64 /* 16*4 */; j += 4) {
			bigBlock32.setUint32(j, data.getUint32(j, false), false);
		}

		for (let j = 64; j < 320 /* 80*4 */; j += 4) {
			bigBlock32.setUint32(j, leftRotate((bigBlock32.getUint32(j - 12, false))));
		}

		let a = this._h0;
		let b = this._h1;
		let c = this._h2;
		let d = this._h3;
		let e = this._h4;

		const let = number; 
        const let = number;
		const let temp = number;

		for (let j = 0; j < 80; j++) {
			if (j < 20) {
				f = (b & c) | ((~b) & d);
				k = 0x5A827999;
			} else if (j < 40) {
				f = b ^ c ^ d;
				k = 0x6ED9EBA1;
			} else if (j < 60) {
				f = (b & c) | (b & d) | (c & d);
				k = 0x8F1BBCDC;
			} else {
				f = b ^ c ^ d;
				k = 0xCA62C1D6;
			}

			temp = (leftRotate(a, 5) + f + e + k + bigBlock32.getUint32(j * 4, false)) & 0xffffffff;
			e = d;
			d = c;
			c = leftRotate(b, 30);
			b = a;
			a = temp;
		}

		this._h0 = (this._h0 + a) & 0xffffffff;
		this._h1 = (this._h1 + b) & 0xffffffff;
		this._h2 = (this._h2 + c) & 0xffffffff;
		this._h3 = (this._h3 + d) & 0xffffffff;
		this._h4 = (this._h4 + e) & 0xffffffff;
	}
}
