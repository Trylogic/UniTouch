package ru.trylogic.unitouch.gestures.abstractGesture
{

	import flash.events.Event;

	import ru.trylogic.unitouch.gestures.abstractGesture.states.GestureStates;

	public class GestureEvent extends Event
	{
		public static const BEGAN : String = GestureStates.BEGAN.toString();
		public static const CHANGED : String = GestureStates.CHANGED.toString();
		public static const RECOGNIZED : String = GestureStates.RECOGNIZED.toString();
		public static const FAILED : String = GestureStates.FAILED.toString();
		public static const CANCELED : String = GestureStates.CANCELED.toString();
		public static const POSSIBLE : String = GestureStates.POSSIBLE.toString();

		public function GestureEvent( type : String )
		{
			super( type, false, false );
		}
	}
}
