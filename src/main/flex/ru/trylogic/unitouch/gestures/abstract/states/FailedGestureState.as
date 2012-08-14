package ru.trylogic.unitouch.gestures.abstract.states
{


	internal class FailedGestureState extends GestureState
	{
		public function FailedGestureState()
		{
			super( 16 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return  nextState is PossibleGestureState;
		}

		override public function toString() : String
		{
			return "gestureFailed";
		}
	}
}
