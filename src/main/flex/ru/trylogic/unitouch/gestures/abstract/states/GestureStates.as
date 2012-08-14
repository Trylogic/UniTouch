package ru.trylogic.unitouch.gestures.abstract.states
{

	public class GestureStates
	{
		public static const POSSIBLE : GestureState = new PossibleGestureState();
		public static const BEGAN : GestureState = new BeganGestureState();
		public static const CHANGED : GestureState = new ChangedGestureState();
		public static const RECOGNIZED : GestureState = new RecognizedGestureState();
		public static const FAILED : GestureState = new FailedGestureState();
		public static const CANCELED : GestureState = new CanceledGestureState();
	}
}





