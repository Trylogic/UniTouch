package ru.trylogic.unitouch.gestures.abstract.states
{


	internal class PossibleGestureState extends GestureState
	{
		public function PossibleGestureState()
		{
			super( 1 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return  nextState is RecognizedGestureState ||
					nextState is BeganGestureState;
		}

		override public function toString() : String
		{
			return "gesturePossible";
		}
	}
}
