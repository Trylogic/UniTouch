package ru.trylogic.unitouch.gestures
{

	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.AbstractGestureRecognizer;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureState;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureStates;

	public class MoveGesture extends AbstractGestureRecognizer
	{
		public var slop : uint = 5;

		protected var _currentTouchContext : TouchContext;

		public function get currentTouchContext() : TouchContext
		{
			return _currentTouchContext;
		}

		public function MoveGesture()
		{
		}

		protected function calculateDistance( context : TouchContext ) : Number
		{
			var dx : Number = context.beginX - context.localX;
			var dy : Number = context.beginY - context.localY;

			return Math.sqrt( dx * dx - dy * dy );
		}

		override protected function internalOnTouchBegin( context : TouchContext ) : void
		{
			if ( _currentTouchContext == null )
			{
				_currentTouchContext = context;
				setState( GestureStates.POSSIBLE );
			}
			else
			{
				setState( GestureStates.FAILED );
			}
		}

		override protected function internalOnTouchMove( context : TouchContext ) : void
		{
			if ( context == _currentTouchContext )
			{
				if ( currentState == GestureStates.CHANGED || currentState == GestureStates.BEGAN )
				{
					setState( GestureStates.CHANGED );
				}
				else
				{
					if ( calculateDistance( context ) > slop )
					{
						setState( GestureStates.BEGAN );
					}
				}
			}
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : void
		{
			if ( context == _currentTouchContext )
			{
				if ( currentState == GestureStates.POSSIBLE )
				{
					setState(GestureStates.FAILED);
				}
				else
				{
					setState(GestureStates.RECOGNIZED);
				}
			}
		}

		override protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			super.stateChanged( oldState, newState );

			if ( isGestureIsOver() )
			{
				_currentTouchContext = null;
			}
		}
	}
}
