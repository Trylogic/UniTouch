package ru.trylogic.unitouch.gestures.abstract.states
{


	internal class BeganGestureState extends GestureState
	{
		public function BeganGestureState()
		{
			super( 2 );
		}

		override public function nextStateAllowed( nextState : GestureState ) : Boolean
		{
			return  nextState is ChangedGestureState;
		}

		override public function toString() : String
		{
			return "gestureBegan";
		}
	}
}
