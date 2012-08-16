package ru.trylogic.unitouch
{

	import ru.trylogic.unitouch.gestures.abstract.AbstractGestureRecognizer;

	public interface ITouchProcessor extends ITouchListener
	{
		function addGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void;

		function removeGestureRecognizer( gestureRecognizer : AbstractGestureRecognizer ) : void;

		function get numRecognizers() : uint;

		function dispose() : void;
	}
}
