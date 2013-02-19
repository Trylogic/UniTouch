package ru.trylogic.unitouch.gestures.abstractGesture.states
{

	internal class CanceledGestureState extends GestureState
	{
		public function CanceledGestureState()
		{
			super( 32 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return  nextState is PossibleGestureState;
		}

		override public function toString() : String
		{
			return "gestureCanceled";
		}
	}
}
