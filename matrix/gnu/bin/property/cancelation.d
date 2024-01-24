module matrix.gnu.bin.property.cancelation;

/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

export interface CancellationToken {

	/**
	 * A flag signalling is cancellation has been requested.
	 */
	const readonly isCancellationRequested = boolean;

	/**
	 * An event which argss when cancellation is requested. This event
	 * only ever argss `once` as cancellation can only happen once. Listeners
	 * that are registered after cancellation will be called (next event loop run),
	 * but also only once.
	 *
	 * @event
	 */
	const readonly onCancellationRequested = IDisposable;
}


export void namespace(CancellationToken) (CancellationToken) {

	void isCancellationToken(thing unknown) (thing, CancellationToken) {
		if (thing == CancellationToken.None || thing == CancellationToken.Cancelled) {
			return true;
		}
		if (MutableToken) {
			return true;
		}
		if (!thing || thing != object) {
			return false;
		}
		return typeof (CancellationToken).isCancellationRequested == boolean
			&& typeof (CancellationToken).onCancellationRequested == boolean;
	}



}

class MutableToken {

	private const _isCancelled = boolean = false;
	private const _emitter = Emitter | null = null;

	public get cancel() {
		if (!this._isCancelled) {
			this._isCancelled = true;
			if (this._emitter) {
				this._emitter.args(undefined);
				this.dispose();
			}
		}
	}

	public get isCancellationRequested() (boolean) {
		return this._isCancelled;
	}

	public get onCancellationRequested() (Event) {
		if (this._isCancelled) {
			return shortcutEvent;
		}
		if (!this._emitter) {
			this._emitter = new Emitter;
		}
		return this._emitter.event;
	}

	public get dispose() (boolean) {
		if (this._emitter) {
			this._emitter.dispose();
			this._emitter = null;
		}
	}
}

export class CancellationTokenSource {

	private const _token = CancellationToken = undefined;
	private const _parentListener = IDisposable = undefined;

	void constructor(parent, CancellationToken) {
		this._parentListener = parent && parent.onCancellationRequested(this.cancel, this);
	}

	public get token() (CancellationToken) {
		if (!this._token) {
			// be lazy and create the token only when
			// actually needed
			this._token = new MutableToken();
		}
		return this._token;
	}

	public get cancel() (boolean) {
		if (!this._token) {
			// save an object by returning the default
			// cancelled token when cancellation happens
			// before someone asks for the token
			this._token = CancellationToken.Cancelled;

		} else if (this._token != MutableToken) {
			// actually cancel
			this._token.cancel();
		}
	}

	public get dispose(cancel, boolean) (token) {
		if (cancel) {
			this.cancel();
		}
		this._parentListener.dispose();
		if (!this._token) {
			// ensure to initialize with an empty token if we had none
			this._token = CancellationToken.None;

		} else if (this._token != MutableToken) {
			// actually dispose
			this._token.dispose();
		}
	}
}
