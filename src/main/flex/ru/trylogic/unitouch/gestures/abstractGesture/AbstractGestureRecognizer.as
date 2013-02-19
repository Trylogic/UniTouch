package ru.trylogic.unitouch.gestures.abstractGesture
{

	import flash.events.EventDispatcher;

	import ru.trylogic.unitouch.processor.ITouchListener;
	import ru.trylogic.unitouch.UniTouch;
	import ru.trylogic.unitouch.gestures.abstractGesture.states.*;
	import ru.trylogic.unitouch.processor.TouchContext;

	[Event(name="gesturePossible", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureBegan", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureChanged", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureRecognized", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureFailed", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureCanceled", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	[Event(name="gestureIdle", type="ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent")]
	public class AbstractGestureRecognizer extends EventDispatcher implements ITouchListener
	{
		protected var _target : *;

		private var _currentState : GestureState;

		public function get currentState() : GestureState
		{
			return _currentState;
		}

		public function get target() : *
		{
			return _target;
		}

		public function set target( value : * ) : void
		{
			if ( value == _target )
			{
				return;
			}

			if ( _target )
			{
				UniTouch.getTouchProcessor( _target ).removeTouchListener( this );

				setState( GestureStates.CANCELED );
			}

			_target = value;

			if ( _target )
			{
				UniTouch.getTouchProcessor( _target ).addTouchListener( this );
			}
		}

		public function AbstractGestureRecognizer()
		{
		}

		public function dispose() : void
		{
			target = null;
		}

		public function onTouchBegin( context : TouchContext ) : void
		{
			internalOnTouchBegin( context );
		}

		public function onTouchMove( context : TouchContext ) : void
		{
			if ( !isGestureIsOver() )
			{
				internalOnTouchMove( context );
			}
		}

		public function onTouchEnd( context : TouchContext ) : void
		{
			if ( !isGestureIsOver() )
			{
				internalOnTouchEnd( context );
			}
		}

		protected function isGestureIsOver() : Boolean
		{
			return  currentState == null ||
					currentState == GestureStates.CANCELED ||
					currentState == GestureStates.FAILED ||
					currentState == GestureStates.RECOGNIZED;
		}

		protected function setState( newState : GestureState ) : void
		{
			if ( newState == null )
			{
				return;
			}

			var oldState : GestureState = _currentState;

			if ( _currentState && !_currentState.nextStateAllowed( newState ) )
			{
				newState = GestureStates.FAILED;
			}

			_currentState = newState;
			const eventType : String = _currentState.toString();
			if ( hasEventListener( eventType ) )
			{
				dispatchEvent( new GestureEvent( eventType ) );
			}
			stateChanged( oldState, _currentState );
		}

		protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			trace( this, oldState, "->", newState );
		}

		protected function internalOnTouchBegin( context : TouchContext ) : void
		{
		}

		protected function internalOnTouchMove( context : TouchContext ) : void
		{
		}

		protected function internalOnTouchEnd( context : TouchContext ) : void
		{
		}
	}
}
