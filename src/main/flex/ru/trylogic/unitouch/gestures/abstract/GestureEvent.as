package ru.trylogic.unitouch.gestures.abstract
{

	import flash.events.Event;

	import ru.trylogic.unitouch.adapters.TouchContext;
	import ru.trylogic.unitouch.gestures.abstract.states.GestureStates;

	public class GestureEvent extends Event
	{
		public static const BEGAN : String = GestureStates.BEGAN.toString();
		public static const CHANGED : String = GestureStates.CHANGED.toString();
		public static const RECOGNIZED : String = GestureStates.RECOGNIZED.toString();
		public static const FAILED : String = GestureStates.FAILED.toString();
		public static const CANCELED : String = GestureStates.CANCELED.toString();

		protected var _touchContext : TouchContext;

		public function get touchContext() : TouchContext
		{
			return _touchContext;
		}

		public function GestureEvent( type : String, touchContext : TouchContext )
		{
			super( type, false, false );

			this._touchContext = touchContext;
		}
	}
}
