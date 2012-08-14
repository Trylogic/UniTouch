package ru.trylogic.unitouch.gestures
{

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.states.*;

	public class TapGesture extends MoveGesture
	{
		protected var tapTimer : Timer = new Timer( 3000, 1 );

		public function TapGesture()
		{
			tapTimer.addEventListener( TimerEvent.TIMER_COMPLETE, tapTimer_timerComplete );
		}

		protected function tapTimer_timerComplete( event : TimerEvent ) : void
		{
			setState( GestureStates.FAILED );
		}

		override protected function internalOnTouchMove( context : TouchContext ) : GestureState
		{
			if ( context.touchPointID == currentTouchPointID )
			{
				if ( calculateDistance( context ) > slop )
				{
					return GestureStates.FAILED;
				}
				else
				{
					return null;
				}
			}
			else
			{
				return GestureStates.FAILED;
			}
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : GestureState
		{
			if ( context.touchPointID == currentTouchPointID )
			{
				return GestureStates.RECOGNIZED;
			}
			else
			{
				return GestureStates.FAILED;
			}
		}

		override protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			super.stateChanged( oldState, newState );

			if ( currentState == GestureStates.POSSIBLE )
			{
				tapTimer.start();
			}

			if ( isGestureIsOver() )
			{
				tapTimer.stop();
				tapTimer.reset();
			}
		}
	}
}
