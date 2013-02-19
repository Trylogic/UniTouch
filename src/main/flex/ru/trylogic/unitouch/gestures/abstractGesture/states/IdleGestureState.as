package ru.trylogic.unitouch.gestures.abstractGesture.states
{


	internal class IdleGestureState extends GestureState
	{
		public function IdleGestureState()
		{
			super( 64 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return nextState is PossibleGestureState;
		}

		override public function toString() : String
		{
			return "gestureIdle";
		}
	}
}
