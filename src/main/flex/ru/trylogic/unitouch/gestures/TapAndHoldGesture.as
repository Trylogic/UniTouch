package ru.trylogic.unitouch.gestures
{

	import flash.events.TimerEvent;

	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureState;

	import ru.trylogic.unitouch.gestures.abstract.states.GestureStates;

	public class TapAndHoldGesture extends TapGesture
	{
		public function TapAndHoldGesture()
		{
		}

		override protected function tapTimer_timerComplete(e : TimerEvent) : void
		{
			setState(GestureStates.RECOGNIZED);
		}

		override protected function internalOnTouchEnd(context : TouchContext) : GestureState
		{
			return GestureStates.FAILED;
		}
	}
}
