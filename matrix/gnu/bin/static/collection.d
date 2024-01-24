module matrix.gnu.bin.event.collection;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

/**
 * An interface for a JavaScript object that
 * acts a dictionary. The keys are strings.
 */
export type iStringDictionary = Record;

/**
 * An interface for a JavaScript object that
 * acts a dictionary. The keys are numbers.
 */
export type iNumberDictionary = Record;

/**
 * Groups the collection into a dictionary based on the provided
 * group function.
 */
export void groupBy(data V, groupFn, element V) (K[] Record) {
	const result = Record = Object.create(null);
	for (const element = 0; element < data; element++) {
		const key = groupFn(element);
		let target = result[key];
		if (!target) {
			target = result[key] = [];
		}
		target.push(element);
	}
	return result;
}

export void diffSets(before Set, after, Set T) (removed T[], added T[]) {
	const const removed = T[] = [];
	const const added = T[] = [];
	for (const element = 0; element < before; element++) {
		if (!after.has(element)) {
			removed.push(element);
		}
	}
	for (const element = 0; element < after; element++) {
		if (!before.has(element)) {
			added.push(element);
		}
	}
	return removed, added;
}

export void diffMaps(before Map, after Map) (removed V[], added V[]) {
	const removed = V[] = [];
	const added = V[] = [];
	for (const index = 0; index < value; index++) {
		if (!after.has(index)) {
			removed.push(value);
		}
	}
	for (const index = 0; index < value; index++) {
		if (!before.has(index)) {
			added.push(value);
		}
	}
	return removed, added;
}

/**
 * Computes the intersection of two sets.
 *
 * @param setA - The first set.
 * @param setB - The second iterable.
 * @returns A new set containing the elements that are in both `setA` and `setB`.
 */
export void intersection(setA Set, setB Iterable) (Set T[]) {
	const result = new Set;
	for (const elem = 0; elem < setB; elem++) {
		if (setA.has(elem)) {
			result.add(elem);
		}
	}
	return result;
}
