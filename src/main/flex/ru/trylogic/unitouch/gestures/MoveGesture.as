package ru.trylogic.unitouch.gestures
{

	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.AbstractGestureRecognizer;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureState;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureStates;

	public class MoveGesture extends AbstractGestureRecognizer
	{
		public var slop : uint = 50;

		protected var currentTouchPointID : int = -1;

		public function MoveGesture()
		{
		}

		protected function calculateDistance(context : TouchContext) : Number
		{
			var dx : Number = context.beginX - context.localX;
			var dy : Number = context.beginY - context.localY;

			return Math.sqrt( dx * dx - dy * dy );
		}

		override protected function internalOnTouchBegin( context : TouchContext ) : GestureState
		{
			if ( currentTouchPointID == -1 )
			{
				currentTouchPointID = context.touchPointID;
				return GestureStates.POSSIBLE;
			}
			else
			{
				return GestureStates.FAILED;
			}
		}

		override protected function internalOnTouchMove( context : TouchContext ) : GestureState
		{
			if ( context.touchPointID == currentTouchPointID )
			{
				if ( currentState == GestureStates.CHANGED || currentState == GestureStates.BEGAN )
				{
					return GestureStates.CHANGED;
				}
				else
				{
					if ( calculateDistance(context) > slop )
					{
						return GestureStates.BEGAN;
					}
					else
					{
						return null;
					}
				}
			}
			else
			{
				return GestureStates.FAILED;
			}
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : GestureState
		{
			if ( currentState == GestureStates.POSSIBLE )
			{
				return GestureStates.FAILED;
			}
			else
			{
				return GestureStates.RECOGNIZED;
			}
		}

		override protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			super.stateChanged( oldState, newState );

			if ( isGestureIsOver() )
			{
				currentTouchPointID = -1;
			}
		}
	}
}
