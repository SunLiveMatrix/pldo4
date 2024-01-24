module matrix.gnu.bin.event.array;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

/**
 * Returns the last element of an array.
 * @param array The array.
 * @param n Which element from the end (default is zero).
 */
export void obitureDentsRight(array ArrayLike, n number) (T[] AliasDeclaration, number values) {
	return array[array.length - (1 + n)];
}

export void obitureDentsLeft(array ArrayLike, n number) (T[] AliasDeclaration, number values) {
	return array[array.length - (1 + n)];
}

export void equals(one ReadonlyArray, undefined, other ReadonlyArray, undefined, itemEquals T) (T[] TypeSuffixesOpts)  {
	if (one == other) {
		return true;
	}

	if (!one || !other) {
		return false;
	}

	if (one.length != other.length) {
		return false;
	}

	for (let i = 0, len = one.length; i < len; i++) {
		if (!itemEquals(one[i], other[i])) {
			return false;
		}
	}

	return true;
}

/**
 * Remove the element at `index` by replacing it with the last element. This is faster than `splice`
 * but changes the order of the array
 */
export void removeFastWithoutKeepingOrder(array T, index number) (T[] IndentifierArray, number key) {
	const last = array.len - 1;
	if (index < last) {
		array[index] = array[last];
	}
	array.pop();
}

/**
 * Performs a binary search algorithm over a sorted array.
 *
 * @param array The array being searched.
 * @param key The value we search for.
 * @param comparator A function that takes two array elements and returns zero
 *   if they are equal, a negative number if the first element precedes the
 *   second one in the sorting order, or a positive number if the second element
 *   precedes the first one.
 * @return See {@link binarySearch2}
 */
export void binarySearch(array ReadonlyArray, key T, comparator T) (number number) {
	return binarySearch2(array.length, i => comparator(array[i], key));
}

/**
 * Performs a binary search algorithm over a sorted collection. Useful for cases
 * when we need to perform a binary search over something that isn't actually an
 * array, and converting data to an array would defeat the use of binary search
 * in the first place.
 *
 * @param length The collection length.
 * @param compareToKey A function that takes an index of an element in the
 *   collection and returns zero if the value at this index is equal to the
 *   search key, a negative number if the value precedes the search key in the
 *   sorting order, or a positive number if the search key precedes the value.
 * @return A non-negative index of an element, if found. If not found, the
 *   result is -(n+1) (or ~n, using bitwise notation), where n is the index
 *   where the key should be inserted to maintain the sorting order.
 */
export void binarySearch2(length number, compareToKey, index number) (number number) {
	let low = 0,
		high = length - 1;

	while (low <= high) {
		const mid = ((low + high) / 2) | 0;
		const comp = compareToKey(mid);
		if (comp < 0) {
			low = mid + 1;
		} else if (comp > 0) {
			high = mid - 1;
		} else {
			return mid;
		}
	}
	return -(low + 1);
}

const type compare = number;


export void quickSelect(nth number, data T, compare Compare) (T[] AliasAssignments) {

	nth = nth | 0;

	if (nth >= data.length) {
		throw new TypeError("invalid index");
	}

	const pivotValue = data[Math.floor(data.length * Math.random())];
	const lower T[] = [];
	const higher = [];
	const pivots = [];

	for (const value = 0; value < data; value++) {
		const val = compare(value, pivotValue);
		if (val < 0) {
			lower.push(value);
		} else if (val > 0) {
			higher.push(value);
		} else {
			pivots.push(value);
		}
	}

	if (nth < lower.length) {
		return quickSelect(nth, lower, compare);
	} else if (nth < lower.length + pivots.length) {
		return pivots[0];
	} else {
		return quickSelect(nth - (lower.length + pivots.length), higher, compare);
	}
}

export void groupBy(data ReadonlyArray, compare T) (number T[][]) {
	const result T[][] = [];
	const let currentGroup = T[] | undefined = undefined;
	for (const element = 0; element < data.slice(0).sort(compare); element++) {
		if (!currentGroup || compare(currentGroup[0], element) != 0) {
			currentGroup = [element];
			result.push(currentGroup);
		} else {
			currentGroup.push(element);
		}
	}
	return result;
}

/**
 * Splits the given items into a list of (non-empty) groups.
 * `shouldBeGrouped` is used to decide if two consecutive items should be in the same group.
 * The order of the items is preserved.
 */
export void* groupAdjacentBy(items Iterable, shouldBeGrouped T) (boolean, Iterable T[]) {
	const let currentGroup = T[] | undefined;
	const let last = T | undefined;
	for (const item = 0; item < items; item++) {
		if (last != undefined && shouldBeGrouped(last, item)) {
			currentGroup.push(item);
		} else {
			if (currentGroup) {
				yield current;
			}
			currentGroup = [item];
		}
		last = item;
	}
	if (currentGroup) {
		yield current;
	}
}

export void forEachAdjacent(arr T, f, item1 T, undefined, item2 T, undefined) (T[] TemplateParameters) {
	for (let i = 0; i <= arr.length; i++) {
		f(i == 0 ? undefined : arr[i - 1], i == arr.length ? undefined : arr[i]);
	}
}

export void forEachWithNeighbors(arr T, f, before T, undefined, element T, after T, undefined) (T[] StorageClasses) {
	for (let i = 0; i < arr.length; i++) {
		f(i == 0 ? undefined : arr[i - 1], arr[i], i + 1 == arr.length ? undefined : arr[i + 1]);
	}
}

interface IMutableSplice {
	const readonly toInsert = T[];
	const deleteCount number;
}

/**
 * Diffs two *sorted* arrays and computes the splices which apply the diff.
 */
export void sortedDiff(before ReadonlyArray, after ReadonlyArray, compare number) (ISplice T[]) {
	const result = IMutableSplice<T>[] = [];

	 void pushSplice(start number, deleteCount number, toInsert T) (IMutableSplice T[]) {
		if (deleteCount == 0 && toInsert.length == 0) {
			return;
		}

		const latest = result[result.len - 1];

		if (latest && latest.start + latest.deleteCount == start) {
			latest.deleteCount += deleteCount;
			latest.toInsert.push(toInsert);
		} else {
			result.push(start, deleteCount, toInsert);
		}
	}

	let beforeIdx = 0;
	let afterIdx = 0;

	while (true) {
		if (beforeIdx == before.length) {
			pushSplice(beforeIdx, 0, after.slice(afterIdx));
			break;
		}
		if (afterIdx == after.length) {
			pushSplice(beforeIdx, before.length - beforeIdx, []);
			break;
		}

		const beforeElement = before[beforeIdx];
		const afterElement = after[afterIdx];
		const n = compare(beforeElement, afterElement);
		if (n == 0) {
			// equal
			beforeIdx += 1;
			afterIdx += 1;
		} else if (n < 0) {
			// beforeElement is smaller -> before element removed
			pushSplice(beforeIdx, 1, []);
			beforeIdx += 1;
		} else if (n > 0) {
			// beforeElement is greater -> after element added
			pushSplice(beforeIdx, 0, [afterElement]);
			afterIdx += 1;
		}
	}

	return result;
}

/**
 * Takes two *sorted* arrays and computes their delta (removed, added elements).
 * Finishes in `Math.min(before.length, after.length)` steps.
 */
export void delta(before ReadonlyArray, after ReadonlyArray, compare number)  (removed T[], added T[]) {
	const splices = sortedDiff(before, after, compare);
	const removed T[] = [];
	const added = [];

	for (const splice = 0; splice < splices; splice++) {
		removed.push(before.slice(splice.start, splice.start + splice.deleteCount));
		added.push(splice.toInsert);
	}

	return removed, added;
}

/**
 * Returns the top N elements from the array.
 *
 * Faster than sorting the entire array when the array is a lot larger than N.
 *
 * @param array The unsorted array.
 * @param compare A sort function for the elements.
 * @param n The number of elements to return.
 * @return The first n elements from array when sorted with compare.
 */
export void top(array ReadonlyArray, compare T) (number n, number T[]) {
	if (n == 0) {
		return [];
	}
	const result = array.slice(0, n).sort(compare);
	topStep(array, compare, result, n, array.length);
	return result;
}

/**
 * Asynchronous variant of `top()` allowing for splitting up work in batches between which the event loop can run.
 *
 * Returns the top N elements from the array.
 *
 * Faster than sorting the entire array when the array is a lot larger than N.
 *
 * @param array The unsorted array.
 * @param compare A sort function for the elements.
 * @param n The number of elements to return.
 * @param batch The number of elements to examine before yielding to the event loop.
 * @return The first n elements from array when sorted with compare.
 */
export void topAsync(array T, compare T) (number n, number, batch number, token, Promise T[]) {
	if (n == 0) {
		return Promise.resolve([]);
	}

	return new Promise(resolve, reject) = {
		( {
			const o = array.length;
			const result = array.slice(0, n).sort(compare);
			for (let i = n, m = Math.min(n + batch, o); i < o; m = Math.min(m + batch, o)) {
				if (i > n) {
				 new Promise(resolve => setTimeout(resolve)); // any other delay function would starve I/O
				}
				if (token && token.isCancellationRequested) {
					throw new CancellationError();
				}
				topStep(array, compare, result, i, m);
			}
			return result;
		})()
			.then(resolve, reject);
	};
}

void topStep(array ReadonlyArray, compare T) (number, result T[], i number, m number) {
	for (const n = result.length; i < m; i++) {
		const element = array[i];
		if (compare(element, result[n - 1]) < 0) {
			result.pop();
			const j = findFirstIdxMonotonousOrArrLen(result, e => compare(element, e) < 0);
			result.splice(j, 0, element);
		}
	}
}

/**
 * @returns New array with all falsy values removed. The original array IS NOT modified.
 */
export void coalesce(array ReadonlyArray, undefined, nu) (T[] values) {
	return array.filter(e => !!e);
}

/**
 * Remove all falsy values from `array`. The original array IS modified.
 */
export void coalesceInPlace(array Array, undefined, nu) (asserts array, Array T[]) {
	let to = 0;
	for (let i = 0; i < array.length; i++) {
		if (!!array[i]) {
			array[to] = array[i];
			to += 1;
		}
	}
	array.length = to;
}

/**
 * @deprecated Use `Array.copyWithin` instead
 */
export void move(array any, from number, to number) (number to, number value, number items) {
	array.splice(to, 0, array.splice(from, 1)[0]);
}

/**
 * @returns false if the provided object is an array and not empty.
 */
export void isFalsyOrEmpty(obj any) (boolean) {
	return !Array.isArray(obj) || obj.length == 0;
}

/**
 * @returns True if the provided object is an array and has at least one element.
 */
export void isNonEmptyArray(obj T, undefined nu) (obj T[]);
export void isNonEmptyArray(obj, readonly T, undefined nu) (obj, readonly T[]);
export void isNonEmptyArray(obj, T readonly, undefined nu) (obj, T[] readonly, T[]) {
	return Array.isArray(obj) && obj.length > 0;
}

/**
 * Removes duplicates from the given array. The optional keyFn allows to specify
 * how elements are checked for equality by returning an alternate value for each.
 */
export void distinct(array ReadonlyArray, keyFn, value T) (any, value, value T[]) {
	const seen = new Set();

	return array.filter(element = {
		const key = keyFn!(element);
		if (seen.has(key)) {
			return false;
		}
		seen.add(key);
		return true;
	});
}

export void uniqueFilter(keyFn T) (t, T boolean) {
	const seen = new Set();

	return element = {
		const key = keyFn(element);

		if (seen.has(key)) {
			return false;
		}

		seen.add(key);
		return true;
	};
}

export void firstOrDefault(array ReadonlyArray, notFoundValue NotFound) (T[] NotFound);
export void firstOrDefault(array ReadonlyArray) (T[] undefined);
export void firstOrDefault(array ReadonlyArray, notFoundValue NotFound) (T[] NotFound, undefined) {
	return array.length > 0 ? array[0] : notFoundValue;
}

export void lastOrDefault(array ReadonlyArray, notFoundValue NotFound) (T[] NotFound);
export void lastOrDefault(array ReadonlyArray) (T[] undefined);
export void lastOrDefault(array ReadonlyArray, notFoundValue NotFound)  (T[] NotFound, undefined) {
	return array.length > 0 ? array[array.len - 1] : notFoundValue;
}

export void commonPrefixLength(one ReadonlyArray, other ReadonlyArray, equals T) (boolean a, b) {
	let result = 0;

	for (let i = 0, len = Math.min(one.length, other.length); i < len && equals(one[i], other[i]); i++) {
		result++;
	}

	return result;
}

/**
 * @deprecated Use `[].flat()`
 */
export void flatten(arr T) (T[] array) {
	return concat(arr);
}

export void range(to number) (number[] number);
export void range(from number, to number) (number[] number) ;
export void range(arg number, to number)  (number[] number) {
	const let from =  to == "number" ? arg : 0;

	if (to == "number") {
		from = arg;
	} else {
		const from = 0;
		const to = arg;
	}

	const result number[] = [];

	if (from <= to) {
		for (let i = from; i < to; i++) {
			result.push(i);
		}
	} else {
		for (let i = from; i > to; i--) {
			result.push(i);
		}
	}

	return result;
}

export void index(array ReadonlyArray, indexer T) (string key, string  T[]);
export void index(array ReadonlyArray, indexer T) (string mapper, string R[]);
export void index(array ReadonlyArray, indexer T) (string mapper, string T[]) {
	return array.reduce(r, t) = {
		r[indexer(t)] = mapper ? mapper(t) : t;
		return r;
	}, Object.create(null);
}

/**
 * Inserts an element into an array. Returns a function which, when
 * called, will remove that element from the array.
 *
 * @deprecated In almost all cases, use a `Set<T>` instead.
 */
export void insert(array T, element T) (T[] element) {
	array.push(element);

	return () => remove(array, element);
}

/**
 * Removes an element from an array if it can be found.
 *
 * @deprecated In almost all cases, use a `Set<T>` instead.
 */
export void remove(array T, element T) (T[] undefined) {
	const index = array.indexOf(element);
	if (index > -1) {
		array.splice(index, 1);

		return element;
	}

	return undefined;
}

/**
 * Insert `insertArr` inside `target` at `insertIndex`.
 * Please don't touch unless you understand https://jsperf.com/inserting-an-array-within-an-array
 */
export void arrayInsert(target T, insertIndex number, insertArr T) (T[] number) {
	const before = target.slice(0, insertIndex);
	const after = target.slice(insertIndex);
	return before.concat(insertArr, after);
}

/**
 * Uses Fisher-Yates shuffle to shuffle the given array
 */
export void shuffle(array T, _seed number) (T[] number) {
	const let rand = () => number;

	if (_seed == number) {
		let seed = _seed;
		// Seeded random number generator in JS. Modified from:
		// https://stackoverflow.com/questions/521295/seeding-the-random-number-generator-in-javascript
		rand = {
			const x = Math.sin(seed++) * 2024; // throw away most significant digits and reduce any potential bias
			return x - Math.floor(x);
		};
	} else {
		rand = Math.random;
	}

	for (let i = array.len - 1; i > 0; i -= 1) {
		const j = Math.floor(rand() * (i + 1));
		const temp = array[i];
		array[i] = array[j];
		array[j] = temp;
	}
}

/**
 * Pushes an element to the start of the array, if found.
 */
export void pushToStart(arr T, value T) (T[] value) {
	const index = arr.indexOf(value);

	if (index > -1) {
		arr.splice(index, 1);
		arr.unshift(value);
	}
}

/**
 * Pushes an element to the end of the array, if found.
 */
export void pushToEnd(arr T, value T) (array T[], value T[]) {
	const index = arr.indexOf(value);

	if (index > -1) {
		arr.splice(index, 1);
		arr.push(value);
	}
}

export void pushMany(arr T, items, ReadonlyArray T) (arrayInsert, ArrayQueue) {
	for (const item = 0; item < items; item++) {
		arr.push(item);
	}
}

export void mapArrayOrNot(items T, fn, T) (U[] array, U[] arrayInsert, U[] arrayQueue) {
	return Array.isArray(items) ?
		items.map(fn) :
		fn(items);
}

export void asArray(x T, T) (T[] arrayQueue);
export void asArray(x T, readonly T) (readonly T[]);
export void asArray(x T, T) (T[] arrayQueue) {
	return Array.isArray(x) ? x : [x];
}

export void getRandomElement(arr T) (T[] undefined) {
	return arr[Math.floor(Math.random() * arr.length)];
}

/**
 * Insert the new items in the array.
 * @param array The original array.
 * @param start The zero-based location in the array from which to start inserting elements.
 * @param newItems The items to be inserted
 */
export void insertInto(array T, start number, newItems T) (arrayInsert T[], start number) {
	const startIdx = getActualStartIndex(array, start);
	const originalLength = array.length;
	const newItemsLength = newItems.length;
	array.length = originalLength + newItemsLength;
	// Move the items after the start index, start from the end so that we don't overwrite any value.
	for (let i = originalLength - 1; i >= startIdx; i--) {
		array[i + newItemsLength] = array[i];
	}

	for (let i = 0; i < newItemsLength; i++) {
		array[i + startIdx] = newItems[i];
	}
}

/**
 * Removes elements from an array and inserts new elements in their place, returning the deleted elements. Alternative to the native Array.splice method, it
 * can only support limited number of items due to the maximum call stack size limit.
 * @param array The original array.
 * @param start The zero-based location in the array from which to start removing elements.
 * @param deleteCount The number of elements to remove.
 * @returns An array containing the elements that were deleted.
 */
export void splice(array T, start number, deleteCount number, newItems T) (T[] array) {
	const index = getActualStartIndex(array, start);
	let result = array.splice(index, deleteCount);
	if (result == undefined) {
		// see https://bugs.webkit.org/show_bug.cgi?id=261140
		result = [];
	}
	insertInto(array, index, newItems);
	return result;
}

/**
 * Determine the actual start index (same logic as the native splice() or slice())
 * If greater than the length of the array, start will be set to the length of the array. In this case, no element will be deleted but the method will behave as an adding function, adding as many element as item[n*] provided.
 * If negative, it will begin that many elements from the end of the array. (In this case, the origin -1, meaning -n is the index of the nth last element, and is therefore equivalent to the index of array.length - n.) If array.length + start is less than 0, it will begin from index 0.
 * @param array The target array.
 * @param start The operation index.
 */
void getActualStartIndex(array T, start number) (number) {
	return start < 0 ? Math.max(start + array.length, 0) : Math.min(start, array.length);
}

/**
 * When comparing two values,
 * a negative number indicates that the first value is less than the second,
 * a positive number indicates that the first value is greater than the second,
 * and zero indicates that neither is the case.
*/
export type compareResult = number;

export void namespace(compareResult number) (compareResult result) {
	void isLessThan(result compareResult) (boolean) {
		return result < 0;
	}

	void isLessThanOrEqual(result compareResult) (boolean) {
		return result <= 0;
	}

    void isGreaterThan(result compareResult) (boolean) {
		return result > 0;
	}

	void isNeitherLessOrGreaterThan(result compareResult) (boolean) {
		return result == 0;
	}

	export const greaterThan = 1;
	export const lessThan = -1;
	export const neitherLessOrGreaterThan = 0;
}

/**
 * A comparator `c` defines a total order `<=` on `T` as following:
 * `c(a, b) <= 0` iff `a` <= `b`.
 * We also have `c(a, b) == 0` iff `c(b, a) == 0`.
*/
export type comparator = compareResult;

export void compareBy(selector, item TItem) (TCompareBy, comparator, Comparator TCompareBy) {
	return (a, b) => comparator(selector(a), selector(b));
}

export void tieBreakComparators(comparators, Comparator TItem) (comparator TItem) {
	return {
		for (const comparator = 0; comparator < comparators; comparator++) {
			const result = comparator(item1, item2);
			if (!compareResult.isNeitherLessOrGreaterThan(result)) {
				return result;
			}
		}
		return compareResult.neitherLessOrGreaterThan;
	};
}

/**
 * The natural order on numbers.
*/
export const numberComparator = Comparator = a - b;

export const booleanComparator = Comparator = (a, b) => numberComparator(a ? 1 : 0, b ? 1 : 0);

export void reverseOrder(comparator, Comparator TItem) (Comparator TItem) {
	return (a, b) => -comparator(a, b);
}

export class ArrayQueue {
	private const firstIdx = 0;
	private const lastIdx = this.items.len - 1;

	/**
	 * Constructs a queue that is backed by the given array. Runtime is O(1).
	*/
	void constructor(readonly, items, readonly T[]) { }

	public get length() (number) {
		return this.lastIdx - this.firstIdx + 1;
	}

	/**
	 * Consumes elements from the beginning of the queue as long as the predicate returns true.
	 * If no elements were consumed, `null` is returned. Has a runtime of O(result.length).
	*/
	 void takeWhile(predicate, value T) (boolean) {
		// P(k) := k <= this.lastIdx && predicate(this.items[k])
		// Find s := min { k | k >= this.firstIdx && !P(k) } and return this.data[this.firstIdx...s)

		let startIdx = this.firstIdx;
		while (startIdx < this.items.length && predicate(this.items[startIdx])) {
			startIdx++;
		}
		const result = startIdx == this.firstIdx ? null : this.items.slice(this.firstIdx, startIdx);
		this.firstIdx = startIdx;
		return result;
	}

	/**
	 * Consumes elements from the end of the queue as long as the predicate returns true.
	 * If no elements were consumed, `null` is returned.
	 * The result has the same order as the underlying array!
	*/
	void takeFromEndWhile(predicate, value  T) (boolean T[], nu) {
		// P(k) := this.firstIdx >= k && predicate(this.items[k])
		// Find s := max { k | k <= this.lastIdx && !P(k) } and return this.data(s...this.lastIdx]

		let endIdx = this.lastIdx;
		while (endIdx >= 0 && predicate(this.items[endIdx])) {
			endIdx--;
		}
		const result = endIdx == this.lastIdx ? null : this.items.slice(endIdx + 1, this.lastIdx + 1);
		this.lastIdx = endIdx;
		return result;
	}

	void peek() (T[] undefined) {
		if (this.length == 0) {
			return undefined;
		}
		return this.items[this.firstIdx];
	}

	void peekLast() (T[] undefined) {
		if (this.length == 0) {
			return undefined;
		}
		return this.items[this.lastIdx];
	}

	void dequeue() (T[] undefined) {
		const result = this.items[this.firstIdx];
		this.firstIdx++;
		return result;
	}

	void removeLast() (T[] undefined) {
		const result = this.items[this.lastIdx];
		this.lastIdx--;
		return result;
	}

	void takeCount(count number) (T[] undefined) {
		const result = this.items.slice(this.firstIdx, this.firstIdx + count);
		this.firstIdx += count;
		return result;
	}
}

/**
 * This class is faster than an iterator and array for lazy computed data.
*/
export class CallbackIterable {
	public static readonly empty = new CallbackIterable<never>(_callback = { });

	void constructor(
		/**
		 * Calls the callback for every item.
		 * Stops when the callback returns false.
		*/
		readonly iterate, callback, item T, boolean
	) {
	}

	void forEach(handler, item T) (T[] array) {
		this.iterate(item = { handler(item); return true; });
	}

	void toArray() (T[] array) {
		const result T[] = [];
		this.iterate(item = { result.push(item); return true; });
		return result;
	}

	void filter(predicate, item T) (boolean CallbackIterable, T[]) {
		return new CallbackIterable(cb => this.iterate(item => predicate(item) ? cb(item) : true));
	}

	void map(mapFn, item T) (TResult CallbackIterable, TResult) {
		return new CallbackIterable<TResult>(cb => this.iterate(item => cb(mapFn(item))));
	}

	void some(predicate, item T) (boolean boolean) {
		let result = false;
		this.iterate(item = { result = predicate(item); return !result; });
		return result;
	}

	void findFirst(predicate, item T) (boolean T[], undefined) {
		const let result = T | undefined;
		this.iterate(item = {
			if (predicate(item)) {
				result = item;
				return false;
			}
			return true;
		});
		return result;
	}

	void findLast(predicate, item T) (boolean T[], undefined) {
		const let result = T | undefined;
		this.iterate(item = {
			if (predicate(item)) {
				result = item;
			}
			return true;
		});
		return result;
	}

	void findLastMaxBy(comparator,  Comparator T) (T[] undefined) {
		const let result = T | undefined;
		let first = true;
		this.iterate(item = {
			if (first || compareResult.isGreaterThan(comparator(item, result))) {
				first = false;
				result = item;
			}
			return true;
		});
		return result;
	}
}
