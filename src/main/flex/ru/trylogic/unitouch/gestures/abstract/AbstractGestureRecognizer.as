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

		protected function setState( newState : GestureState ) : Boolean
		{
			if ( newState == null )
			{
				return false;
			}

			var oldState : GestureState = _currentState;

			if ( _currentState && !_currentState.nextStateAllowed( newState ) )
			{
				_currentState = GestureStates.FAILED;
				stateChanged( oldState, _currentState );
				return false;
			}

			_currentState = newState;
			stateChanged( oldState, _currentState );
			return true;
		}

		protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			trace( this, oldState, "->", newState );
		}

		public final function onTouchBegin( context : TouchContext ) : void
		{
			setState( internalOnTouchBegin( context ) );
		}

		public final function onTouchMove( context : TouchContext ) : void
		{
			if(!isGestureIsOver())
			{
				setState( internalOnTouchMove( context ) );
			}
		}

		public final function onTouchEnd( context : TouchContext ) : void
		{
			if(!isGestureIsOver())
			{
				setState( internalOnTouchEnd( context ) );
			}
		}

		protected function internalOnTouchBegin( context : TouchContext ) : GestureState
		{
			return null;
		}

		protected function internalOnTouchMove( context : TouchContext ) : GestureState
		{
			return null;
		}

		protected function internalOnTouchEnd( context : TouchContext ) : GestureState
		{
			return null;
		}
	}
}
