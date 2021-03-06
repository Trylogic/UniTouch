package ru.trylogic.unitouch.gestures
{

	import flash.events.TimerEvent;

	import ru.trylogic.unitouch.processor.TouchContext;
	import ru.trylogic.unitouch.gestures.abstractGesture.states.GestureStates;

	public class TapAndHoldGesture extends TapGesture
	{
		public function TapAndHoldGesture()
		{
		}

		override protected function tapTimer_timerComplete( e : TimerEvent ) : void
		{
			setState( GestureStates.RECOGNIZED );
		}

		override protected function internalOnTouchEnd( context : TouchContext ) : void
		{
			if ( context == currentTouchContext )
			{
				setState( GestureStates.FAILED );
			}
		}
	}
}
