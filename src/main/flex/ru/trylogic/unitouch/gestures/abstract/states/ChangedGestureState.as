package ru.trylogic.unitouch.gestures.abstract.states
{


	internal class ChangedGestureState extends GestureState
	{
		public function ChangedGestureState()
		{
			super( 4 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return  nextState is ChangedGestureState ||
					nextState is RecognizedGestureState ||
					nextState is CanceledGestureState;
		}

		override public function toString() : String
		{
			return "gestureChanged";
		}
	}
}
