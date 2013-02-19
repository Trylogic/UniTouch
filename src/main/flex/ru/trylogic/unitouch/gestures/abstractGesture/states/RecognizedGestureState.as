package ru.trylogic.unitouch.gestures.abstractGesture.states
{

	internal class RecognizedGestureState extends GestureState
	{
		public function RecognizedGestureState()
		{
			super( 8 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return nextState is PossibleGestureState;
		}

		override public function toString() : String
		{
			return "gestureRecognized";
		}
	}
}
