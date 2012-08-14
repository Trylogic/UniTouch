package ru.trylogic.unitouch.gestures.abstract.states
{

	public class GestureState
	{
		private var _value : int;

		public function get value() : int
		{
			return _value;
		}

		public function GestureState( value : int )
		{
			this._value = value;
		}

		public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return false;
		}

		public function toString() : String
		{
			return "gestureState" + value.toString();
		}
	}
}
