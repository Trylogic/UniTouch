package ru.trylogic.unitouch.gestures
{

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import ru.trylogic.unitouch.processor.TouchContext;
	import ru.trylogic.unitouch.gestures.abstractGesture.states.*;

	public class TapGesture extends MoveGesture
	{
		public var tapDelay : uint = 3000;
		protected var tapTimer : Timer;

		public function TapGesture()
		{
		}

		override protected function internalOnTouchMove( context : TouchContext ) : void
		{
			if ( context == currentTouchContext )
			{
				if ( checkSlop( context ) )
				{
					setState( GestureStates.FAILED );
				}
			}
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : void
		{
			if ( context == currentTouchContext )
			{
				setState( GestureStates.RECOGNIZED );
			}
		}

		override protected function stateChanged( oldState : GestureState, newState : GestureState ) : void
		{
			super.stateChanged( oldState, newState );

			if ( currentState == GestureStates.POSSIBLE && tapDelay != uint.MAX_VALUE )
			{
				tapTimer = new Timer( tapDelay, 1 );
				tapTimer.addEventListener( TimerEvent.TIMER_COMPLETE, tapTimer_timerComplete );
				tapTimer.start();
			}

			if ( isGestureIsOver() )
			{
				if ( tapTimer )
				{
					tapTimer.stop();
					tapTimer.reset();
					tapTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, tapTimer_timerComplete );
					tapTimer = null;
				}
			}
		}

		protected function tapTimer_timerComplete( event : TimerEvent ) : void
		{
			setState( GestureStates.FAILED );
		}
	}
}
