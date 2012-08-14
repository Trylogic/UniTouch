package ru.trylogic.unitouch.gestures.abstract
{

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.trylogic.unitouch.ITouchListener;
	import ru.trylogic.unitouch.ITouchProcessor;
	import ru.trylogic.unitouch.UniTouchProcessor;
	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.states.*;

	[Event(name="gesturePossible", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureBegan", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureChanged", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureRecognized", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureFailed", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureCanceled", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	[Event(name="gestureIdle", type="ru.trylogic.unitouch.gestures.abstract.GestureEvent")]
	public class AbstractGestureRecognizer extends EventDispatcher implements ITouchListener
	{
		protected static const touchProcessorsByTarget : Dictionary = new Dictionary( true );
		protected var _target : *;

		private var _currentState : GestureState;

		public function get currentState() : GestureState
		{
			return _currentState;
		}

		public function set target( value : * ) : void
		{
			if ( value == _target )
			{
				return;
			}

			var touchProcessor : ITouchProcessor;

			if ( _target )
			{
				touchProcessor = touchProcessorsByTarget[_target];
				if ( touchProcessor )
				{
					touchProcessor.removeGestureRecognizer( this );
				}

				setState( GestureStates.POSSIBLE );
			}

			_target = value;

			if ( _target )
			{
				touchProcessor = touchProcessorsByTarget[_target];
				if ( !touchProcessor )
				{
					touchProcessorsByTarget[_target] = touchProcessor = new UniTouchProcessor( _target );
				}

				touchProcessor.addGestureRecognizer( this );
			}
		}

		public function AbstractGestureRecognizer()
		{
		}

		protected function isGestureIsOver() : Boolean
		{
			return  currentState == GestureStates.CANCELED ||
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
			if(hasEventListener(_currentState.toString()))
			{
				dispatchEvent(new GestureEvent(_currentState.toString()));
			}
			stateChanged( oldState, _currentState );
		}

		protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			trace( this, oldState, "->", newState );
		}

		public final function onTouchBegin( context : TouchContext ) : void
		{
			internalOnTouchBegin( context );
		}

		public final function onTouchMove( context : TouchContext ) : void
		{
			if(!isGestureIsOver())
			{
				internalOnTouchMove( context );
			}
		}

		public final function onTouchEnd( context : TouchContext ) : void
		{
			if(!isGestureIsOver())
			{
				internalOnTouchEnd( context );
			}
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
