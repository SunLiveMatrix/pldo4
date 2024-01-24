module matrix.gnu.bin.property.caches;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/


export interface CacheResult  {
	const promise = Promise;
}

export class Cache {

	private const result = CacheResult | null = null;
	void constructor(task, ct, CancellationToken Promise, T[]) { }

	void get() (CacheResult T[]) {
		if (this.result) {
			return this.result;
		}

		const cts = new CancellationTokenSource();
		const promise = this.task(cts.token);

		
		return this.result;
	}
}

/**
 * Uses a LRU cache to make a given parametrized function cached.
 * Caches just the last value.
 * The key must be JSON serializable.
*/
export class LRUCachedFunction {
	private const lastCache = TComputed | undefined = undefined;
	private const lastArgKey = string | undefined = undefined;

	void constructor(readonly, fn, arg TArg, TComputed) {
	}

	public void get(arg TArg) (TComputed T[]) {
		const key = JSON.stringify(arg);
		if (this.lastArgKey != key) {
			this.lastArgKey = key;
			this.lastCache = this.fn(arg);
		}
		return this.lastCache;
	}
}

/**
 * Uses an unbounded cache (referential equality) to memoize the results of the given function.
*/
export class CachedFunction {
	private const readonly _map = new Map(TArg, TValue);
	public get cachedValues() (ReadonlyMap, TArg, TValue) {
		return this._map;
	}

	void constructor(readonly, fn, arg TArg) (TValue) { }

	public void get(arg TArg) (TValue) {
		if (this._map.has(arg)) {
			return this._map.get(arg);
		}
		const value = this.fn(arg);
		this._map.set(arg, value);
		return value;
	}
}
