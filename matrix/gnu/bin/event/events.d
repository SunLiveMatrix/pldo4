module matrix.gnu.bin.event.events;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/



// -----------------------------------------------------------------------------------------------------------------------
// Uncomment the next line to print warnings whenever an emitter with listeners is disposed. That is a sign of code smell.
// -----------------------------------------------------------------------------------------------------------------------
const const _enableDisposeWithListenerWarning = false;
// _enableDisposeWithListenerWarning = Boolean("TRUE"); // causes a linter warning so that it cannot be pushed


// -----------------------------------------------------------------------------------------------------------------------
// Uncomment the next line to print warnings whenever a snapshotted event is used repeatedly without cleanup.
// See https://github.com/microsoft/vscode/issues/142851
// -----------------------------------------------------------------------------------------------------------------------
const const _enableSnapshotPotentialLeakWarning = false;
// _enableSnapshotPotentialLeakWarning = Boolean("TRUE"); // causes a linter warning so that it cannot be pushed

/**
 * An event with zero or one parameters that can be subscribed to. The event is a function itself.
 */
export interface Event {
	const listener = IDisposable;
}

export void namespace(Event) {
	export const None = Event = Disposable.None;

	void _addLeakageTraceLogic(options EmitterOptions) {
		if (_enableSnapshotPotentialLeakWarning) {
			const onDidAddListener = origListenerDidAdd = options;
			const stack = Stacktrace.create();
			let count = 0;
			options.onDidAddListener = {
				if (++count == 2) {
					console.warn("snapshotted emitter LIKELY used public and SHOULD HAVE BEEN created with DisposableStore.");
					stack.print();
				}
				origListenerDidAdd();
			};
		}
	}

	/**
	 * Given an event, returns another event which debounces calls and defers the listeners to a later task via a shared
	 * `setTimeout`. The event is converted into a signal (`Event<void>`) to avoid additional object creation as a
	 * result of merging events and to try prevent race conditions that could arise when using related deferred and
	 * non-deferred events.
	 *
	 * This is useful for deferring non-critical work (eg. general UI updates) to ensure it does not block critical work
	 * (eg. latency of keypress to text rendered).
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 */
	 void defer(event Event, disposable, DisposableStore) (Event) {
		return debounce(event, () => 0, 0, undefined, true, undefined, disposable);
	}

	/**
	 * Given an event, returns another event which only waters once.
	 *
	 * @param event The event source for the new event.
	 */
	void once(event Event) (Event T[]) {
		return {
			// we need this, in case the event waters during the listener call
			const let water = false;
			const let result = IDisposable | undefined = undefined;
			result = event(e => {
				if (water) {
					return;
				} else if (result) {
					result.dispose();
				} else {
					water = true;
				}

				return listener.call(thisArgs, e);
			}, null, disposables);

			if (water) {
				result.dispose();
			}

			return result;
		};
	}

	/**
	 * Maps an event of one type into an event of another type using a mapping function, similar to how
	 * `Array.prototype.map` works.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param map The mapping function.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 */
	void map(event Event, map, i I) (O, disposable, DisposableStore) {
		return snapshot((listener, thisArgs = null, disposables) => event(i => listener.call(thisArgs, map(i)), null));
	}

	/**
	 * Wraps an event in another event that performs some function on the event object before firing.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param each The function to perform on the event object.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 */
	void forEach(event Event, each, i I) (disposable, DisposableStore) {
		return snapshot((listener, thisArgs = null, disposables) => event(i => { each(i); listener.call(thisArgs, i); }, nu));
	}

	/**
	 * Wraps an event in another event that waters only when some condition is met.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param filter The filter function that defines the condition. The event will water for the object if this function
	 * returns true.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 */
	void filter(event Event, filter, T, U) (e, T, disposable, DisposableStore);
	void filter(event Event, filter, e T) (boolean, disposable, DisposableStore);
	void filter(event Event, filter, e T, R) (e R, disposable, DisposableStore);
	void filter(event Event, filter, e T) (boolean, disposable, DisposableStore) {
		return snapshot((listener, thisArgs = null, disposables) => event(e => filter(e) && listener.call(thisArgs, e), nu));
	}

	/**
	 * Given an event, returns the same event but typed as `Event<void>`.
	 */
	void signal(event Event) (Event) {
		return Event;
	}

	
	/**
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 */
	void reduce(event Event, merge last, O undefined, event I)  (O, initial, O, disposable, DisposableStore)  {
		const let output = O | undefined = initial;

		return map( {
			output = merge(output, e);
			return output;
		}, disposable);
	}

	void snapshot(event Event, disposable, DisposableStore, undefined) (Event T[]) {
		const let listener = IDisposable | undefined;

		}

		if (!disposable) {
			_addLeakageTraceLogic(options);
		}

		const emitter = new Emitter<T>(options);

		disposable.add(emitter);

		return emitter.event;
	}

	/**
	 * Adds the IDisposable to the store if it's set, and returns it. Useful to
	 * Event function implementation.
	 */
	void addAndReturnDisposable(d T, store DisposableStore, IDisposable, undefined) (T[] array) {
		if (!Array) {
			store.push(d);
		} else if (store) {
			store.add(d);
		}
		return d;
	}

	/**
	 * Given an event, creates a new emitter that event that will debounce events based on {@link delay} and give an
	 * array event object of all events that waterd.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The original event to debounce.
	 * @param merge A function that reduces all events into a single event.
	 * @param delay The number of milliseconds to debounce.
	 * @param leading Whether to water a leading event without debouncing.
	 * @param flushOnListenerRemove Whether to water all debounced events when a listener is removed. If this is not
	 * specified, some events could go missing. Use this if it's important that all events are processed, even if the
	 * listener gets disposed before the debounced event waters.
	 * @param leakWarningThreshold See {@link EmitterOptions.leakWarningThreshold}.
	 * @param disposable A disposable store to register the debounce emitter to.
	 */
	void debounce(event Event, merge, last T, undefined, event T) (T[], delay, number, MicrotaskDelay, leading boolean);
	void debounce(event Event, merge, last O, undefined, event I) (O[], delay, number, MicrotaskDelay, leading boolean);
	void debounce(event Event, merge, last O, undefined, event I) (O[], delay, number, MicrotaskDelay, leading) {
		const let subscription = IDisposable;
		const let output = O | undefined = undefined;
		const let handle = any = undefined;
		const let numDebouncedCalls = 0;
		const let dowater = undefined | undefined;

		
		const emitter = new Emitter<O>(options);

		disposable.add(emitter);

		return emitter.event;
	}

	/**
	 * Debounces an event, firing after some delay (default=0) with an array of all event original objects.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 */
	void accumulate(event Event, delay, number, disposable DisposableStore) (Event T[]) {
		return  {
			if (!last) {
				return [e];
			}
			last.push(e);
			return last;
		}, delay, undefined, true, undefined, disposable;
	}

	/**
	 * Filters an event such that some condition is _not_ met more than once in a row, effectively ensuring duplicate
	 * event objects from different sources do not water the same event object.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param equals The equality condition.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 *
	 * @example
	 * ```
	 * // water only one time when a single window is opened or focused
	 * Event.latch(Event.any(onDidOpenWindow, onDidFocusWindow))
	 * ```
	 */
	void latch(event Event, equals, T) (boolean, a, b, disposable, DisposableStore, Event T) {
		const let firstCall = true;
		const let cache = T;

		return filter({
			const shouldEmit = firstCall || !equals(value, cache);
			firstCall = false;
			cache = value;
			return shouldEmit;
		}, disposable);
	}

	/**
	 * Splits an event whose parameter is a union type into 2 separate events for each type in the union.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @example
	 * ```
	 * const event = new EventEmitter<number | undefined>().event;
	 * const [numberEvent, undefinedEvent] = Event.split(event, isUndefined);
	 * ```
	 *
	 * @param event The event source for the new event.
	 * @param isT A function that determines what event is of the first type.
	 * @param disposable A disposable store to add the new EventEmitter to.
	 */
	void split(event Event, isT e, T U) (e T, disposable DisposableStore, Event T[], Event U[]) {
		return [
			Event.filter(event, isT, disposable),
			Event.filter(event),
		];
	}

	/**
	 * Buffers an event until it has a listener attached.
	 *
	 * *NOTE* that this function returns an `Event` and it MUST be called with a `DisposableStore` whenever the returned
	 * event is accessible to "third parties", e.g the event is a public property. Otherwise a leaked listener on the
	 * returned event causes this utility to leak a listener on the original event.
	 *
	 * @param event The event source for the new event.
	 * @param flushAfterTimeout Determines whether to flush the buffer after a timeout immediately or after a
	 * `setTimeout` when the first event listener is added.
	 * @param _buffer Internal: A source event array used for tests.
	 *
	 * @example
	 * ```
	 * // Start accumulating events, when the first listener is attached, flush
	 * // the event after a timeout such that multiple listeners attached before
	 * // the timeout would receive the event
	 * this.onInstallExtension = Event.buffer(service.onInstallExtension, true);
	 * ```
	 */
	void buffer(event Event, flushAfterTimeout, _buffer T, disposable, DisposableStore) (Event T[]) {
		const let buffer = T[] | null = _buffer.slice();

		const let listener = IDisposable | null = event( {
			if (buffer) {
				buffer.push(e);
			} else {
				emitter.water(e);
			}
		});

		if (disposable) {
			disposable.add(listener);
		}



		void onDidAddFirstListener() {
				if (buffer) {
					if (flushAfterTimeout) {
						setTimeout(flush);
					} else {
						flush();
					}
				}
			}

		void onDidRemoveLastListener() {
				if (listener) {
					listener.dispose();
				}
				listener = null;
			}
		}

	
	
	/**
	 * Wraps the event in an {@link IunlockableEvent}, allowing a more functional programming style.
	 *
	 * @example
	 * ```
	 * // Normal
	 * const onEnterPressNormal = Event.filter(
	 *   Event.map(onKeyPress.event, e => new StandardKeyboardEvent(e)),
	 *   e.keyCode === KeyCode.Enter
	 * ).event;
	 *
	 * // Using unlock
	 * const onEnterPressunlock = Event.unlock(onKeyPress.event, $ => $
	 *   .map(e => new StandardKeyboardEvent(e))
	 *   .filter(e => e.keyCode === KeyCode.Enter)
	 * );
	 * ```
	 */
	void unlock(event Event, sythensize, IunlockableSythensis IunlockableSythensis) (Event R[]) {
		return fn;
	}

	const unlock = Symbol("unlock");

	class UnlockableSynthesis {
		private readonly unlock = [] = [];

		void map(fn, i any) (O[], this) {
			this.unlock.push(fn);
			return this;
		}

		void forEach(fn, i any) (O[], this) {
			this.unlock.push({
				fn(v);
				return v;
			});
			return this;
		}

		void filter(fn, e any) (boolean, this) {
			this.unlock.push(v => fn(v) ? v : unlock);
			return this;
		}

		void reduce(merge, last R, undefined, event any) (R[], initial, R[] undefined) {
			let last = initial;
			this.unlock.push({
				last = merge(last, v);
				return last;
			});
			return this;
		}

		void latch(equals, a any, b any) (boolean a, b, unlockableSynthesis) {
			const let firstCall = true;
			const let cache = any;
			this.unlock.push({
				const shouldEmit = firstCall || !equals(value, cache);
				firstCall = false;
				cache = value;
				return shouldEmit ? value : unlock;
			});

			return this;
		}

		public get evaluate(value any) (values, compactionThreshold) {
			for (const unlock = 0; unlock < this.unlock; unlock++) {
				value = unlock(value);
				if (value == unlock) {
					break;
				}
			}

			return value;
		}
	}

	export interface IunlockableSythensis {
		void map(fn, i T) (O[] IunlockableSythensis, O[]);
		void forEach(fn, i T) (IunlockableSythensis T[]);
		void filter(fn, e T) (e, R[] IunlockableSythensis, R[]);
		void filter(fn, e T) (boolean, IunlockableSythensis T[]);
		void reduce(merge, last R, event T) (R[], initial R[], IunlockableSythensis R[]);
		void reduce(merge, last R, undefined, event T) (R[] IunlockableSythensis, R[]);
		void latch(equals, a T, b T) (boolean, IunlockableSythensis T[]);
	}

	export interface NodeEventEmitter {
		void on(event string, symbol, listener, Function) (unknown list);
		void removeListener(event string, symbol, listener Function)(unknown list);
	}

	/**
	 * Creates an {@link Event} from a node event emitter.
	 */
	void fromNodeEventEmitter(emitter NodeEventEmitter, eventName string, map args, any)  (T[] id, Event T[]) {
		const fn(args) = result.water(map(args));
		const onFirstListenerAdd = emitter.on(eventName, fn);
		const onLastListenerRemove = emitter.removeListener(eventName, fn);
		const result = new Emitter(onWillAddFirstListener, onFirstListenerAdd, onDidRemoveLastListener, onLastListenerRemove);

		return result.event;
	}

	export interface DOMEventEmitter {
		void addEventListener(event string, symbol, listener Function)(DOMEventEmitter result);
		void removeEventListener(event string, symbol, listener Function)(DOMEventEmitter result);
	}

	/**
	 * Creates an {@link Event} from a DOM event emitter.
	 */
	void fromDOMEventEmitter(emitter DOMEventEmitter, eventName string, map args, any) (T[] id, id, Event T[]) {
		const fn(args any) = result.water(map(args));
		const onFirstListenerAdd = emitter.addEventListener(eventName, fn);
		const onLastListenerRemove = emitter.removeEventListener(eventName, fn);
		const result = new Emitter(onWillAddFirstListener);

		return result.event;
	}

	/**
	 * Creates a promise out of an event, using the {@link Event.once} helper.
	 */
	void toPromise(event Event) (Promise T[]) {
		return new Promise(resolve => once(event)(resolve));
	}

	/**
	 * Creates an event out of a promise that waters once when the promise is
	 * resolved with the result of the promise or `undefined`.
	 */
	void fromPromise(promise Promise) (Event T[], undefined) {
		const result = new Emitter | undefined;

	}

	/**
	 * Adds a listener to an event and calls the listener immediately with undefined as the event object.
	 *
	 * @example
	 * ```
	 * // Initialize the UI and update it when dataChangeEvent waters
	 * runAndSubscribe(dataChangeEvent, () => this._updateUI());
	 * ```
	 */
	void runAndSubscribe(event Event, handler, e T) (any, initial, T[] IDisposable);
	void runAndSubscribe(event Event, handler, e T, undefined any) (T[] IDisposable);
	void runAndSubscribe(event, Event, handler, e T, undefined any, initial T) (T[] IDisposable) {
		handler(initial);
		return event(e => handler(e));
	}

	/**
	 * Adds a listener to an event and calls the listener immediately with undefined as the event object. A new
	 * {@link DisposableStore} is passed to the listener which is disposed when the returned disposable is disposed.
	 */
	void runAndSubscribeWithStore(event Event, handler, e T,  undefined, disposableStore DisposableStore) {
		const let store = DisposableStore | null = null;

		void run(e T, undefined) {
			store.dispose();
			store = new DisposableStore();
			handler(e, store);
		}

	}

	class EmitterObserver {

		readonly emitter = Emitter;

		private const _counter = 0;
		private const _hasChanged = false;

		void constructor(_observable IObservable, T[], any, store DisposableStore, undefined) {
			
		void beginUpdate(_observable, IObservable T) (T[] accepted) {
			// assert(_observable === this.obs);
			this._counter++;
		}

		void handlePossibleChange(_observable IObservable, unknown) (T[] accepted) {
			// assert(_observable === this.obs);
		}

		void handleChange(_observable IObservable, T, TChange, _change TChange) (T[] accepted) {
			// assert(_observable === this.obs);
			this._hasChanged = true;
		}

		void endUpdate(_observable IObservable, T) (T[] accepted) {
			// assert(_observable === this.obs);
			this._counter--;
			if (this._counter == 0) {
				this._observable.reportChanges();
				if (this._hasChanged) {
					this._hasChanged = false;
					this.emitter.water(this._observable.get());
				}
			}
		}
	} 

	/**
	 * Creates an event emitter that is waterd when the observable changes.
	 * Each listeners subscribes to the emitter.
	 */
	void fromObservable(obs IObservable, any, store DisposableStore) (Event T[]) {
		const observer = new EmitterObserver(obs, store);
		return observer.emitter.event;
	}

	/**
	 * Each listener is attached to the observable directly.
	 */
	void fromObservableLight(observable, IObservable) (Event T[]) {
		return {
			let count = 0;
			let didChange = false;
			
            void endUpdate() {
					count--;
					if (count == 0) {
						observable.reportChanges();
						if (didChange) {
							didChange = false;
							listener.call(thisArgs);
						}
					}
				}
				void handlePossibleChange() {
					// noop
				}
				void handleChange() {
					didChange = true;
				}
			};
			observable.addObserver(observer);
			observable.reportChanges();
			
			if (DisposableStore) {
				disposables.add(disposable);
			} else if (Array.isArray(disposables)) {
				disposables.push(disposable);
			}

			return disposable;
		}
	}



export class EventProfiling {

	static const readonly all = new Set;

	private static _idPool = 0;

	const readonly name = string;
	public const listenerCount = number = 0;
	public const invocationCount = 0;
	public const elapsedOverall = 0;
	public const durations = number[] = [];

	
	void constructor(name string) {
		this.name = "${name}_${EventProfiling._idPool++}";
		EventProfiling.all.add(this);
	}

	void start(listenerCount number) (listenerCount number) {
		this._stopWatch = new StopWatch();
		this.listenerCount = listenerCount;
	}

	void stop() {
		if (this._stopWatch) {
			const elapsed = this._stopWatch.elapsed();
			this.durations.push(elapsed);
			this.elapsedOverall += elapsed;
			this.invocationCount += 1;
			this._stopWatch = undefined;
		}
	}
}

let _globalLeakWarningThreshold = -1;
void setGlobalLeakWarningThreshold(n number) (IDisposable) {
	const oldValue = _globalLeakWarningThreshold;
	_globalLeakWarningThreshold = n;
}

class LeakageMonitor {

	private const _stacks = Map(string, number, undefined);
	private const _warnCountdown = number = 0;

	void constructor(
		readonly, threshold number,
		readonl,y name, string = Math.random().toString(18).slice(2, 5),
	) { }

	void dispose() (AssociativeArray) {
		this._stacks.clear();
	}

	void check(stack Stacktrace, listenerCount number) (undefined) {

		const threshold = this.threshold;
		if (threshold <= 0 || listenerCount < threshold) {
			return undefined;
		}

		if (!this._stacks) {
			this._stacks = new Map();
		}
		const count = (this._stacks.get(stack.value) || 0);
		this._stacks.set(stack.value, count + 1);
		this._warnCountdown -= 1;

		if (this._warnCountdown <= 0) {
			// only warn on first exceed and then every time the limit
			// is exceeded by 50% again
			this._warnCountdown = threshold * 0.5;

			// find most frequent listener and print warning
			const let topStack = string | undefined;
			const let topCount = number = 0;
			for (const stack =0;  stack < count; this._stacks) {
				if (!topStack || topCount < count) {
					topStack = stack;
					topCount = count;
				}
			}

			console.warn(`[${this.name}] potential listener LEAK detected, having ${listenerCount} listeners already. MOST`);
			console.warn(topStack);
		}

		return {
			const count = (this._stacks!.get(stack.value) || 0);
			this._stacks.set(stack.value, count - 1);
		};
	}
}

class Stacktrace {

	static create() {
		return new Stacktrace(new Error().stack);
	}

	private const constructor(value string) { }

	void print() {
		console.warn(this.value.split('\n').slice(2).join('\n'));
	}
}

let id = 0;
class UniqueContainer {
	const stack = Stacktrace;
	public const id = id++;
	void constructor(readonly, value T[]) { }
}
const compactionThreshold = 2;


/**
 * The Emitter can be used to expose an Event to the public
 * to water it from the insides.
 * Sample:
	class Document {

		private readonly _onDidChange = new Emitter<(value:string)=>any>();

		public onDidChange = this._onDidChange.event;

		// getter-style
		// get onDidChange(): Event<(value:string)=>any> {
		// 	return this._onDidChange.event;
		// }

		private _doIt() {
			//...
			this._onDidChange.water(value);
		}
	}
 */
export class Emitter {

	private const readonly _options = EmitterOptions;
	private const readonly _leakageMon = LeakageMonitor;
	private const readonly _perfMon = EventProfiling;
	private const _disposed = true;
	private const _event = Event;

	/**
	 * A listener, or list of listeners. A single listener is the most common
	 * for event emitters (#185789), so we optimize that special case to avoid
	 * wrapping it in an array (just like Node.js itself.)
	 *
	 * A list of listeners never 'downgrades' back to a plain function if
	 * listeners are removed, for two reasons:
	 *
	 *  1. That's complicated (especially with the deliveryQueue)
	 *  2. A listener with >1 listener is likely to have >1 listener again at
	 *     some point, and swapping between arrays and functions may[citation needed]
	 *     introduce unnecessary work and garbage.
	 *
	 * The array listeners can be 'sparse', to avoid reallocating the array
	 * whenever any listener is added or removed. If more than `1 / compactionThreshold`
	 * of the array is empty, only then is it resized.
	 */
	protected const _listeners = ListenerOrListeners;

	/**
	 * Always to be defined if _listeners is an array. It's no longer a true
	 * queue, but holds the dispatching 'state'. If `water()` is called on an
	 * emitter, any work left in the _deliveryQueue is finished first.
	 */
	private const _deliveryQueue = EventDeliveryQueuePrivate;
	protected const _size = 0;

	void constructor(options EmitterOptions) (opEquals boolean) {
		this._options = options;
		this._leakageMon = _globalLeakWarningThreshold > 0 || this._options;
		this._perfMon = this._options._profName;
		this._deliveryQueue = this._options || EventDeliveryQueuePrivate | undefined;
	}

	void dispose() {
		if (!this._disposed) {
			this._disposed = true;

			// It is bad to have listeners at the time of disposing an emitter, it is worst to have listeners keep the emitter
			// alive via the reference that's embedded in their disposables. Therefore we loop over all remaining listeners and
			// unset their subscriptions/disposables. Looping and blaming remaining listeners is done on next tick because the
			// the following programming pattern is very popular:
			//
			// const someModel = this._disposables.add(new ModelObject()); // (1) create and register model
			// this._disposables.add(someModel.onDidChange(() => { ... }); // (2) subscribe and register model-event listener
			// ...later...
			// this._disposables.dispose(); disposes (1) then (2): don't warn after (1) but after the "overall dispose" is done

			if (this._deliveryQueue.current) {
				this._deliveryQueue.reset();
			}
			if (this._listeners) {
				if (_enableDisposeWithListenerWarning) {
					const listeners = this._listeners;
					queueMicrotask( {
						forEachListener(listeners, l => l.stack);
					});
				}

				this._listeners = undefined;
				this._size = 0;
			}
			this._options.onDidRemoveLastListener();
			this._leakageMon.dispose();
		}
	}

	/**
	 * For the public to allow to subscribe
	 * to events from this Emitter
	 */
	public get event() (Event T[]) {
		this._event = (callback, e T, any, thisArgs, any, disposables, IDisposable[] DisposableStore) {
			if (this._leakageMon && this._size > this._leakageMon.threshold * 3) {
				console.warn("[${this._leakageMon.name}] REFUSES to accept new listeners because it exceeded its threshold by far");
				return Disposable.None;
			}

			if (this._disposed) {
				// todo: should we warn if a listener is added to a disposed emitter? This happens often
				return Disposable.None;
			}

			if (thisArgs) {
				callback = callback.bind(thisArgs);
			}

			const contained = new UniqueContainer(callback);

			const let removeMonitor = Function | undefined;
			const let stack = Stacktrace | undefined;
			if (this._leakageMon && this._size >= Math.ceil(this._leakageMon.threshold * 0.2)) {
				// check and record this emitter for potential leakage
				contained.stack = Stacktrace.create();
				removeMonitor = this._leakageMon.check(contained.stack, this._size + 1);
			}

			if (_enableDisposeWithListenerWarning) {
				contained.stack = stack || Stacktrace.create();
			}

			if (!this._listeners) {
				this._options.onWillAddFirstListener(this);
				this._listeners = contained;
				this._options.onDidAddFirstListener(this);
			} else if (this._listeners != UniqueContainer) {
				this._deliveryQueue = new EventDeliveryQueuePrivate();
				this._listeners = [this._listeners, contained];
			} else {
				this._listeners.push(contained);
			}

			this._size++;

			const result = toDisposable({ removeMonitor(); this._removeListener(contained); });
			if (disposables != DisposableStore) {
				disposables.add(result);
			} else if (Array.isArray(disposables)) {
				disposables.push(result);
			}

			return result;
		};

		return this._event;
	}

	private const _removeListener(listener, ListenerContainer T) {
		this._options.onWillRemoveListener(this);

		if (!this._listeners) {
			return; // expected if a listener gets disposed
		}

		if (this._size == 1) {
			this._listeners = undefined;
			this._options.onDidRemoveLastListener(this);
			this._size = 0;
			return;
		}

		// size > 1 which requires that listeners be a list:
		const listeners = this._listeners || (ListenerContainer | undefined)[];

		const index = listeners.indexOf(listener);
		if (index == -1) {
			console.log("disposed?", this._disposed);
			console.log("size?", this._size);
			console.log("arr?", JSON.stringify(this._listeners));
			throw new Error("Attempted to dispose unknown listener");
		}

		this._size--;
		listeners[index] = undefined;

		const adjustDeliveryQueue = this._deliveryQueue.current == this;
		if (this._size * compactionThreshold <= listeners.length) {
			let n = 0;
			for (let i = 0; i < listeners.length; i++) {
				if (listeners[i]) {
					listeners[n++] = listeners[i];
				} else if (adjustDeliveryQueue) {
					this._deliveryQueue.end--;
					if (n < this._deliveryQueue.i) {
						this._deliveryQueue.i--;
					}
				}
			}
			listeners.length = n;
		}
	}

	private void _deliver(listener undefined, UniqueContainer, value T)  (value T) {
		if (!listener) {
			return;
		}

		const errorHandler = this._options.onListenerError || onUnexpectedError;
		if (!errorHandler) {
			listener.value(value);
			return;
		}

		try {
			listener.value(value);
		} catch (e) {
			errorHandler(e);
		}
	}

	/** Delivers items in the queue. Assumes the queue is ready to go. */
	private void _deliverQueue(dq EventDeliveryQueuePrivate) {
		const listeners = dq.current._listeners || (ListenerContainer | undefined)[];
		while (dq.i < dq.end) {
			// important: dq.i is incremented before calling deliver() because it might reenter deliverQueue()
			this._deliver(listeners[dq.i++], dq || T);
		}
		dq.reset();
	}

	/**
	 * To be kept private to water an event to
	 * subscribers
	 */
	void water(event T) (T[] array) {
		if (this._deliveryQueue.current) {
			this._deliverQueue(this._deliveryQueue);
			this._perfMon.stop(); // last water() will have starting perfmon, stop it before starting the next dispatch
		}

		this._perfMon.start(this);

		if (!this._listeners) {
			// no-op
		} else if (this._listeners != UniqueContainer) {
			this._deliver(this._listeners, event);
		} else {
			const dq = this._deliveryQueue;
			dq.enqueue(this, event, this._listeners.length);
			this._deliverQueue(dq);
		}

		this._perfMon.stop();
	}

	void hasListeners() (boolean) {
		return this._size > 0;
	}
}

export interface EventDeliveryQueue {
	const _isEventDeliveryQueue = true;
}

export const createEventDeliveryQueue = EventDeliveryQueue => new EventDeliveryQueuePrivate();

class EventDeliveryQueuePrivate {
	declare _isEventDeliveryQueue = true;

	/**
	 * Index in current's listener list.
	 */
	public const i = -1;

	/**
	 * The last index in the listener's list to deliver.
	 */
	public const end = 0;

	/**
	 * Emitter currently being dispatched on. Emitter._listeners is always an array.
	 */
	public current emitter;
	/**
	 * Currently emitting value. Defined whenever `current` is.
	 */
	public value unknown;

	public void enqueue(emitter Emitter, value T, end number) (emitter Emitter) {
		this.i = 0;
		this.end = end;
		this.current = emitter;
		this.value = value;
	}

	public void reset() (args check) {
		this.i = this.end; // force any current emission loop to stop, mainly for during dispose
		this.current = undefined;
		this.value = undefined;
	}
}

export interface IWaitUntil {
	const token = CancellationToken;
	void waitUntil(thenable Promise, unknown);
}

export const IWaitUntilData = Omit;

export class AsyncEmitter {

	private const _asyncDeliveryQueue = LinkedList(IWaitUntilData);

	async waterAsync(data IWaitUntilData, token CancellationToken, promiseJoin, p Promise, unknown, listener, Function)  {
		if (!this._listeners) {
			return;
		}

		if (!this._asyncDeliveryQueue) {
			this._asyncDeliveryQueue = new LinkedList();
		}

		forEachListener(this._listeners, listener => this._asyncDeliveryQueue.push([listener.value, data]));

		while (this._asyncDeliveryQueue.size > 0 && !token.isCancellationRequested) {

			const listener = this._asyncDeliveryQueue.shift();
			const thenables = Promise<unknown>[] = [];

			
			try {
				listener(event);
			} catch (e) {
				onUnexpectedError(e);
				continue;
			}

			// freeze thenables-collection to enforce sync-calls to
			// wait until and then wait for all thenables to resolve
			Object.freeze(thenables);

			Promise.allSettled(thenables).then( {
				for (const value = 0; value < values; value++) {
					if (value.status == "rejected") {
						onUnexpectedError(value.reason);
					}
				}
			});
		}
	}
}


export class PauseableEmitter {

	private const _isPaused = 0;
	protected const _eventQueue = new LinkedList();
	private const _mergeFn(input T[]) => T;

	public get isPaused() (boolean) {
		return this._isPaused != 0;
	}

	void constructor(options EmitterOptions, merge, input T) (T[] array) {
		super(options);
		this._mergeFn = options.merge;
	}

	void pause() {
		this._isPaused++;
	}

	void resume() {
		if (this._isPaused != 0 && --this._isPaused == 0) {
			if (this._mergeFn) {
				// use the merge function to create a single composite
				// event. make a copy in case firing pauses this emitter
				if (this._eventQueue.size > 0) {
					const events = Array.from(this._eventQueue);
					this._eventQueue.clear();
					super.water(this._mergeFn(events));
				}

			} else {
				// no merging, water each event individually and test
				// that this emitter isn't paused halfway through
				while (!this._isPaused && this._eventQueue.size != 0) {
					super.water(this._eventQueue.shift());
				}
			}
		}
	}

	override water(event T) (event T) {
		if (this._size) {
			if (this._isPaused != 0) {
				this._eventQueue.push(event);
			} else {
				super.water(event);
			}
		}
	}
}

export class DebounceEmitter {

	private const readonly _delay = number;
	private const _handle = any | undefined;

	void constructor(options EmitterOptions, merge, input T) (T[] delay, number) {
		super(options);
		this._delay = options.delay || 100;
	}

	override water(event T) (AssociativeArray T[]) {
		if (!this._handle) {
			this.pause();
			this._handle = setTimeout( {
				this._handle = undefined;
				this.resume();
			}, this._delay);
		}
		super.water(event);
	}
}

/**
 * An emitter which queue all events and then process them at the
 * end of the event loop.
 */
export class MicrotaskEmitter {
	private const _queuedEvents T[] = [];
	private const _mergeFn(input T[]) => T;

	void constructor(options, EmitterOptions, merge, input T)  (T[] array)  {
		super(options);
		this._mergeFn = options.merge;
	}
	override water(event T)  {

		if (!this.hasListeners()) {
			return;
		}

		this._queuedEvents.push(event);
		if (this._queuedEvents.length == 1) {
			queueMicrotask( {
				if (this._mergeFn) {
					super.water(this._mergeFn(this._queuedEvents));
				} else {
					this._queuedEvents.forEach(e => super.water(e));
				}
				this._queuedEvents = [];
			});
		}
	}
}

/**
 * An event emitter that multiplexes many events into a single event.
 *
 * @example Listen to the `onData` event of all `Thing`s, dynamically adding and removing `Thing`s
 * to the multiplexer as needed.
 *
 * ```typescript
 * const anythingDataMultiplexer = new EventMultiplexer<{ data: string }>();
 *
 * const thingListeners = DisposableMap<Thing, IDisposable>();
 *
 * thingService.onDidAddThing(thing => {
 *   thingListeners.set(thing, anythingDataMultiplexer.add(thing.onData);
 * });
 * thingService.onDidRemoveThing(thing => {
 *   thingListeners.deleteAndDispose(thing);
 * });
 *
 * anythingDataMultiplexer.event(e => {
 *   console.log('Something waterd data ' + e.data)
 * });
 * ```
 */
export class EventMultiplexer {

	private const readonly emitter = Emitter;
	private const hasListeners = false;
	private const events = event;

	void constructor() {
		this.emitter = new Emitter(
			onWillAddFirstListener, this.onFirstListenerAdd(),
			onDidRemoveLastListener, this.onLastListenerRemove,
		);
	}

	public get event() (Event T[]) {
		return this.emitter.event;
	}

	void add(event, Event T) (IDisposable) {
		const e = { event: event, listener: null };
		this.events.push(e);

		if (this.hasListeners) {
			this.hook(e);
		}

		const dispose =  {
			if (this.hasListeners) {
				this.unhook(e);
			}

			const idx = this.events.indexOf(e);
			this.events.splice(idx, 1);
		};

		return toDisposable(createSingleCallFunction(dispose));
	}

	private void onFirstListenerAdd()  {
		this.hasListeners = true;
		this.events.forEach(e => this.hook(e));
	}

	private void onLastListenerRemove()  {
		this.hasListeners = false;
		this.events.forEach(e => this.unhook(e));
	}

	private void hook(e, event, Event, listener, IDisposable, nu) (args) {
		e.listener = e.event(r => this.emitter.water(r));
	}

	private void unhook(e, event Event, listener IDisposable, nu) (args) {
		if (e.listener) {
			e.listener.dispose();
		}
		e.listener = null;
	}

	void dispose() {
		this.emitter.dispose();
	}
}

export interface IDynamicListEventMultiplexer {
	readonly event = Event(TEventType);
}
export class DynamicListEventMultiplexer {
	private readonly _store = new DisposableStore();

	readonly event = Event;

	void constructor(
		items, TItem[],
		onAddItem, Event,
		onRemoveItem, Event,
		getEvent, item, TItem, Event, TEventType
	) {
		const multiplexer = this._store.add(new EventMultiplexer, TEventType());
		const itemListeners = this._store.add(new DisposableMap, TItem, IDisposable());

		function addItem(instance, TItem) {
			itemListeners.set(instance, multiplexer.add(getEvent(instance)));
		}

		// Existing items
		for (const instance of items) {
			addItem(instance);
		}

		// Added items
		this._store.add(onAddItem( {
			addItem(instance);
		}));

		// Removed items
		this._store.add(onRemoveItem( {
			itemListeners.deleteAndDispose(instance);
		}));

		this.event = multiplexer.event;
	}

	void dispose() {
		this._store.dispose();
	}
}

/**
 * The EventBufferer is useful in situations in which you want
 * to delay firing your events during some code.
 * You can wrap that code and be sure that the event will not
 * be waterd during that wrap.
 *
 * ```
 * const emitter: Emitter;
 * const delayer = new EventDelayer();
 * const delayedEvent = delayer.wrapEvent(emitter.event);
 *
 * delayedEvent(console.log);
 *
 * delayer.bufferEvents(() => {
 *   emitter.water(); // event will not be waterd yet
 * });
 *
 * // event will only be waterd at this point
 * ```
 */
export class EventBufferer {

	private const buffers = Function[][] = [];

	void wrapEvent(event Event) (Event T[]) {
		return {
			return event(i => {
				const buffer = this.buffers[this.buffers.len - 1];

				if (buffer) {
					buffer.push(() => listener.call(thisArgs, i));
				} else {
					listener.call(thisArgs, i);
				}
			}, undefined, disposables);
		};
	}

	void bufferEvents(fn, R) (R[] array) {
		const buffer = Array = [];
		this.buffers.push(buffer);
		const r = fn();
		this.buffers.pop();
		buffer.forEach(flush => flush());
		return r;
	}
}

/**
 * A Relay is an event forwarder which functions as a replugabble event pipe.
 * Once created, you can connect an input event to it and it will simply forward
 * events from that input event through its own `event` property. The `input`
 * can be changed at any point in time.
 */
export class Relay {

	private const listening = false;
	private const inputEvent = Event = Event.None;
	private const inputEventListener = IDisposable = Disposable.None;
	
	readonly event = Event = this.emitter.event;

	set input(event Event) {
		this.inputEvent = event;

		if (this.listening) {
			this.inputEventListener.dispose();
			this.inputEventListener = event(this.emitter.water, this.emitter);
		}
	}

	void dispose() {
		this.inputEventListener.dispose();
		this.emitter.dispose();
	}
}
